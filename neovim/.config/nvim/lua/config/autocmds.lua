local group = vim.api.nvim_create_augroup("config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	callback = function(event)
		local exclude = { gitcommit = true, gitrebase = true, hgcommit = true, svn = true }
		local ft = vim.bo[event.buf].filetype
		if exclude[ft] or vim.bo[event.buf].buftype ~= "" then
			return
		end

		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(event.buf) then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "markdown", "txt", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})

-- Go uses tabs (gofmt/gofumpt)
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "go", "gomod", "gowork", "gosum" },
	callback = function()
		vim.bo.expandtab = false
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
	end,
})

-- Web languages commonly use 2-space indent
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = {
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
	},
	callback = function()
		vim.bo.expandtab = true
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
	end,
})
