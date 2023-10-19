if status is-interactive
	set fish_greeting
	starship init fish | source
	zoxide init fish | source
	#    eval (zellij setup --generate-auto-start fish | string collect)

	direnv hook fish | source
	enable_transience
	eval (leetcode completions fish)
	atuin init fish | source
	bind -M insert \eh _atuin_search
	bind -M default \eh _atuin_search

	bind default \ch _get_back_one_level
	bind insert  \ch _get_back_one_level
	bind visual  \ch _get_back_one_level
end

# Turso
export PATH="/home/junio/.turso:$PATH"
