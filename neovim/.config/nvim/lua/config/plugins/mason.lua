require("mason").setup({
	ui = { border = "rounded" },
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"gopls",
		"ruff",
		"intelephense",
		"yamlls",
		"terraformls",
		"tailwindcss",
		"taplo",
		"basedpyright",
		"bashls",
		"vtsls",
	},
	automatic_enable = false, -- enable stays in config.lsp
})

vim.keymap.set("n", "<leader>cm", function()
	vim.cmd("Mason")
end, { desc = "Mason" })
