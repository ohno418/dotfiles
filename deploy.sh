#!/bin/sh
set -e

# fish
ln -sf $(pwd)/fish/config.fish ~/.config/fish/config.fish

# git
mkdir -p ~/.config/git
ln -sf $(pwd)/gitconfig ~/.config/git/config

# tmux
mkdir -p ~/.config/tmux
ln -sf $(pwd)/tmux.conf ~/.config/tmux/tmux.conf

# nvim
mkdir -p ~/.config/nvim
ln -sf $(pwd)/nvim_init.lua ~/.config/nvim/init.lua

# river
mkdir -p ~/.config/river ~/.config/yambar
ln -sf $(pwd)/river/init ~/.config/river/init
ln -sf $(pwd)/river/yambar_config.yml ~/.config/yambar/config.yml

# foot
mkdir -p ~/.config/foot
ln -sf $(pwd)/foot.ini ~/.config/foot/foot.ini

# aerc (email client)
mkdir -p ~/.config/aerc
ln -sf $(pwd)/aerc/* ~/.config/aerc/

echo OK
