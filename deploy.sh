#!/bin/bash
set -e

ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/tmux.conf ~/.tmux.conf

echo OK
