#!/bin/sh
set -e

ln -sf $(pwd)/zsh/zshenv ~/.zshenv
ln -sf $(pwd)/zsh/zprofile ~/.zprofile
ln -sf $(pwd)/zsh/zshrc ~/.zshrc

mkdir -p ~/.config/git ~/.config/nvim ~/.config/tmux
ln -sf $(pwd)/gitconfig ~/.config/git/config
ln -sf $(pwd)/nvim_init.lua ~/.config/nvim/init.lua
ln -sf $(pwd)/tmux.conf ~/.config/tmux/tmux.conf

# foot
mkdir -p ~/.config/foot
ln -sf $(pwd)/foot.ini ~/.config/foot/foot.ini

# dwl
mkdir -p ~/.config/yambar
ln -sf $(pwd)/dwl/yambar_config.yml ~/.config/yambar/config.yml

echo OK
