-- Dependencies must be listed before dependents, vim.pack has no dep resolution

local gh = function(repo)
	return "https://github.com/" .. repo
end

vim.pack.add({
	{ src = gh("catppuccin/nvim"), name = "catppuccin" },

	gh("nvim-lua/plenary.nvim"),
	gh("echasnovski/mini.icons"),

	{ src = gh("L3MON4D3/LuaSnip"), name = "luasnip" },

	{ src = gh("Saghen/blink.cmp"), version = vim.version.range("1")}, -- Pinned to v1.x for pre-built fuzzy binary
	
	gh("neovim/nvim-lspconfig"), -- I use Neovim's native vim.lsp, but this dep provides the lsp/<server>.lua config files that vim.lsp.enable() reads because the Neovim core ships none.

	{ src = gh("mrcjkb/rustaceanvim"), version = vim.version.range("5") },

	gh("stevearc/conform.nvim"),

	{ src = gh("nvim-treesitter/nvim-treesitter"), version = vim.version.range("main") },

	gh("lewis6991/gitsigns.nvim"),
	gh("MagicDuck/grug-far.nvim"),

	gh("folke/todo-comments.nvim"),
	gh("folke/which-key.nvim"),
	gh("folke/snacks.nvim"),
	gh("nvim-lualine/lualine.nvim"),

	gh("windwp/nvim-autopairs"),
	
	gh("nvim-neotest/nvim-nio"),
	gh("nvim-neotest/neotest"),
	gh("nvim-neotest/neotest-python"),
	gh("nvim-neotest/neotest-jest"),
	gh("marilari88/neotest-vitest"),
	gh("thenbe/neotest-playwright"),
})
