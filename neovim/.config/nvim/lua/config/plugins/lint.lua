local lint = require("lint")

lint.linters_by_ft = {
	dockerfile = { "hadolint" },
}

-- Create autocompletion/autocmd to trigger linting on save or enter
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})
