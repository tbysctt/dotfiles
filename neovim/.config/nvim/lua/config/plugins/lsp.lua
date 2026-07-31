local Snacks = require("snacks")

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})


