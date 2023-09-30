local editor = {}

editor['nvim-treesitter/nvim-treesitter'] = {
	event = "BufRead",
	dependencies = {
		"nvim-treesitter/playground",
	},
	build = function()
		require('nvim-treesitter.install').update({ with_sync = true })
	end,
	config = require('editor.treesitter'),
}

editor['numToStr/Comment.nvim']={ opts = {} }


editor['ckolkey/ts-node-action']={
     dependencies = { 'nvim-treesitter' },
     opts = {},
}
editor['j-hui/fidget.nvim']= { tag="legacy", opts = {} }
editor['m4xshen/autoclose.nvim'] = {
	event="InsertEnter",
	config=true
}

editor['tpope/vim-fugitive'] = {}
editor['tpope/vim-rhubarb'] = {}
editor['tpope/vim-sleuth'] = {}
editor['tpope/vim-repeat']={ }
editor['kylechui/nvim-surround'] = {
	event = "VeryLazy",
	opts = {
		delimiters = {
			["("] = {
				add = { "\\left(", "\\right)" },
			},
			[")"] = {
				add = { "\\left(", "\\right)" },
			},

			["["] = {
				add = { "\\left[", "\\right]" },
			},
			["]"] = {
				add = { "\\left[", "\\right]" },
			},

			["'"] = {
				add = { "\\left'", "\\right'" },
			},
			['"'] = {
				add = { '\\left"', '\\right"' },
			},
		}
	}
}

editor['lewis6991/gitsigns.nvim'] = {
	opts = {
		-- See `:help gitsigns.txt`
		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
		},
		on_attach = function(bufnr)
		local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
		vim.api.nvim_create_autocmd('TextYankPost', {
			callback = function()
				vim.highlight.on_yank()
			end,
			group = highlight_group,
			pattern = '*',
		})
			vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
			vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
			vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
		end,
	},
}

return editor
