After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

# User

Add a user with sudo.

```
$ useradd -m -G wheel -s /bin/bash ohno
$ passwd ohno

# sudo
$ pacman -Syu sudo
$ vim /etc/sudoers
```

# Desktop environment

Install KDE plasma. (https://wiki.archlinux.org/title/KDE#Plasma)

```
$ pacman -Syu xorg plasma-meta

# terminal emulator
$ pacman -Syu konsole

# display manager (https://wiki.archlinux.org/title/SDDM)
$ pacman -Syu sddm
```

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
