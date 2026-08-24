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
	"tsc", -- Use vtsls isntead if tsc isn't v7.x.x
	-- "vtsls", -- The LSP wrapper around the VSCode extension - only needed if tsc isn't v7.x.x
	"ruff",
	"intelephense",
	"yamlls",
	"terraformls",
	"tailwindcss",
	"taplo",
}

if vim.fn.executable("basedpyright-langserver") == 1 or vim.fn.executable("basedpyright") == 1 then
	table.insert(enabled_servers, "basedpyright")
end

vim.lsp.enable(enabled_servers)

require("config.lsp.keymaps")
