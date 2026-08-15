local map = vim.keymap.set
local gs = require("gitsigns")

gs.setup({
	current_line_blame = true,
})

map("n", "]c", function()
	gs.nav_hunk("next")
end, { silent = true, desc = "Next hunk" })

map("n", "[c", function()
	gs.nav_hunk("prev")
end, { silent = true, desc = "Prev hunk" })

map("n", "<leader>hs", function()
	gs.stage_hunk()
end, { silent = true, desc = "Stage hunk" })

map("v", "<leader>hs", function()
	gs.stage_hunk({ vim.fn.line("v"), vim.fn.line(".") })
end, { silent = true, desc = "Stage hunk" })

map("n", "<leader>hr", function()
	gs.reset_hunk()
end, { silent = true, desc = "Reset hunk" })

map("v", "<leader>hr", function()
	gs.reset_hunk({ vim.fn.line("v"), vim.fn.line(".") })
end, { silent = true, desc = "Reset hunk" })

map("n", "<leader>hp", function()
	gs.preview_hunk()
end, { silent = true, desc = "Preview hunk" })

-- stage_hunk on an already-staged hunk unstages it (replaces undo_stage_hunk)
map("n", "<leader>hu", function()
	gs.stage_hunk()
end, { silent = true, desc = "Toggle stage hunk" })

map("n", "<leader>gb", function()
	gs.blame_line({ full = true })
end, { silent = true, desc = "Blame line" })

map("n", "<leader>gB", function()
	gs.toggle_current_line_blame()
end, { silent = true, desc = "Toggle blame" })

require("grug-far").setup({})

map("n", "<leader>sr", function()
	require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { silent = true, desc = "Search/replace" })

map("x", "<leader>sr", function()
	require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
end, { silent = true, desc = "Search/replace selection" })
