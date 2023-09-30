#Type L and space to apply | less at the end
abba L   "% | less"
abba t   "/tmp/%"
abba w   "~/work/%"
abba d   "~/.dotfiles/%"
abba .l  "~/.local/%"
abba .c  "~/.config/%"

abbr -a n nvim;
abbr -a v nvim;
abbr -a vi nvim;
abbr -a lg lazygit

alias l   "ls -l"       # list table
alias la  "ls -lah"     # list table hidden
alias lsa "ls -ah"      # list files hidden
alias rm="rm -r"
alias mv="mv -i"
alias cp="cp -r"
alias mkdir="mkdir -p"

alias restart "systemctl --no-wall reboot"
aliasm {logout, logoff} "pkill -KILL -u $USER"
aliasm {shutdown, turnoff, shut} "shutdown -h now"

aliasm {c,cl,cle,clea} clear

has   exa  lt="ls -T"   # list tree
has   exa  lta="ls -Ta" # list tree hidden
has   sk   rgrep="sk --ansi -i -c 'rg --color=always --line-number "{}"'"

has_alias exa 'exa --time-style=long-iso --git -@ --group-directories-first \
--icons --no-user'
has_alias bat 'bat --plain --paging=always'
has_alias rg 'rg --hidden --follow --smart-case 2>/dev/null'
has_alias fd 'fd --hidden --follow'
has_alias sk "sk --bind 'ctrl-l:accept'"

overlay ls exa
overlay cat bat
overlay grep rg
overlay find fd
overlay rm trash-put

alias cemacs "emacsclient -c -a 'emacs'"

alias clippy="cargo clippy --fix --\
 -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used"

alias clippyd="cargo clippy --fix --\
 -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used \
 -D warnings"
