local status_ok, configs = pcall(require, "nvim-treesitter.configs")

if not status_ok then return end

configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = {""}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {""}, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    autopairs = {enable = true},
    indent = {enable = true, disable = {"yaml", "python", "css"}},
    context_commentstring = {enable = true, enable_autocmd = false},
    rainbow = {
        -- Setting colors
        enable = true,
        extended_modes = true,
        max_file_line = nil,
        colors = {
            "Gold",
            "Orchid",
            "DodgerBlue",
            "Cornsilk",
            "Salmon",
            "LawnGreen",
        },
        disable = {"html"},
    },
    autotag = {enable = true, disable = {"xml"}},
}
