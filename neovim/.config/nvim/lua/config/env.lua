local M = {}

function M.use_mason()
	local v = vim.env.NEOVIM_USE_MASON
	if not v or v == "" then
		return true
	end
	v = v:lower()
	return not (v == "0" or v == "false" or v == "no")
end

return M
