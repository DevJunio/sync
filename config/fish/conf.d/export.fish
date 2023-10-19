# General
set -gx EDITOR nvim
set -gx DEV $HOME/dev
fish_add_path -g $HOME/.local/bin

set SYNC $HOME/sync
set LOCAL $HOME/.local
set CONFIG $HOME/.config
set DOTFILES_CONFIG_DIR $HOME/.dotfiles

# Rust
set RUST_BACKTRACK 1

set -gx ATUIN_NOBIND "true"
set -gx GPG_TTY (tty)

set -gx GOPATH $HOME/dev/go
fish_add_path -g $GOPATH/bin

set -gx JAVA_HOME $HOME/.local/bin/java/17-temurin

set fish_color_error red --bold --italic

# Alacritty
set -gx WINIT_X11_SCALE_FACTOR 1.2

# JS
fish_add_path -g $HOME/node_modules/bin
fish_add_path -g $HOME/.yarn/bin $HOME/node_modules/yarn/bin

# Emacs
fish_add_path -g $HOME/.config/emacs/bin

