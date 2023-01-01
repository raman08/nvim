local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
	return
end

local icons = require("user.icons")

local winbar_filetype_exclude = {
	"help",
	"startify",
	"dashboard",
	"packer",
	"neo-tree",
	"neogitstatus",
	"NvimTree",
	"Trouble",
	"alpha",
	"lir",
	"Outline",
	"spectre_panel",
	"toggleterm",
	"DressingSelect",
	"Jaq",
	"harpoon",
	"dap-repl",
	"dap-terminal",
	"dapui_console",
	"lab",
	"Markdown",
	"",
}

navic.setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = " ",
		Interface = " ",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = " ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = " ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = true,
	separator = " " .. icons.ui.ChevronRight .. " ",
	depth_limit = 0,
	depth_limit_indicator = "..",
})
