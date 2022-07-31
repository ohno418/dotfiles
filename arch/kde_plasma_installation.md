After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

// TODO: Install base-devel at first

# User

Add a user with sudo.

```
$ useradd -m -G wheel -s /bin/bash ohno
$ passwd ohno

# TODO: `base-devel` includes `sudo`.
# sudo
$ pacman -Syu sudo
$ EDITOR=nvim visudo /etc/sudoers
```

# Desktop environment

Install KDE plasma and some apps. (https://wiki.archlinux.org/title/KDE#Plasma)

```
$ pacman -Syu xorg-server plasma-meta alacritty dolphin spectacle

# Enable display manager and network.
$ systemctl enable sddm
$ systemctl enable NetworkManager
```

- alacritty: terminal emulator
- dolphin: file manager
- spectacle: screenshot

Reboot to login Plasma as a non-root user.

# Other apps

```
$ sudo pacman -Syu firefox tmux git openssh man-db xclip
```

# Emacs keybindings for GTK applications

https://wiki.archlinux.org/title/GTK#Emacs_key_bindings

# Fonts

// TODO: noto-fonts?

```
$ sudo pacman -Syu noto-fonts-cjk noto-fonts-emoji
```

# Japanese input

https://wiki.archlinux.org/title/Fcitx5

```
$ sudo pacman -Syu fcitx5-mozc fcitx5-gtk fcitx5-configtool
```

Append the following code to /etc/environment.

```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
```

Add "Mozc" as an input method on Fcitx Configuration app. Then restart X.
