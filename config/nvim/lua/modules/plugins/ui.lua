local ui = {}

--ui['lukas-reineke/indent-blankline.nvim'] = {
	--opts = {
		--char = '┊',
		--show_trailing_blankline_indent = false,
	--},
--}

ui["RRethy/vim-illuminate"] = {
	event = "BufRead",
	name = 'illuminate',
	config = Load('ui.illuminate'),
}

ui["goolord/alpha-nvim"] = {
	event = "VimEnter",
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function ()
		require'alpha'.setup(require'alpha.themes.startify'.config)
	end
}
ui['nvim-lualine/lualine.nvim'] = {
	event = "BufRead",
	config = Load('ui.lualine')
}

ui['rose-pine/neovim'] = {
	lazy = true,
	name = 'rose-pine',
	event = 'VimEnter',
	config = function()
		require('rose-pine').setup {
			disable_background = false,
			disable_float_background = false,
			dim_nc_background = false,
		}
		-- vim.cmd.colorscheme 'rose-pine'
		-- vim.cmd.hi 'Normal guibg=NONE ctermbg=NONE'
		-- vim.cmd.hi 'NormalNC guibg=NONE ctermbg=NONE'
		-- vim.cmd.hi 'NormalFloat guibg=NONE ctermbg=NONE'
	end
}

ui['catppuccin/nvim'] = {
	lazy = false,
	name = 'catppuccin',
	event = 'VimEnter',
	priority = 1000,
	config = function()
		require('catppuccin').setup({
			transparent_background = false, -- disables setting the background color.
			show_end_of_buffer = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				fidget = true,
				treesitter = true,
			},
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "bold" },
			},
			color_overrides = {
				all = {
					peach="#f8a4b6",
					text="#e0def4",
					blue="#86b2d3",
					subtext="#b1c6d3",
					red="#f9667a",
					yellow="#f9b37f",
					green="#a3bbae",
					lavender="#bab4fe",
					pink="#f8a4b6",
				},
			},

			highlight_overrides = {
				all = function(colors)
					return {
						Normal = { bg = "#1d1f24" },
						NormalNC = { bg = "#1c1d28" },
						Float = { bg = "#1c1d28" },
						String = { fg = "#86b2d3" },
						Subscript = { fg = "#86b2d3" },
						Comment = { fg = "#9c7ec7" },
						["@punctuation.delimiter"] = { fg = colors.teal },
						["@punctuation.bracket"] = { fg = colors.overlay2 },

						FidgetNormal = { bg = colors.none },
						FidgetTask = { bg = colors.none },
						FidgetTitle = { bg = colors.none },
					}
				end
			}
		})

		vim.cmd.colorscheme 'catppuccin'
	end,
}

return ui
