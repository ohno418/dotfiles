#!/bin/bash
set -e

ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/nvim.vim ~/.config/nvim/init.vim
ln -sf $(pwd)/tmux.conf ~/.tmux.conf
ln -sf $(pwd)/alacritty.yml ~/.alacritty.yml

echo OK
