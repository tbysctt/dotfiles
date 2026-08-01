local ts = require("nvim-treesitter")

local ensure_installed = {
	"lua",
	"go",
	"python",
	"typescript",
	"tsx",
	"javascript",
	"rust",
	"php",
	"phpdoc",
	"hcl",
	"terraform",
	"json",
	"yaml",
	"markdown",
	"html",
	"vim",
	"vimdoc",
}

ts.install(ensure_installed)

vim.treesitter.language.register("tsx", "typescriptreact")
vim.treesitter.language.register("javascript", "javascriptreact")

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
	callback = function(event)
		local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)

		if not lang or not pcall(vim.treesitter.language.add, lang) then
			return
		end

		pcall(vim.treesitter.start, event.buf, lang)
		vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
