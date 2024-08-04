local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

which_key.add({
	{
		{ "<leader>C",  group = "Rust",                     nowait = true,             remap = false },
		{
			"<leader>CD",
			"<cmd>lua require'crates'.show_dependencies_popup()<cr>",
			desc = "[crates] show dependencies",
			nowait = true,
			remap = false,
		},
		{
			"<leader>CP",
			"<cmd>lua require'crates'.show_popup()<cr>",
			desc = "[crates] show popup",
			nowait = true,
			remap = false,
		},
		{ "<leader>CR", "<cmd>RustLsp reloadWorkspace<Cr>", desc = "Reload Workspace", nowait = true, remap = false },
		{ "<leader>Cc", "<cmd>RustLsp openCargo<Cr>",       desc = "Open Cargo",       nowait = true, remap = false },
		{ "<leader>Cd", "<cmd>RustLsp debuggables<Cr>",     desc = "Debuggables",      nowait = true, remap = false },
		{
			"<leader>Cf",
			"<cmd>lua require'crates'.show_features_popup()<cr>",
			desc = "[crates] show features",
			nowait = true,
			remap = false,
		},
		{
			"<leader>Ci",
			"<cmd>lua require'crates'.show_crate_popup()<cr>",
			desc = "[crates] show info",
			nowait = true,
			remap = false,
		},
		{ "<leader>Cm", "<cmd>RustLsp expandMacro<Cr>",  desc = "Expand Macro",       nowait = true, remap = false },
		{ "<leader>Co", "<cmd>RustLsp externalDocs<Cr>", desc = "Open External Docs", nowait = true, remap = false },
		{ "<leader>Cp", "<cmd>RustLsp parentModule<Cr>", desc = "Parent Module",      nowait = true, remap = false },
		{ "<leader>Cr", "<cmd>RustLsp runnables<Cr>",    desc = "Runnables",          nowait = true, remap = false },
		{ "<leader>Ct", "<cmd>lua _CARGO_TEST()<cr>",    desc = "Cargo Test",         nowait = true, remap = false },
		{
			"<leader>Cu",
			"<cmd>lua require('crates').upgrade_crate()<cr>",
			desc = "[crates] Upgrade Crate",
			nowait = true,
			remap = false,
		},
		{ "<leader>Cv", "<cmd>RustLsp crateGraph<Cr>", desc = "View Crate Graph", nowait = true, remap = false },
		{
			"<leader>Cy",
			"<cmd>lua require'crates'.open_repository()<cr>",
			desc = "[crates] open repository",
			nowait = true,
			remap = false,
		},
	},
})
