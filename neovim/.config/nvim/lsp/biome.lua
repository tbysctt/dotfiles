return {
	on_attach = function(client, _bufnr)
		-- Formatting stays with Conform (which will use biome-check).
		-- Biome LSP is diagnostics + code actions only.
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}
