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

# i3
# mkdir -p ~/.config/i3
# mkdir -p ~/.config/rofi
# ln -sf $(pwd)/i3/config ~/.config/i3/config
# ln -sf $(pwd)/i3/bar.sh ~/.config/i3/bar.sh
# ln -sf $(pwd)/i3/rofi-config.rasi ~/.config/rofi/config.rasi

# Alacritty
# mkdir -p ~/.config/alacritty
# ln -sf $(pwd)/alacritty.yml ~/.config/alacritty/alacritty.yml

echo OK
