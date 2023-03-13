#!/bin/sh
set -e

# zsh
ln -sf $(pwd)/zsh/zshenv ~/.zshenv
ln -sf $(pwd)/zsh/zprofile ~/.zprofile
ln -sf $(pwd)/zsh/zshrc ~/.zshrc

# git
mkdir -p ~/.config/git
ln -sf $(pwd)/gitconfig ~/.config/git/config

# tmux
mkdir -p ~/.config/tmux
ln -sf $(pwd)/tmux.conf ~/.config/tmux/tmux.conf

# helix
mkdir -p ~/.config/helix
ln -sf $(pwd)/helix/config.toml ~/.config/helix/config.toml
ln -sf $(pwd)/helix/languages.toml ~/.config/helix/languages.toml

# river
mkdir -p ~/.config/river ~/.config/yambar
ln -sf $(pwd)/river/init ~/.config/river/init
ln -sf $(pwd)/river/wallpaper.jpg ~/.config/river/wallpaper.jpg
ln -sf $(pwd)/river/yambar_config.yml ~/.config/yambar/config.yml

# foot
mkdir -p ~/.config/foot
ln -sf $(pwd)/foot.ini ~/.config/foot/foot.ini

echo OK
