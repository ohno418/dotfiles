#!/bin/bash
set -e

ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/tmux.conf ~/.tmux.conf
ln -s $(pwd)/gitconfig ~/.gitconfig

echo OK
