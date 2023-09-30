return function()
	local on_attach = function()
		require("lsp_signature").on_attach({
			bind = true,
			use_lspsaga = true,
			floating_window = true,
			fix_pos = true,
			hint_enable = true,
			hi_parameter = "Search",
			handler_opts = {
				border = "rounded",
			},
		})
	end

	require("rust-tools").setup {
		tools = {
			inlay_hints = {
				auto = false,
				only_current_line = false,
				show_parameter_hints = false,
				parameter_hints_prefix = '<- ',
				other_hints_prefix = '=> ',
				max_len_align = false,
				max_len_align_padding = 1,
				right_align = false,
				right_align_padding = 4,
				highlight = 'Comment',
			},
			hover_actions = {
				border = {
					{ '╭', 'FloatBorder' },
					{ '─', 'FloatBorder' },
					{ '╮', 'FloatBorder' },
					{ '│', 'FloatBorder' },
					{ '╯', 'FloatBorder' },
					{ '─', 'FloatBorder' },
					{ '╰', 'FloatBorder' },
					{ '│', 'FloatBorder' },
				},
				auto_focus = false,
			},
			server = {
			},
		},
	}
end
