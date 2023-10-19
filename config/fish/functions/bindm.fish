function bindm -d 'Bind many modes at once'
	begin
		set total_args (count $argv)
		set function "$total_args"
		set cmd (math "$total_args" - 1)
	end

	for item in (seq $total_args)[..-3]
		bind -M $argv[$item] $argv[$cmd] $argv[$function]
	end
end
