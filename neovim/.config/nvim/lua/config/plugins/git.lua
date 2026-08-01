local map = vim.keymap.set

require("gitsigns").setup({})

map("n", "]c", function()
	require("gitsigns").next_hunk()
end, { desc = "Next hunk" })

map("n", "[c", function()
	require("gitsigns").prev_hunk()
end, { desc = "Prev hunk" })

map("n", "<leader>hs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })

map("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })

map("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })

map("n", "<leader>hu", function()
	require("gitsigns").undo_stage_hunk()
end, { desc = "Unstage hunk" })

map("n", "<leader>gb", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })

require("grug-far").setup({})

map("n", "<leader>sr", function()
	require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Search/replace" })

map("x", "<leader>sr", function()
	require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "Search/replace selection" })
