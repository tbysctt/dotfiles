return {
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			usePlaceholders = true,
			completeUnimported = true,
			analyses = { unusedparams = true, nilness = true, shadow = true },
		},
	},
}
