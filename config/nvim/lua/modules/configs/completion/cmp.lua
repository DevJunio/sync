return function()
	require('luasnip.loaders.from_vscode').lazy_load()

	local icons = {
		kind = require("util.icons").get("kind"),
		type = require("util.icons").get("type"),
		cmp = require("util.icons").get("cmp"),
	}

	local t = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

	local border = function(hl)
		return {
			{ "┌", hl },
			{ "─", hl },
			{ "┐", hl },
			{ "│", hl },
			{ "┘", hl },
			{ "─", hl },
			{ "└", hl },
			{ "│", hl },
		}
	end

	local cmp = require("cmp")
	cmp.setup({
		preselect = cmp.PreselectMode.Item,
		enabled = function()
			local context = require 'cmp.config.context'

			local comment = not context.in_treesitter_capture("comment") 
				and not context.in_syntax_group("Comment")

				local buftype = vim.api.nvim_buf_get_option(0, "buftype")
				if buftype == "prompt" then return false end

			local string = not context.in_treesitter_capture("String") 
				and not context.in_syntax_group("String")

			-- Set of commands where cmp will be disabled
			local disabled = {
				IncRename = true
			}
			-- Get first word of cmdline
			local cmd = vim.fn.getcmdline():match("%S+")
			-- Return true if cmd isn't disabled
			-- else call/return cmp.close(), which returns false
			return not disabled[cmd] or cmp.close() or comment or string or prompt
		end,
		window = {
			completion = {
				border = border("PmenuBorder"),
				winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
				scrollbar = true,
			},
			documentation = {
				border = border("CmpDocBorder"),
				winhighlight = "Normal:CmpDoc",
			},
		},
		formatting = {
			fields = { "abbr", "kind", "menu" },
			format = function(entry, vim_item)
				local lspkind_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp)
				-- load lspkind icons
				vim_item.kind =
				string.format(" %s  %s", lspkind_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or "")

				vim_item.menu = setmetatable({
					copilot = "",
					buffer = "[BUF]",
					orgmode = "[ORG]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[LUA]",
					path = "[PATH]",
					treesitter = "[TS]",
					luasnip = "[SNIP]",
					spell = "[SPELL]",
				}, {
					__index = function()
						return "[BTN]" -- builtin/unknown source names
					end,
				})[entry.source.name]

				local label = vim_item.abbr
				local truncated_label = vim.fn.strcharpart(label, 0, 80)
				if truncated_label ~= label then
					vim_item.abbr = truncated_label .. "..."
				end

				return vim_item
			end,
		},
		matching = {
			disallow_partial_fuzzy_matching = false,
		},
		performance = {
			async_budget = 1,
			max_view_entries = 120,
		},
		-- You can set mappings if you want
		mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-p>'] = cmp.mapping.open_docs(),
			["<C-l>"] = cmp.mapping.confirm({ select = true }),
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-U>"] = cmp.mapping.scroll_docs(-4),
			["<C-D>"] = cmp.mapping.scroll_docs(4),
			["<C-w>"] = cmp.mapping.close(),
			["<Tab>"] = cmp.mapping(function(fallback)
				if require("luasnip").expand_or_locally_jumpable() then
					vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"))
				elseif cmp.visible() then
					cmp.confirm({ select = true })
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if require("luasnip").jumpable(-1) then
					vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
				elseif cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		-- You should specify your *installed* sources.
		sources = {
			{ name = "nvim_lsp", priority= 1, max_item_count = 350 },
			{ name = "nvim_lua", priority = 2 },
			{ name = "copilot", priority = 9 },
			{ name = "luasnip", priority = 9 },
			{ name = "treesitter", priority = 4 },
			{ name = "spell" },
		}, {
			{ name = "buffer", keyword_length = 3, max_item_count = 10 },
		},
	})

	vim.api.nvim_create_autocmd("BufRead", {
		group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
		pattern = "Cargo.toml",
		callback = function()
			cmp.setup.buffer({ sources = { { name = "crates" } } })
		end,
	})

	vim.api.nvim_create_autocmd("BufRead", {
		group = vim.api.nvim_create_augroup("CmpSourceNeorg", { clear = true }),
		pattern = ".norg",
		callback = function()
			cmp.setup.buffer({ sources = { { name = "neorg" } } })
		end,
	})
end
