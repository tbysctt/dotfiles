require("mason").setup({
	ui = { border = "rounded" },
})

local mason_packages = {
	-- Tree-sitter CLI (parsers still installed by nvim-treesitter)
	"tree-sitter-cli",

	-- LSPs
	"lua-language-server",
	"gopls",
	"ruff",
	"intelephense",
	"yaml-language-server",
	"terraform-ls",
	"tailwindcss-language-server",
	"taplo", -- TOML language server
	"basedpyright",
	"bash-language-server", -- Also used for ZSH
	"tsc",
	"vtsls", -- The LSP wrapper around the VSCode TypeScript extension

	-- Formatters for Conform (see config/plugins/conform.lua)
	"stylua",
	"prettier",
	"shfmt",
	"goimports",
	"gofumpt",
	"rustfmt",
	"biome",
	"pint",
	"php-cs-fixer",
	"terraform",
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

vim.keymap.set("n", "<leader>cm", function()
	vim.cmd("Mason")
end, { desc = "Mason" })
