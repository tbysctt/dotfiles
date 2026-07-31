local ts = require("nvim-treesitter")

local ensure_installed = {
	"lua",
}

ts.install(ensure_installed)

local filetype_to_lang = {
	typescriptreact = "tsx",
	javascriptreact = "javascript",
}

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
	callback = function(event)
		local ft = vim.bo[event.buf].filetype
		local lang = filetype_to_lang[ft] or ft

		if not pcall(vim.treesitter.language.add, lang) then
			return
		end

		pcall(vim.treesitter.start, event.buf, lang)
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
