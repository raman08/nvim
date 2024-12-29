require("user.plugins.launch")

require("user.options")
require("user.keymaps")

--require("user.autocommands")

-- coding
spec("user.plugins.autopairs")
spec("user.plugins.ts-comments")
spec("user.plugins.gitsigns")
spec("user.plugins.blink")
spec("user.plugins.dap")
spec("user.plugins.renamer")
spec("user.plugins.comment")

-- languages
spec("user.plugins.schemastore")
spec("user.plugins.crates")
spec("user.plugins.rustaceanvim")
spec("user.plugins.lazydev")

--UI
spec("user.plugins.colorscheme")
spec("user.plugins.nvimtree")
spec("user.plugins.lualine")
spec("user.plugins.navic")
spec("user.plugins.breadcrums")

-- Editor
spec("user.plugins.flash")
spec("user.plugins.whichkey")
spec("user.plugins.todo-comments")
spec("user.plugins.telescope")
spec("user.plugins.dial")
spec("user.plugins.harpoon")
spec("user.plugins.treesitter")
spec("user.plugins.nvim-ts-autotags")
spec("user.plugins.snacks")
spec("user.plugins.illuminate")
spec("user.plugins.project")
spec("user.plugins.cybu")
spec("user.plugins.fidget")
spec("user.plugins.nvim-ufo")
spec("user.plugins.fugitive")

-- LSP and support
spec("user.plugins.lsp.lsp-config")
spec("user.plugins.lsp.mason")
spec("user.plugins.none-ls")

require("user.lazy")
