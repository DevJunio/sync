#Type L and space to apply | less at the end
abba t   "/tmp/%"
abba d   "~/dev/%"
abba s   "~/sync/%"
abba .l  "~/.local/%"
abba .c  "~/.config/%"
abba .d   "~/.dotfiles/%"

abbr -a cr cargo run;
abbr -a cc cargo clippy -- -W clippy::pedantic -W clippy::nursery;
abbr -a b bacon;
abbr -a n nvim;
abbr -a sv "sudo nvim";
abbr -a v nvim;
abbr -a vi nvim;
abbr -a lg lazygit
# alias swagger 'docker run --rm -it  --user $(id -u):$(id -g) -e GOPATH=$(go env GOPATH):/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger'

alias l   "ls -l"       # list table
alias la  "ls -lah"     # list table hidden
alias lsa "ls -ah"      # list files hidden
alias rm "rm -r"
alias mv "mv -i"
alias cp "cp -r"
alias mkdir "mkdir -p"

aliasm {up,update,a} "sudo echo; paru -Syu --noconfirm || keyboard.sh; keyboard.sh; rustup update"
alias r "rustup update"
alias f fish

alias cdev "cd ~/dev"

alias restart "systemctl --no-wall reboot"
aliasm {logout, logoff} "pkill -KILL -u $USER"
aliasm {shutdown, turnoff, shut} "shutdown -h now"

aliasm {c,cl,cle,clea} clear

has   eza  lt="ls -T"   # list tree
has   eza  lta="ls -Ta" # list tree hidden
has   sk   rgrep="sk --ansi -i -c 'rg --color=always --line-number "{}"'"

has_alias eza 'eza --time-style=long-iso --git -@ --group-directories-first \
--icons --no-user'
has_alias bat 'bat --plain --paging=always'
has_alias rg 'rg --hidden --follow --smart-case 2>/dev/null'
has_alias fd 'fd --hidden --follow'
has_alias sk "sk --bind 'ctrl-l:accept'"

overlay ls eza
overlay cat bat
overlay grep rg
overlay find fd
overlay rm trash-put

alias cemacs "emacsclient -c -a 'emacs'"

alias clippy="rustup run stable cargo clippy --\
 -D clippy::pedantic -W clippy::nursery -W clippy::unwrap_used"
