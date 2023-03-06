# Prepare X11

```
$ git clone https://git.suckless.org/dwm
$ make install
```

```
$ sudo pacman -S xorg-server xorg-xinit

# Then edit ~/.xinitrc to be as follow.
$ cat ~/.xinitrc
#!/bin/sh
xset r rate 300 50
exec dwm
```

# Run

```
$ startx
```

# Others

### apps

```
$ sudo pacman -S alacritty flameshot xorg-xsetroot xsecurelock xclip unclutter
```

- alacritty: terminal
- flameshot: screenshot
- xorg-xsetroot: for status bar
- xsecurelock: lock screen
- xclip: clipboard utils for nvim
- unclutter: hide cursor

### start script

```
$ cat ~/.xinitrc
#!/bin/sh

# status bar
while true; do
    text=" bat: $(cat /sys/class/power_supply/BAT0/capacity)% | $(date +"%F %R")"
    xsetroot -name "$text"
    # Update every minute.
    sleep 1m
done &

# IM
fcitx5 &

# hide cursor
unclutter --timeout 5 &

# window manager
xset r rate 300 50
exec dwm
```

### Keyboard settings

Use CapsLock as Ctrl.

```
$ cat /etc/X11/xorg.conf.d/00-keyboard.conf
Section "InputClass"
    Identifier "Keyboard Setting"
    MatchIsKeyboard "yes"
    Option "XkbOptions" "ctrl:nocaps"
EndSection
```

### Touchpad settings

```
$ cat /etc/X11/xorg.conf.d/01-touchpad.conf
Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "ClickMethod" "clickfinger"
    Option "DisableWhileTyping" "on"
    Option "MiddleEmulation" "on"
EndSection
```

### Firefox

```
MOZ_ENABLE_WAYLAND=0 firefox
```

### log: Removed apps to migrate from dwl

```
$ sudo pacman -Rsu foot grim pipewire slurp waylock wbg wf-recorder wl-clipboard wlroots xdg-desktop-portal-wlr yambar
```
