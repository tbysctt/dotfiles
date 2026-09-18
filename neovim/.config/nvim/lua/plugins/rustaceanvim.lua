-- Note that Rustaceanvim is intended to use rust-analyzer from your project's Rust toolchain.
-- Do not install rust-analyzer via Mason because the version drift from your project's Rust toolchain can cause issues.
-- When you need it, install it with: rustup component add rust-analyzer
vim.g.rustaceanvim = {
	server = {
		default_settings = {
			["rust-analyzer"] = {
				check = {
					command = "clippy",
				},
			},
		},
	},
}
