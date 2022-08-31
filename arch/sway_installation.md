After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

# Network settings

```
# pacman -Syu networkmanager
# systemctl enable NetworkManager
# systemctl start NetworkManager
```

Use `nmtui` command for network settings.

# Install base-devel

Including `sudo`.

```
# pacman -Syu base-devel
```

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

```
$ sudo systemctl enalbe seatd
$ sudo systemctl start seatd
$ usermod -a -G seat ohno
```

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

```
$ sudo pacman -Syu swaybg swayidle swaylock rofi pulseaudio pamixer brightnessctl wl-clipboard grim slurp noto-fonts noto-fonts-cjk noto-fonts-emoji
```

- swaybg: wallpaper
- swayidle, swaylock: lock screen
- rofi: app launcher
- pulseaudio, pamixer: sound control
- brightnessctl: backlight control
- wl-clipboard: clipboard util
- grim, slurp: screenshot
- noto-fonts, noto-fonts-cjk, noto-fonts-emoji: fonts

To enable Firefox on wayland, add the following code to `~/.bash_profile`.

```
# Firefox on Wayland
export MOZ_ENABLE_WAYLAND=1
```

Reboot to start PulseAudio service, or just start it.

# Emacs keybindings for GTK applications

https://wiki.archlinux.org/title/GTK#Emacs_key_bindings

Only setting for GTK3 is fine.

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

Add "Mozc" as an input method on Fcitx Configuration app.

# Screen sharing

```
$ sudo pacman -Syu pipewire xdg-desktop-portal-wlr
```

Add the following code to `~/.bash_profile`.

```
# for screen sharing
export XDG_CURRENT_DESKTOP=sway
```

Enable PipeWire services.

```
$ systemctl --user enable pipewire
```

Reboot to start following services:

```
$ systemctl --user status pipewire
$ systemctl --user status xdg-desktop-portal
$ systemctl --user status xdg-desktop-portal-wlr
```

Test [here](https://mozilla.github.io/webrtc-landing/gum_test.html) (Screen capture).

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
