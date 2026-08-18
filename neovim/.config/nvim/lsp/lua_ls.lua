return {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME, "${3rd}/lua/library" },
			},
			diagnostics = { globals = { "vim" } },
			completion = { callSnippet = "Replace" },
		},
	},
}
