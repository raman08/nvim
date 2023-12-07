local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

local mappings = {
	C = {
		name = "Rust",
		d = { "<cmd>RustLsp debuggables<Cr>", "Debug Code" },
		r = { "<cmd>RustLsp runnables <Cr>", "Runnables" },
	},
}

which_key.register(mappings, opts)
