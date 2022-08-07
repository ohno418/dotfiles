#!/bin/bash
set -e

mkdir -p ~/.config/nvim ~/.config/tmux ~/.config/alacritty
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/nvim/init.lua ~/.config/nvim/init.lua
ln -sf $(pwd)/tmux.conf ~/.config/tmux/tmux.conf
ln -sf $(pwd)/alacritty.yml ~/.config/alacritty/alacritty.yml

mkdir -p ~/.config/i3/i3blocks
ln -sf $(pwd)/i3/config ~/.config/i3/config
ln -sf $(pwd)/i3/rofi-config.rasi ~/.config/rofi/config.rasi
ln -sf $(pwd)/i3/rofi-slate.rasi ~/.config/rofi/slate.rasi
ln -sf $(pwd)/i3/i3blocks/config ~/.config/i3blocks/config
ln -sf $(pwd)/i3/i3blocks/battery.sh ~/.config/i3blocks/battery.sh
ln -sf $(pwd)/i3/i3blocks/sound.sh ~/.config/i3blocks/sound.sh

echo OK
