require "user.options"
require "user.keymaps"
require "user.plugin"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.impatient"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.colorized"
require "user.session-manager"
require "user.renamer"
require "user.symbol-outline"
require "user.matchup"
require "user.git-blame"
require "user.compitest"
require "user.vimspector"
-- require "user.dap"
-- require "user.gist"
-- require "user.ts-context"
-- require "user.leetcode"
-- require "user.quickscope"

if (vim.g.vscode) then
	require "user.vscode"
end

