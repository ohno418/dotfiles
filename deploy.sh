#!/bin/sh
set -e

ln -sf $(pwd)/zsh/zshenv ~/.zshenv
ln -sf $(pwd)/zsh/zprofile ~/.zprofile
ln -sf $(pwd)/zsh/zshrc ~/.zshrc

mkdir -p ~/.config/nvim ~/.config/tmux
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/nvim_init.lua ~/.config/nvim/init.lua
ln -sf $(pwd)/tmux.conf ~/.config/tmux/tmux.conf

# Sway
mkdir -p ~/.config/sway
ln -sf $(pwd)/sway/config ~/.config/sway/config
ln -sf $(pwd)/sway/bar.sh ~/.config/sway/bar.sh

# foot
mkdir -p ~/.config/foot
ln -sf $(pwd)/foot.ini ~/.config/foot/foot.ini

echo OK
