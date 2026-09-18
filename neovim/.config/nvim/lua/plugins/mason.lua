require("mason").setup({
	ui = { border = "rounded" },
})

if require("config.env").mason_auto_install() then
	local mason_packages = {
		-- Tree-sitter CLI (parsers still installed by nvim-treesitter)
		"tree-sitter-cli",

		-- LSPs
		"lua-language-server",
		"gopls",
		"ruff",
		"intelephense",
		"yaml-language-server",
		"json-lsp",
		"terraform-ls",
		"tailwindcss-language-server",
		"taplo", -- TOML language server
		"basedpyright",
		"bash-language-server", -- Also used for ZSH
		"shfmt", -- Used by bash-language-server for formatting
		"tsc",
		"vtsls", -- The LSP wrapper around the VSCode TypeScript extension
		"eslint-lsp", -- vscode-eslint-language-server (diagnostics; project eslint)
		"docker-language-server",

		-- Formatters for Conform (see plugins/conform.lua)
		"stylua",
		"prettier",
		"biome",
		"pint",
		"php-cs-fixer",
		"terraform",

		-- Linters for nvim-lint
		"hadolint",
		"selene",
		"shellcheck",
		"golangci-lint",
		"actionlint",
		"tflint",

		-- DAP adapters (see plugins/dap.lua)
		"delve",
		"debugpy",
	}

	local registry = require("mason-registry")

	registry.refresh(function()
		for _, name in ipairs(mason_packages) do
			if registry.has_package(name) then
				local pkg = registry.get_package(name)
				if not pkg:is_installed() then
					pkg:install()
				end
			end
		end
	end)
end

vim.keymap.set("n", "<leader>cm", function()
	vim.cmd("Mason")
end, { desc = "Mason" })
