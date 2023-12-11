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
		r = { "<cmd>RustLsp runnables<Cr>", "Runnables" },
		t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
		m = { "<cmd>RustLsp expandMacro<Cr>", "Expand Macro" },
		c = { "<cmd>RustLsp openCargo<Cr>", "Open Cargo" },
		p = { "<cmd>RustLsp parentModule<Cr>", "Parent Module" },
		d = { "<cmd>RustLsp debuggables<Cr>", "Debuggables" },
		v = { "<cmd>RustLsp crateGraph<Cr>", "View Crate Graph" },
		R = {
			"<cmd>RustLsp reloadWorkspace<Cr>",
			"Reload Workspace",
		},
		o = { "<cmd>RustLsp externalDocs<Cr>", "Open External Docs" },

		y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
		P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
		i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
		f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
		D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
		u = { "<cmd>lua require('crates').upgrade_crate()<cr>", "[crates] Upgrade Crate" },
	},
}

which_key.register(mappings, opts)
