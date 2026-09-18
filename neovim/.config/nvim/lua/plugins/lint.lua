vim.filetype.add({
	pattern = {
		[".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghaction",
	},
})

require("lint").linters_by_ft = {
	dockerfile = { "hadolint" },
	lua = { "selene" },
	sh = { "shellcheck" },
	bash = { "shellcheck" },
	go = { "golangcilint" },
	["yaml.ghaction"] = { "actionlint" },
	terraform = { "tflint" },
	tf = { "tflint" },
	["terraform-vars"] = { "tflint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "BufReadPost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("config.lint", { clear = true }),
	callback = function()
		require("lint").try_lint()
	end,
})
