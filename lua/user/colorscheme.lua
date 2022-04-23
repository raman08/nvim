local colorscheme = "tokyonight"
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

-- vim.g.tokyonight_style = "day"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
