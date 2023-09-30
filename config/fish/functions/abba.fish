function abba -d 'abreviate anywhere'
	begin
		set i (count $argv)
	end
	if test $i -gt 2
		echo"should have only two arguments"
		return
	end

	abbr -a $argv[1] --position anywhere --set-cursor $argv[2]
	alias $argv[1] $argv[2]
end
