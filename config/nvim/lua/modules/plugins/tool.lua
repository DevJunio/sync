local tool = {}

tool['nvim-telescope/telescope.nvim']= {
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-project.nvim',
		'nvim-telescope/telescope-media-files.nvim',
		'nvim-telescope/telescope-file-browser.nvim',
		{
			"nvim-telescope/telescope-frecency.nvim",
			config = function()
				require("telescope").load_extension "frecency"
			end,
			dependencies = { "kkharji/sqlite.lua" },
		},
		'jvgrootveld/telescope-zoxide',
	}
}

tool['nvim-tree/nvim-tree.lua'] = {
	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- set termguicolors to enable highlight groups
		vim.opt.termguicolors = true
		local api = require("nvim-tree.api")

		local function edit_or_open()
			local node = api.tree.get_node_under_cursor()

			if node.nodes ~= nil then
				-- expand or collapse folder
				api.node.open.edit()
			else
				-- open file
				api.node.open.edit()
				-- Close the tree if file was opened
				api.tree.close()
			end
		end

		-- open as vsplit on current node
		-- OR setup with some options
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		})

		-- global
		vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeFindFileToggle<cr>", {silent = true, noremap = true})
	end
}

tool['nvim-telescope/telescope-fzf-native.nvim'] = {
	build = 'make',
	cond = function()
		return vim.fn.executable 'make' == 1
	end,
	config = Load('tool.telescope')
}

tool['nvim-neorg/neorg'] = {
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" , "nvim-neorg/neorg-telescope" },
    config = Load("tool.neorg"),
}

tool["gelguy/wilder.nvim"] = {
	event = "CmdlineEnter",
	config = Load("tool.wilder"),
	dependencies = { "romgrk/fzy-lua-native" },
}

tool['nvim-treesitter/nvim-treesitter'] = {
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	build = ':TSUpdate',
}

tool['numToStr/Comment.nvim'] = {}
tool['folke/which-key.nvim'] = {}

return tool
