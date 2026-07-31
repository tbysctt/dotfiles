-- Define the highlights in a way that persists across theme swaps
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		-- Make dotfiles look like normal text
		-- We have to grab 'fg' from 'Normal' and reconstruct the style to have no background because applying just "Normal" style puts an annoying dark background behind the text
		local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
		vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", {
			fg = normal_fg,
			bg = "none",
			force = true,
		})

		-- Make git-ignored files look grey/dimmed
		vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { link = "NonText", default = false })
	end,
})

-- Trigger it once immediately in case the colorscheme is already loaded
vim.api.nvim_exec_autocmds("ColorScheme", {})
