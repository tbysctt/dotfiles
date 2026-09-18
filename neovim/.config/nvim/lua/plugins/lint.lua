require("lint").linters_by_ft = {
	dockerfile = { "hadolint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "BufReadPost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("config.lint", { clear = true }),
	callback = function()
		require("lint").try_lint()
	end,
})
