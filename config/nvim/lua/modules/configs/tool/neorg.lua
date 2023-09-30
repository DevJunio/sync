return function()
local neorg_callbacks = require("neorg.core.callbacks")

vim.cmd[[autocmd BufEnter norg CopilotStop]]

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
	-- Map all the below keybinds only when the "norg" mode is active
	keybinds.map_event_to_mode("norg", {
		n = { -- Bind keys in normal mode
			{ "<leader>nl", "core.integrations.telescope.find_linkable" },
			{ "<leader>ni", "core.integrations.telescope.insert_link" },
			{ "<leader>nh", "core.integrations.telescope.search_headings" },
			{ "<leader>nf", "core.integrations.telescope.insert_file_link" },
		},

		i = { -- Bind in insert mode
			{ "<C-l>", "core.integrations.telescope.insert_link" },
		},
	}, {
		silent = true,
		noremap = true,
	})
end)

require("neorg").setup({
	load = {
		["core.defaults"] = {}, -- Loads default behaviour
		["core.integrations.treesitter"] = {}, -- Loads default behaviour
		["core.integrations.telescope"] = {}, -- Loads default behaviour
		["core.keybinds"] = {},
		["core.autocommands"] = {},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.concealer"] = {}, -- Adds pretty icons to your documents
		["core.dirman"] = { -- Manages Neorg workspaces
		config = {
			workspaces = {
				notes = "~/sync/notes",
				temp = "~/sync/notes/tmp",
			},
			default_workspace = "notes",
		},
	},
},
})
end
