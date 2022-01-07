#!/bin/bash
set -e

ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/vimrc ~/.vimrc
ln -sf $(pwd)/tmux.conf ~/.tmux.conf

echo OK
