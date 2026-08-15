local ts = require("nvim-treesitter")

local ensure_installed = {
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
	"html",
	"vim",
	"vimdoc",
}

ts.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
	callback = function(event)
		local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)

		if not lang or not pcall(vim.treesitter.language.add, lang) then
			return
		end

		-- Bail out when highlights queries are missing so legacy syntax still works
		if not vim.treesitter.query.get(lang, "highlights") then
			return
		end

		pcall(vim.treesitter.start, event.buf, lang)
		vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
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
