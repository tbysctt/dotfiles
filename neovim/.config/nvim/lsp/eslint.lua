-- Diagnostics + code actions only. Formatting stays with Prettier/Biome via Conform.
return {
	settings = {
		format = false,
		codeActionOnSave = { enable = false },
	},
	on_attach = function(client, _bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}
