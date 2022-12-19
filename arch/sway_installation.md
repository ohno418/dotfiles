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
# useradd -m -G wheel ohno
# passwd ohno
# EDITOR=nvim visudo /etc/sudoers
```

Reboot to login as a general user.

# Install Sway

```
$ sudo pacman -Syu sway polkit foot
```

- polkit: For Sway to get access to the seat.
- foot: Terminal emulator.

(Select noto-fonts to use in Sway.)

To automatically start Sway from virtual console, add the following code to the end of `~/.bash_profile` or `~/.zprofile`.

```
# Start Sway from virtual console.
[ "$(tty)" = "/dev/tty1" ] && exec sway
```

Or just execute `sway` on console.

ref: https://wiki.archlinux.org/title/sway#Starting

# Essential packages

```
$ sudo pacman -Syu firefox zsh tmux git openssh man-db man-pages
```

Then get dotfiles from GitHub and deploy them.

### zsh as the default shell

```
$ chsh -s /bin/zsh
```

# Packages for desktop

```
$ sudo pacman -Syu swaybg swayidle swaylock pulseaudio pamixer brightnessctl wl-clipboard grim slurp noto-fonts noto-fonts-cjk noto-fonts-emoji
```

- swaybg: wallpaper
- swayidle, swaylock: lock screen
- pulseaudio, pamixer: sound control
- brightnessctl: backlight control
- wl-clipboard: clipboard util
- grim, slurp: screenshot
- noto-fonts, noto-fonts-cjk, noto-fonts-emoji: fonts

To enable Firefox on wayland, add the following code to `~/.bash_profile` or `~/.zshenv`.

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

Add the following code to `~/.bash_profile` or `~/.zshenv`.

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

Add the following code to `~/.bash_profile` or `~/.zshenv`.

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
