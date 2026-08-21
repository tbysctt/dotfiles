return {
	root_dir = function(bufnr, on_dir)
		local config = vim.fn.stdpath("config")
		local fname = vim.api.nvim_buf_get_name(bufnr)
		if vim.startswith(fname, config) then
			on_dir(config)
			return
		end
		on_dir(vim.fs.root(bufnr, { ".git", ".luarc.json", ".luarc.jsonc" }))
	end,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = { checkThirdParty = false },
		},
	},
}
