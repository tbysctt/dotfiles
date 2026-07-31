local ts = require("nvim-treesitter")

local ensure_installed = {
	"lua",
}

ts.install(ensure_installed)
