local M = {
	"saghen/blink.cmp",
	version = "v1.*",
	-- build = "cargo build --release",
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- { "saadparwaiz1/cmp_luasnip" },
		{ "L3MON4D3/LuaSnip", version = "v2.*" },

		{
			"saghen/blink.compat",
			opts = { impersonate_nvim_cmp = true },
			version = "*",
		},
	},
	event = "InsertEnter",
}

function M.config()
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	local opts = {
		keymap = {
			preset = "enter",
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
		},
		appearance = {
			-- sets the fallback highlight groups to nvim-cmp's highlight groups
			-- useful for when your theme doesn't support blink.cmp
			-- will be removed in a future release, assuming themes add support
			use_nvim_cmp_as_default = true,
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		completion = {
			accept = {
				-- experimental auto-brackets support
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
				border = "single",
				auto_show = function(ctx)
					return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
				end,
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "single",
				},
			},
			ghost_text = {
				enabled = true,
			},
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
		},
		-- experimental signature help support
		signature = {
			enabled = true,
			window = {
				border = "single",
			},
		},

		sources = {
			default = { "lazydev", "lsp", "luasnip", "path", "snippets", "buffer" },
			-- cmdline = {},
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
			},
		},
		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},
	}

	require("blink.cmp").setup(opts)
end

return M
