local function has_biome(bufnr)
	return vim.fs.root(bufnr, { "biome.json", "biome.jsonc" }) ~= nil
end

-- biome-check when the project opted into Biome; prettier otherwise. Runs format + save lint fixes + import sort.
local function biome_or(fallback)
	return function(bufnr)
		return has_biome(bufnr) and { "biome-check" } or fallback
	end
end

require("conform").setup({
	default_format_opts = {
		lsp_format = "fallback", -- If no formatter is configured for the file type, fall back to the LSP (if one is available)
	},
	format_on_save = {
		timeout_ms = 1000,
	},
	formatters_by_ft = {

		-- YAML/JSON/TOML/etc
		yaml = { "prettier" },
		toml = {
			lsp_format = "prefer",
			name = "taplo",
		},
		json = biome_or({ "prettier" }),
		jsonc = biome_or({ "prettier" }),

		-- Shell scripting
		sh = {
			lsp_format = "prefer",
			name = "bashls",
		},
		bash = {
			lsp_format = "prefer",
			name = "bashls",
		},
		zsh = {
			lsp_format = "prefer",
			name = "bashls",
		},

		-- Programming/Development
		lua = {
			"stylua",
			lsp_format = "fallback",
			name = "lua_ls",
		},
		go = {
			lsp_format = "prefer",
			name = "gopls",
		},
		rust = {
			lsp_format = "prefer",
			name = "rust-analyzer",
		},
		python = {
			"ruff_organize_imports",
			lsp_format = "last",
			name = "ruff",
		},
		php = { "pint", "php_cs_fixer", stop_after_first = true },
		javascript = biome_or({ "prettier" }),
		javascriptreact = biome_or({ "prettier" }),
		typescript = biome_or({ "prettier" }),
		typescriptreact = biome_or({ "prettier" }),

		-- Others
		markdown = { "prettier" },
		html = biome_or({ "prettier" }),
		css = biome_or({ "prettier" }),
		terraform = { "terraform_fmt" },
		["terraform-vars"] = { "terraform_fmt" },
	},
})

vim.keymap.set({ "n", "x" }, "<leader>cf", function()
	require("conform").format({
		async = true, -- Good for manually triggered buffer formats, doesn't block the Neovim UI
	})
end, { desc = "Format buffer (or visual selection)" })
