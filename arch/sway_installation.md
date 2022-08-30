After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

# Install base-devel

Including `sudo`.

```
# pacman -Syu base-devel
```

# Network settings

```
# pacman -Syu networkmanager
# systemctl enable NetworkManager
```

Use `nmtui` command for network settings.

# Add a user

```
# useradd -m -G wheel -s /bin/bash ohno
# passwd ohno
# EDITOR=nvim visudo /etc/sudoers
```

Reboot to login as a general user.

# Install Sway

With xwayland and a terminal emulator (`foot`).

```
$ sudo pacman -Syu sway xorg-xwayland foot
```

(Select Sway to use noto-fonts.)

To automatically start Sway from virtual console, add the following code to the end of `~/.bash_profile`.

```
# Start Sway from virtual console.
[ "$(tty)" = "/dev/tty1" ] && exec sway
```

# Essential packages

```
$ sudo pacman -Syu firefox tmux git openssh man-db man-pages
```

Then get dotfiles from GitHub.

# Packages for desktop

// TODO: fonts

```
$ sudo pacman -Syu swaybg swayidle swaylock rofi pulseaudio pamixer brightnessctl wl-clipboard grim slurp
```

- swaybg: wallpaper
- swayidle, swaylock: lock screen
- rofi: app launcher
- pulseaudio, pamixer: sound control
- brightnessctl: backlight control
- wl-clipboard: clipboard util
- grim, slurp: screenshot

To enable Firefox on wayland, add the following code to `~/.bash_profile`.

```
# Firefox on Wayland
export MOZ_ENABLE_WAYLAND=1
```

# Screen sharing

// TODO: Only xdg-desktop-portal-wlr is needed, pipewire is a dependency of it.

https://elis.nu/blog/2021/02/detailed-setup-of-screen-sharing-in-sway/

```
$ sudo pacman -Syu pipewire xdg-desktop-portal-wlr
```

Add the following code to `~/.bash_profile`.

```
# for screen sharing
export XDG_CURRENT_DESKTOP=sway
```

# Japanese IM

https://wiki.archlinux.org/title/Fcitx5

```
$ sudo pacman -Syu fcitx5-im fcitx5-mozc
```

Add the following code to `~/.bash_profile`.

```
# fcitx5
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
```

# Battery saving

https://wiki.archlinux.org/title/TLP#Installation

```
$ sudo pacman -Syu tlp
$ sudo systemctl enable tlp.service
$ sudo systemctl start tlp.service
```

# Enable SDD TRIM

```
$ sudo systemctl enable fstrim.timer
```
