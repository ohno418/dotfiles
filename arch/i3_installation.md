After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

# Install base-devel

base-devel includes `sudo`.

```
$ pacman -Syu base-devel
```

# Network settings

```
$ pacman -Syu networkmanager
$ systemctl enable NetworkManager
```

Usage: https://wiki.archlinux.org/title/NetworkManager#Usage

# Add a user

```
$ useradd -m -G wheel -s /bin/bash ohno
$ passwd ohno
$ EDITOR=nvim visudo /etc/sudoers
```

# Install i3-gaps

Install i3-gaps with X.

```
$ sudo pacman -Syu xorg-server xorg-xinit i3-gaps
$ echo "exec i3" >> ~/.xinitrc
```

```
$ sudo pacman -Syu lightdm lightdm-gtk-greeter
$ sudo systemctl enable lightdm
```

Install a terminal emulator and fonts.

```
$ sudo pacman -Syu alacritty noto-fonts
```

Then, reboot to get into i3.

# Install some packages

```
$ sudo pacman -Syu firefox tmux git openssh man-db xclip
```

More fonts.

```
$ sudo pacman -Syu noto-fonts-cjk noto-fonts-emoji
```
