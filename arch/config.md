After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

# Network setting

```
$ pacman -Syu networkmanager
$ systemctl enable NetworkManager
```

usage: https://wiki.archlinux.org/title/NetworkManager#Usage

# User

Add a user with sudo.

```
$ useradd -m -G wheel -s /bin/bash ohno
$ passwd ohno

# sudo
$ pacman -Syu sudo
$ EDITOR=vim visudo /etc/sudoers
```

# GUI settings

## display server

```
$ pacman -Syu xorg-server
```

## display manager

```
$ pacman -Syu lighdm lighdm-gtk-greeter
$ systemctl enable lightdm
```

## i3 window manaager

```
$ pacman -Syu i3-gaps i3status rofi alacritty
```

- `rofi` is an application launcher.
- `alacritty` is an terminal emulator.

# Reboot

```
$ sudo reboot
```

# Remap CapsLock to Ctrl on X

```
$ pacman -Syu xorg-xmodmap
```

```
# in ~/.Xmodmap

clear lock
clear control
keycode 66 = Control_L
add control = Control_L Control_R
```

```
# in ~/.xprofile

#!/bin/bash
xmodmap ~/.Xmodmap
```

# Fonts

```
$ pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
```

// TODO: Is ricty really need to code?

# Japanese input

https://wiki.archlinux.org/title/fcitx#Installation

```
$ pacman -Syu fcitx-im fcitx-mozc fcitx-configtool
```

Append the following code to ~/.xprofile.

```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
```

Add "Mozc" as an input method on Fcitx Configuration app.

# Emacs keybindings for GTK applications

https://wiki.archlinux.org/title/GTK#Emacs_key_bindings
