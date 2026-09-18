local Snacks = require("snacks")

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
	words = { enabled = true }, -- Uses LSP to highlight references to the symbol under the cursor
	indent = { enabled = true }, -- Draws a vertical line to highlight the scope the cursor is currently inside
	toggle = { map = vim.keymap.set },
	styles = {
		lazygit = {
			border = "rounded",
		},
	},
})

-- Snacks toggles under <leader>u
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.inlay_hints():map("<leader>uh")

-- Explorer and files

vim.keymap.set("n", "<leader>e", function()
	Snacks.picker.explorer()
end, { desc = "Explorer" })

vim.keymap.set("n", "<leader><space>", function()
	Snacks.picker.files()
end, { desc = "Files" })

vim.keymap.set("n", "<leader>,", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })

-- Grep

vim.keymap.set({ "n", "x" }, "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "Grep word" })

vim.keymap.set("n", "<leader>sg", function()
	Snacks.picker.grep({ hidden = true })
end, { silent = true, desc = "Grep (include hidden files)" })

vim.keymap.set("n", "<leader>sG", function()
	Snacks.picker.grep({ hidden = true, ignored = true })
end, { silent = true, desc = "Grep (include hidden and git-ignored files)" })

-- GIT

vim.keymap.set("n", "<leader>gl", function()
	Snacks.picker.git_log()
end, { silent = true, desc = "Git log" })
-- vim.keymap.set("n", "<leader>gl", function()
-- 	Snacks.picker.git_log()
-- end, { desc = "Git Log" })

vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit()
end, { silent = true, desc = "Lazygit" })

vim.keymap.set("n", "<leader>gb", function()
	Snacks.picker.git_log_line()
end, { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gf", function()
	Snacks.picker.git_log_file()
end, { desc = "Git Current File History" })
vim.keymap.set({ "n", "x" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })
vim.keymap.set({ "n", "x" }, "<leader>gY", function()
	Snacks.gitbrowse({
		open = function(url)
			vim.fn.setreg("+", url)
		end,
		notify = false,
	})
end, { desc = "Git Browse (copy)" })
