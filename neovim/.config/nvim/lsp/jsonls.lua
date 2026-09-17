local env = require("config.env")

return {
	settings = {
		json = {
			validate = { enable = true },
		},
		http = {
			proxy = env.http_proxy_url(),
			proxyStrictSSL = true,
		},
	},
}
