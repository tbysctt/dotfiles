-- Dependencies must be listed before dependents, vim.pack has no dep resolution

local github = function(repo)
	return "https://github.com/" .. repo
end

local plugins = {
	{ src = github("catppuccin/nvim"), name = "catppuccin" },

	github("echasnovski/mini.icons"),
	github("folke/ts-comments.nvim"),

	{
		src = github("Saghen/blink.cmp"),
		version = vim.version.range("1"), -- Pinned to v1.x for pre-built fuzzy binary
	},

	github("neovim/nvim-lspconfig"), -- I use Neovim's native vim.lsp, but this dep provides the lsp/<server>.lua config files that vim.lsp.enable() reads because the Neovim core ships none.

	{
		src = github("mrcjkb/rustaceanvim"), -- Rust LSP via rust-analyzer; do not also enable rust-analyzer with vim.lsp.enable
		version = vim.version.range("^9"), -- Maintainer recommends pinning to a version to avoid being surprised by breaking changes
	},

	github("mason-org/mason.nvim"),

	github("stevearc/conform.nvim"),
	github("mfussenegger/nvim-lint"),
	github("artemave/workspace-diagnostics.nvim"),

	github("nvim-lua/plenary.nvim"),

	{ src = github("nvim-treesitter/nvim-treesitter"), name = "nvim-treesitter", version = "main" },

	github("lewis6991/gitsigns.nvim"),
	github("MagicDuck/grug-far.nvim"),

	github("folke/flash.nvim"),
	github("folke/todo-comments.nvim"),
	github("folke/which-key.nvim"),
	github("folke/snacks.nvim"),
	github("folke/lazydev.nvim"),
	github("nvim-lualine/lualine.nvim"),

	github("windwp/nvim-autopairs"),
	github("kylechui/nvim-surround"),

	-- DAP (debugger); language helpers and UI depend on nvim-dap
	github("mfussenegger/nvim-dap"),
	github("leoluz/nvim-dap-go"),
	github("mfussenegger/nvim-dap-python"),
	{ src = github("igorlfs/nvim-dap-view"), version = vim.version.range("1") },

	github("nvim-neotest/nvim-nio"),
	github("nvim-neotest/neotest"),
	github("nvim-neotest/neotest-python"),
	github("nvim-neotest/neotest-jest"),
	github("marilari88/neotest-vitest"),
	github("akinsho/neotest-go"),
	github("thenbe/neotest-playwright"),
}

vim.pack.add(plugins)
