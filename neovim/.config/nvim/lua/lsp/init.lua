vim.o.winborder = "rounded"

vim.diagnostic.config({
	-- virtual_text = true,
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
	"eslint",
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

-- LspAttach so shared logic is not overwritten by per-server on_attach.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("config.lsp", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end
		-- ESLint buffer diagnostics are enough; workspace scan is heavy in JS monorepos.
		if client.name == "eslint" then
			return
		end
		local bufnr = event.buf
		-- some clients support workspace diagnostics natively
		if client:supports_method("workspace/diagnostic", bufnr) then
			vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
		else
			require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
		end
	end,
})
