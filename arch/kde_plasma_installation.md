After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

# Install base-devel

```
# pacman -Syu base-devel
```

# User

Add a user with sudo.

```
# useradd -m -G wheel -s /bin/bash ohno
# passwd ohno
# EDITOR=nvim visudo /etc/sudoers
```

# Desktop environment

Install KDE plasma with a terminal emulator. (https://wiki.archlinux.org/title/KDE#Plasma)

```
# pacman -Syu xorg-server plasma-meta alacritty
# systemctl enable sddm
# systemctl enable NetworkManager
```

Reboot to get into Plasma as a non-root user.

# Essential packages

```
$ sudo pacman -Syu tmux firefox git openssh man-db xclip
```

(`xclip` to enable yank to clipboard on Neovim)

# Japanese

### Font

```
$ sudo pacman -Syu otf-ipaexfont
```

### Input method

https://wiki.archlinux.org/title/Fcitx5

```
$ sudo pacman -Syu fcitx5-im fcitx5-mozc
```

Append the following code to /etc/environment.

```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
```

Add "Mozc" as an input method on Fcitx Configuration app. Then restart X.

# Emacs keybindings for GTK applications

https://wiki.archlinux.org/title/GTK#Emacs_key_bindings
