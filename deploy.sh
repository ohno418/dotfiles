#!/bin/bash
set -e

ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/vimrc ~/.vimrc
ln -sf $(pwd)/i3_config ~/.config/i3/config
# ln -s $(pwd)/tmux.conf ~/.tmux.conf

echo OK
