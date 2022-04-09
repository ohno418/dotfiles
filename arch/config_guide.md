After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

# User

Add a user with sudo.

```
$ useradd -m -G wheel -s /bin/bash ohno
$ passwd ohno

# sudo
$ pacman -Syu sudo
$ EDITOR=nvim visudo /etc/sudoers
```

# Desktop environment

Install KDE plasma and essential apps. (https://wiki.archlinux.org/title/KDE#Plasma)

```
$ pacman -Syu xorg plasma-meta alacritty sddm dolphin

# Enable display manager and network.
$ systemctl enable sddm
$ systemctl enable NetworkManager
```

- alacritty: terminal emulator
- sddm: display manager
- dolphin: file manager

Reboot to login Plasma as a non-root user.

# Fonts

```
$ sudo pacman -Syu noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
```

# Emacs keybindings for GTK applications

https://wiki.archlinux.org/title/GTK#Emacs_key_bindings

# Japanese input

https://wiki.archlinux.org/title/fcitx#Installation

```
$ sudo pacman -Syu fcitx fcitx-qt5 fcitx-mozc fcitx-configtool
```

Append the following code to ~/.xprofile.

```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
```

Add "Mozc" as an input method on Fcitx Configuration app.

# Other apps

```
$ sudo pacman base-devel man-pages git tmux xclip
```
