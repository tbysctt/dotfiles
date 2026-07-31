require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lsp", "snippets", "path", "buffer" },
	},
	fuzzy = {
		implementation = "rust",
		-- implementation = "lua",
	},
	completion = {
        accept = {
            -- Automatically insert brackets when completing a function/method
            auto_brackets = { enabled = true },
        },
    },
})
