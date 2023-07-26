local status_harpoon_ok, harpoon = pcall(require, "harpoon")
if not status_harpoon_ok then
	return
end

local status_telescope_ok, telescope = pcall(require, "telescope")
if not status_telescope_ok then
	return
end

harpoon.setup({})

telescope.load_extension("harpoon")
