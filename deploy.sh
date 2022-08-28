#!/bin/bash
set -e

mkdir -p ~/.config/nvim ~/.config/tmux ~/.config/alacritty ~/.config/sway
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/nvim/init.vim ~/.config/nvim/init.vim
ln -sf $(pwd)/tmux.conf ~/.config/tmux/tmux.conf
ln -sf $(pwd)/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -sf $(pwd)/sway/config ~/.config/sway/config

echo OK
