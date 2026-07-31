require("nvim-autopairs").setup({
    check_ts = true, -- Optional: Uses Treesitter to check for pairs (highly recommended)
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
})
