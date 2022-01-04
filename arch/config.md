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

# Desktop environment

Install KDE plasma. (https://wiki.archlinux.org/title/KDE#Plasma)

```
$ pacman -Syu plasma-meta konsole sddm dolphin
$ systemctl enable sddm
```

- konsole: terminal emulator
- sddm: display manager
- dolphin: file manager

Reboot to login into Plasma.

# Fonts

```
$ pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
```

# Japanese input

// FIXME

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

// FIXME

https://wiki.archlinux.org/title/GTK#Emacs_key_bindings
