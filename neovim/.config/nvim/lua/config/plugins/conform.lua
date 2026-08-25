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
	format_on_save = {
		timeout_ms = 2500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {

		-- YAML/JSON/TOML/etc
		yaml = { "prettier" },
		toml = { "taplo" },
		json = biome_or({ "prettier" }),
		jsonc = biome_or({ "prettier" }),
		markdown = { "prettier" },

		-- Shell scripting
		sh = { "shfmt" },
		bash = { "shfmt" },
		zsh = { "shfmt" },

		-- Programming/Development
		lua = { "stylua" },
		go = { "goimports", "gofumpt" },
		rust = { "rustfmt" },
		python = { "ruff_organize_imports", "ruff_format" },
		php = { "pint", "php_cs_fixer", stop_after_first = true },
		terraform = { "terraform_fmt" },
		["terraform-vars"] = { "terraform_fmt" },
		javascript = biome_or({ "prettier" }),
		javascriptreact = biome_or({ "prettier" }),
		typescript = biome_or({ "prettier" }),
		typescriptreact = biome_or({ "prettier" }),
		html = biome_or({ "prettier" }),
		css = biome_or({ "prettier" }),
	},
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })
