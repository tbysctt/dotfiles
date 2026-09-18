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
	-- "tsc", -- TS7 native LSP; revisit when workspace/diagnostic pull works (see README)
	"vtsls", -- Push diagnostics; works with workspace-diagnostics.nvim
	"biome",
	"eslint",
	"ruff",
	"intelephense",
	"yamlls",
	"gh_actions_ls", -- Hover/completion for GitHub Actions workflows
	"jsonls",
	"terraformls",
	"tailwindcss",
	"taplo",
	"basedpyright",
	"bashls",
	"docker_language_server",
}

-- Programmatic override: nvim-lspconfig's later rtp file would replace
-- filetypes/init_options from lsp/gh_actions_ls.lua (workflows use yaml.ghaction).
vim.lsp.config("gh_actions_ls", {
	filetypes = { "yaml", "yaml.ghaction" },
	init_options = {
		sessionToken = require("config.env").github_token(),
	},
})

vim.lsp.enable(enabled_servers)

-- Do not attach ESLint when the project uses Biome.
local eslint_root = vim.lsp.config.eslint.root_dir
vim.lsp.config("eslint", {
	root_dir = function(bufnr, on_dir)
		if vim.fs.root(bufnr, { "biome.json", "biome.jsonc" }) then
			return
		end
		if eslint_root then
			return eslint_root(bufnr, on_dir)
		end
	end,
})

-- LspAttach so shared logic is not overwritten by per-server on_attach.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("config.lsp", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end
		-- Workspace scan is heavy in JS/TS monorepos, buffer diagnostics are enough
		if client.name == "eslint" or client.name == "biome" or client.name == "gh_actions_ls" then
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
