# Install Sway

With a terminal emulator.

```
$ sudo pacman -Syu sway alacritty
```

# Packages for desktop

```
$ sudo pacman -Syu swaybg swaylock wofi pamixer brightnessctl wl-clipboard
```

- swaybg: wallpaper
- swaylock: lock screen
- wofi: app launcher
- pamixer: sound control
- brightnessctl: backlight control
- wl-clipboard: clipboard util

# Screenshot

```
$ sudo pacman -Syu grim slurp
```

# Japanese IM

`/etc/environment`

```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
```

# Start sway on login

Add the following code to the beginning of `~/.bash_profile`.

```
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi
```
