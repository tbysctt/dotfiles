require("lazydev").setup({
	integrations = {
		lspconfig = false, -- default root_dir override breaks lua_ls attach
	},
})
