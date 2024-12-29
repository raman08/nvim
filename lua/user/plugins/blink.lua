local M = {
	"saghen/blink.cmp",
	version = "*",
	build = "cargo build --release",
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
			enabled = true,
			min_width = 15,
			max_height = 10,
			border = "none",
			scrollbar = false,
			accept = {
				-- experimental auto-brackets support
				--
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
				border = "padded",
			},
			documentation = {
				auto_show = false,
				auto_show_delay_ms = 200,
			},
			ghost_text = {
				enabled = true,
			},
			list = {
				selection = "auto_insert", --| "auto_insert",
			},
		},
		-- experimental signature help support
		signature = { enabled = true },

		sources = {
			default = { "lazydev", "lsp", "luasnip", "path", "snippets", "buffer" },
			cmdline = {},
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

	-- setup compat sources
	-- local enabled = opts.sources.default
	-- for _, source in ipairs(opts.sources.compat or {}) do
	-- 	opts.sources.providers[source] = vim.tbl_deep_extend(
	-- 		"force",
	-- 		{ name = source, module = "blink.compat.source" },
	-- 		opts.sources.providers[source] or {}
	-- 	)
	-- 	if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
	-- 		table.insert(enabled, source)
	-- 	end
	-- end

	-- opts.sources.completion = opts.sources.completion or {}
	-- opts.sources.completion.enabled_providers = enabled
	-- if vim.tbl_get(opts, "completion", "menu", "draw", "treesitter") then
	-- 	---@diagnostic disable-next-line: assign-type-mismatch
	-- 	opts.completion.menu.draw.treesitter = true
	-- end

	-- -- Unset custom prop to pass blink.cmp validation
	-- opts.sources.compat = nil

	-- -- check if we need to override symbol kinds
	-- for _, provider in pairs(opts.sources.providers or {}) do
	-- 	if provider.kind then
	-- 		local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
	-- 		local kind_idx = #CompletionItemKind + 1

	-- 		CompletionItemKind[kind_idx] = provider.kind
	-- 		---@diagnostic disable-next-line: no-unknown
	-- 		CompletionItemKind[provider.kind] = kind_idx

	-- 		local transform_items = provider.transform_items
	-- 		provider.transform_items = function(ctx, items)
	-- 			items = transform_items and transform_items(ctx, items) or items
	-- 			for _, item in ipairs(items) do
	-- 				item.kind = kind_idx or item.kind
	-- 			end
	-- 			return items
	-- 		end

	-- 		-- Unset custom prop to pass blink.cmp validation
	-- 		provider.kind = nil
	-- 	end
	-- end

	require("blink.cmp").setup(opts)
end

return M
