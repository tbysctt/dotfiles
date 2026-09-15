vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = { current_line = true },
	update_in_insert = false,
	float = {
		border = "rounded",
		source = true,
	},
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

local enabled_servers = {
	"lua_ls",
	"gopls",
	"tsc", -- Official native LSP included in TypeScript 7
	-- "vtsls", -- The LSP wrapper around the TypeScript VSCode extension
	"ruff",
	"intelephense",
	"yamlls",
	"jsonls",
	"terraformls",
	"tailwindcss",
	"taplo",
	"basedpyright",
	"bashls",
	"docker_language_server",
}

vim.lsp.enable(enabled_servers)

require("config.lsp.keymaps")

vim.lsp.config("*", {
	on_attach = function(client, bufnr)
		-- some clients support workspace diagnostics natively
		if client:supports_method("workspace/diagnostic", bufnr) then
			vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
		else
			require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
		end
	end,
})
