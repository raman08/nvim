local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then return end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then return end

local icons = require("user.icons")

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
    hijack_directories = {enable = true, auto_open = true},
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {"startify", "dashboard", "alpha"},
    auto_reload_on_write = true,
    open_on_tab = false,
    hijack_cursor = false,
    sync_root_with_cwd = true,
    diagnostics = {
        enable = true,
        icons = {
            hint = icons.diagnostics.Hint,
            info = icons.diagnostics.Information,
            warning = icons.diagnostics.Warning,
            error = icons.diagnostics.Error,
        },
    },
    system_open = {cmd = nil, args = {}},
    update_focused_file = {enable = true, update_cwd = true, ignore_list = {}},
    filters = {
        dotfiles = false,
        custom = {".git", "node_modules"},
        exclude = {".gitignore", ".env"},
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":t",
        indent_markers = {
            enable = false,
            icons = {corner = "└ ", edge = "│ ", none = "  "},
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {file = true, folder = true, folder_arrow = true, git = true},
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = icons.ui.ArrowOpen,
                    arrow_closed = icons.ui.ArrowClosed,
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
        special_files = {
            "Cargo.toml",
            "Makefile",
            "README.md",
            "readme.md",
            "package.json",
            ".env",
        },
    },
    git = {enable = true, ignore = true, timeout = 500, show_on_dirs = true},
    view = {
        width = 30,
        hide_root_folder = false,
        side = "left",
        -- auto_resize = true,
        mappings = {
            custom_only = false,
            list = {
                {key = {"l", "<CR>", "o"}, cb = tree_cb "edit"},
                {key = "h", cb = tree_cb "close_node"},
                {key = "v", cb = tree_cb "vsplit"},
            },
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes",
    },
    trash = {cmd = "trash", require_confirm = true},
}
