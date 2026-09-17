local env = require("config.env")

return {
	settings = {
		yaml = {
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
