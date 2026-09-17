local group = vim.api.nvim_create_augroup("config", { clear = true })

-- Flash the yanked range so the motion is obvious.
vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- Create missing parent directories so :w into a new path works.
vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	callback = function(event)
		if event.match:match("^%w+://") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Reload from disk when Neovim regains focus (requires autoread).
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = group,
	callback = function()
		if vim.bo.buftype == "" then
			vim.cmd.checktime()
		end
	end,
})

-- Equalise splits after the UI size changes.
vim.api.nvim_create_autocmd("VimResized", {
	group = group,
	callback = function()
		local tab = vim.api.nvim_get_current_tabpage()
		vim.cmd("tabdo wincmd =")
		vim.api.nvim_set_current_tabpage(tab)
	end,
})

-- Cursorline only in the active normal window.
vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave", "BufWinEnter" }, {
	group = group,
	callback = function(event)
		vim.wo.cursorline = event.event ~= "WinLeave" and vim.bo.buftype == ""
	end,
})

---@param fts string[]
---@param opts { expandtab: boolean, width: integer }
local function indent(fts, opts)
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = fts,
		callback = function()
			vim.bo.expandtab = opts.expandtab
			vim.bo.tabstop = opts.width
			vim.bo.shiftwidth = opts.width
			vim.bo.softtabstop = opts.width
		end,
	})
end

-- Tabs, matching gofmt/gofumpt.
indent({ "go", "gomod", "gowork", "gosum" }, { expandtab = false, width = 4 })
-- 2-space indent, common for JS/TS/HTML/CSS/JSON/YAML/Markdown.
indent({
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"json",
	"jsonc",
	"html",
	"css",
	"scss",
	"yaml",
	"markdown",
}, { expandtab = true, width = 2 })
