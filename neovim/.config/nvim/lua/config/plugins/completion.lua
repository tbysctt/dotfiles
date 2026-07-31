require("blink.cmp").setup({
	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "single" } },
		menu = {
			border = "single",
			draw = {
				columns = {
					{ "item_idx" },
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
				},
				components = {
					item_idx = {
						text = function(ctx)
							return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
						end,
						highlight = "BlinkCmpItemIdx",
					},
				},
			},
		},
		accept = {
			-- Automatically insert brackets when completing a function/method
			auto_brackets = { enabled = true },
		},
	},

	snippets = { preset = "luasnip" },

	sources = {
		default = { "lsp", "snippets", "path", "buffer" },
	},

	fuzzy = {
		implementation = "rust",
		-- implementation = "lua",
	},

	signature = { enabled = true, window = { border = "single" } },
})
