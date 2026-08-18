-- Ruff for lint + import organise; basedpyright owns hover/types/defs.
-- Formatting is handled by conform.nvim via ruff_format.
return {
	init_options = {
		settings = {
			logLevel = "error",
			format = { enable = false }, -- conform.nvim handles formatting
			lint = { enable = true },
		},
	},
	on_attach = function(client)
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.definitionProvider = false
	end,
}
