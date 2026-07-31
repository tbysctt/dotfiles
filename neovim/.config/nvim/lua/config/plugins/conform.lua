require("conform").setup({
	-- format_on_save
	formatters_by_ft = {
		lua = { "stylua" },
	}
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })
