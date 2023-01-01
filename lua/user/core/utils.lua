local command = vim.api.nvim_create_user_command

function _G.reload_core()
	for name, _ in pairs(package.loaded) do
		if name:match("^user.core") or name:match("^user.theme") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
end

function _G.set_highlights(highlight)
	for name, colors in pairs(highlight) do
		if not vim.tbl_isempty(colors) then
			vim.api.nvim_set_hl(0, name, colors)
		end
	end
end

function _G.set_option(options)
	for name, value in pairs(options) do
		vim.opt[name] = value
	end
end

function _G.set_global(globals)
	for name, value in pairs(globals) do
		vim.g[name] = value
	end
end

function _G.update_config()
	local args = "git -C " .. vim.fn.stdpath("config") .. " pull --ff-only"
	vim.fn.system(args)
end

command("Reload", function()
	if vim.bo.buftype == "" then
		reload_core()
		vim.notify("Core Reload Done", vim.log.levels.INFO)
	else
		vim.notify("Not available in this window/buffer", vim.log.levels.INFO)
	end
end, { nargs = "*" })

command("Update", function()
	update_config()
	vim.notify("Update Done", vim.log.levels.INFO)
end, { nargs = "*" })

command("LuaSnipEdit", function()
	require("luasnip.loaders").edit_snippet_files()
end, { nargs = "*" })
