#!/bin/bash
set -e

mkdir -p ~/.config/nvim ~/.config/tmux
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/nvim_init.vim ~/.config/nvim/init.vim
ln -sf $(pwd)/tmux.conf ~/.config/tmux/tmux.conf

# Sway
mkdir -p ~/.config/sway ~/.config/wofi
ln -sf $(pwd)/sway/config ~/.config/sway/config
ln -sf $(pwd)/sway/bar.sh ~/.config/sway/bar.sh
ln -sf $(pwd)/sway/wofi-style.css ~/.config/wofi/style.css

# foot
mkdir -p ~/.config/foot
ln -sf $(pwd)/foot.ini ~/.config/foot/foot.ini

# Alacritty
# mkdir -p ~/.config/alacritty
# ln -sf $(pwd)/alacritty.yml ~/.config/alacritty/alacritty.yml

echo OK
