# Prepare X11

```
$ git clone https://git.suckless.org/dwm
$ make install
```

```
$ sudo pacman -S xorg-server xorg-xinit
$ cp /etc/X11/xinit/xinitrc ~/.xinitrc

# Append "xset r rate 300 50; exec dwm" to ~/.xinitrc
# and remove some unneeded rows.
```

# Run

```
$ startx
```

# Others

### Terminal app

```
$ pacman -S alacritty
```

### CapsLock as Ctrl

```
$ cat /etc/X11/xorg.conf.d/00-keyboard.conf
Section "InputClass"
        Identifier "Keyboard Setting"
        MatchIsKeyboard "yes"
        Option "XkbOptions" "ctrl:nocaps"
EndSection
```

### Firefox

```
MOZ_ENABLE_WAYLAND=0 firefox
```
