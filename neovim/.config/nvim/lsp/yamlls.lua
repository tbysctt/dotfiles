local env = require("config.env")

return {
	settings = {
		yaml = {
			format = { enable = false }, -- conform.nvim handles formatting
			validate = true,
			hover = true,
			completion = true,
			schemaStore = { enable = true },
		},
		http = {
			proxy = env.http_proxy_url(),
			proxyStrictSSL = true,
		},
	},
}
