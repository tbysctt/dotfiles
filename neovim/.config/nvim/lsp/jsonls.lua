local env = require("config.env")

return {
	init_options = {
		provideFormatter = false, -- conform.nvim handles formatting
	},
	settings = {
		json = {
			format = { enable = false },
			validate = { enable = true },
		},
		http = {
			proxy = env.http_proxy_url(),
			proxyStrictSSL = true,
		},
	},
}
