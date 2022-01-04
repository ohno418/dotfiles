#!/bin/bash
set -e

ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/vimrc ~/.vimrc
# ln -s $(pwd)/tmux.conf ~/.tmux.conf

echo OK
