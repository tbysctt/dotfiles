local ts = require("nvim-treesitter")

local installed_parsers = {
	"lua",
	"go",
	"gomod",
	"gosum",
	"gowork",
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
	"markdown_inline",
	"html",
	"css",
	"bash",
	"toml",
	"sql",
	"dockerfile",
	"gitcommit",
	"vim",
	"vimdoc",
}

ts.install(installed_parsers)

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
	callback = function(event)
		-- Determine Tree-sitter language
		local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)

		if not lang or not pcall(vim.treesitter.language.add, lang) then
			-- No parser is installed/loadable
			return
		end

		if not vim.treesitter.query.get(lang, "highlights") then
			-- There is no highlights.scm query. Bail out so legacy syntax stil works
			return
		end

		-- Enable Tree-sitter highlighting in the buffer
		pcall(vim.treesitter.start, event.buf, lang)
	end,
})

-- Keep parsers in lockstep with the plugin (nvim-treesitter main branch requirement)
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("user_treesitter_update", { clear = true }),
	callback = function(event)
		if event.data.kind == "update" and event.data.spec.name == "nvim-treesitter" then
			require("nvim-treesitter").update()
		end
	end,
})
