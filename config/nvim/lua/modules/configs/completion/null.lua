return function()
	local null = Load('null-ls')
	local mason_null_ls = Load("mason-null-ls")

	local formatting = null.builtins.formatting
	local completion = null.builtins.completion
	local diagnostics = null.builtins.diagnostics
	local code_actions = null.builtins.code_actions

	local sources = {
		code_actions.ts_node_action,

		-- Rust
		formatting.rustfmt,

		-- nix
		formatting.nixfmt,
		code_actions.statix,

		-- Lua
		formatting.stylua,

		-- Go
		diagnostics.staticcheck,
		formatting.golines.with({
			extra_args = {
				"--max-len=180",
				"--base-formatter=gofumpt",
			},
		}),

		-- Javascript
		diagnostics.eslint_d,
		code_actions.eslint_d,
		formatting.eslint_d,
		formatting.prettierd,
		diagnostics.tsc, -- Typescript
		formatting.rustywind, -- Tailwind

		-- Text
		diagnostics.alex, -- Markdown

		-- HTML
		diagnostics.djlint,
		formatting.djlint,

		-- Misc
		diagnostics.zsh,
		diagnostics.actionlint, -- Github Action
		diagnostics.stylelint, -- CSS, SASS ...
	}

	null.setup({
		border = "rounded",
		debug = true,
		log_level = "warn",
		update_in_insert = false,
		sources = sources,
	})

	mason_null_ls.setup({
		automatic_installation = false,
		automatic_setup = true,
	})

	require('crates').setup {
		null_ls = {
			enabled = true,
			name = "crates.nvim",
		},
	}

	--Load("mason-null-ls").setup_handlers()
end
