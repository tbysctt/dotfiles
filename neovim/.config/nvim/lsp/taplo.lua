return {
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false -- conform.nvim handles formatting
	end,
}
