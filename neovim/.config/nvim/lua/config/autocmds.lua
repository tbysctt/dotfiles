local group = vim.api.nvim_create_augroup("config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- TODO: Auto-create parent directories on save with BufWritePre
-- TODO: Equalise splits when Vim is resized
-- TODO: Reload files when they change on disk, use FocusGained

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
