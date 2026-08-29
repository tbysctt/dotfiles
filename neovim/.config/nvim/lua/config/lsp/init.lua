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
	-- "tsc", -- TypeScript 7+ LSP. Not available via Mason yet, so will need to be installed on the system
	"vtsls", -- The LSP wrapper around the TypeScript VSCode extension
	"ruff",
	"intelephense",
	"yamlls",
	"terraformls",
	"tailwindcss",
	"taplo",
	"basedpyright",
	"bashls",
}

vim.lsp.enable(enabled_servers)

require("config.lsp.keymaps")
