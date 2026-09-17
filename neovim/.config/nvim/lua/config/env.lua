local M = {}

function M.mason_auto_install()
	local val = vim.env.NEOVIM_MASON_AUTO_INSTALL
	if not val or val == "" then
		return true
	end
	val = val:lower()
	return not (val == "0" or val == "false" or val == "no")
end

-- HTTP proxy URL for schema-fetching LSPs (like yamlls and jsonls). Necessary because not all tools respect $NO_PROXY like curl does.
function M.http_proxy_url()
	local val = vim.env.NEOVIM_HTTP_PROXY
	if not val or val == "" then
		return nil
	end
	return val
end

return M
