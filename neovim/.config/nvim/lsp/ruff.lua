-- Ruff for lint, format, and import organise; basedpyright owns hover/types/defs.
return {
	init_options = {
		settings = {
			logLevel = "error",
			lint = { enable = true },
		},
	},
	on_attach = function(client)
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.definitionProvider = false
	end,
}
