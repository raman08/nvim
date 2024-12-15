local M = {
	"saghen/blink.cmp",
	version = not vim.g.lazyvim_blink_main and "*",
	build = vim.g.lazyvim_blink_main and "cargo build --release",
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- { "saadparwaiz1/cmp_luasnip" },
		-- add blink.compat to dependencies
		{
			"saghen/blink.compat",
			optional = true, -- make optional so it's only enabled if any extras need it
			opts = { impersonate_nvim_cmp = true },
			version = not vim.g.lazyvim_blink_main and "*",
		},
	},
	event = "InsertEnter",
}

function M.config()
	local opts = {
		keymap = {
			preset = "super-tab",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<C-b>"] = { "scroll_documentation_up" },
			["<C-f>"] = { "scroll_documentation_down" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			-- Set `select` to `false` to only confirm explicitly selected items.
			-- Accept currently selected item. If none selected, `select` first item.
			["<CR>"] = { "accept" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
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
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
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
		-- signature = { enabled = true },

		sources = {
			-- adding any nvim-cmp sources here will enable them
			-- with blink.compat
			compat = { "luasnip" },
			default = { "lsp", "path", "snippets", "buffer" },
			cmdline = {},
		},
		-- snippets = {
		-- 	expand = function(snippet)
		-- 		require("luasnip").lsp_expand(snippet)
		-- 	end,
		-- 	active = function(filter)
		-- 		if filter and filter.direction then
		-- 			return require("luasnip").jumpable(filter.direction)
		-- 		end
		-- 		return require("luasnip").in_snippet()
		-- 	end,
		-- 	jump = function(direction)
		-- 		require("luasnip").jump(direction)
		-- 	end,
		-- },
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
