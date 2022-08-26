#!/bin/bash
set -e

mkdir -p ~/.config/nvim ~/.config/tmux ~/.config/alacritty
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/nvim/init.vim ~/.config/nvim/init.vim
# ln -sf $(pwd)/nvim/init.lua ~/.config/nvim/init.lua
ln -sf $(pwd)/tmux.conf ~/.config/tmux/tmux.conf
ln -sf $(pwd)/alacritty.yml ~/.config/alacritty/alacritty.yml

mkdir -p ~/.config/i3
mkdir -p ~/.config/rofi
ln -sf $(pwd)/i3/config ~/.config/i3/config
ln -sf $(pwd)/i3/bar.sh ~/.config/i3/bar.sh
ln -sf $(pwd)/i3/rofi-config.rasi ~/.config/rofi/config.rasi

echo OK
