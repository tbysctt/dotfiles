-- TODO: NOT EXACT YET

local Snacks = require("snacks")
local gitsigns = require("gitsigns")
local map = vim.keymap.set

Snacks.setup({
	picker = {
		sources = {
			explorer = {
				hidden = true,
				layout = { preset = "default", focus = "list" },
				jump = { close = true },
			},
			files = {
				hidden = true,
				ignored = false,
			},
		},
	},
	bigfile = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scroll = { enabled = true }, -- Smooth scrolling
	statuscolumn = { enabled = true },
	words = { enabled = true }, -- Uses LSP to highlight references to the symber under the cursor
	indent = { enabled = true }, -- Draws a vertical line to highlight the scope the cursor is currently inside
	toggle = { map = vim.keymap.set },
})

-- Snacks toggles under <leader>u
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.inlay_hints():map("<leader>uh")

-- Explorer and files

map("n", "<leader>e", function()
	Snacks.picker.explorer()
end, { desc = "Explorer" })

map("n", "<leader><space>", function()
	Snacks.picker.files()
end, { desc = "Files" })

map("n", "<leader>bb", function()
	Snacks.picker.buffers()
end, { silent = true, desc = "Buffers" })

-- Grep

map({ "n", "x" }, "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "Grep word" })

map("n", "<leader>sg", function()
	Snacks.picker.grep()
end, { silent = true, desc = "Grep" })

-- GIT

map("n", "<leader>gl", function()
	Snacks.picker.git_log()
end, { silent = true, desc = "Git log" })

map("n", "<leader>gB", function()
	gitsigns.toggle_current_line_blame()
end, { silent = true, desc = "Toggle blame" })

map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { silent = true, desc = "Lazygit" })
