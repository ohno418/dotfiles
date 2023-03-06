# packages

```
$ sudo pacman -S foot grim slurp waylock wl-clipboard wlroots xdg-desktop-portal-wlr
```

### from AUR

- wbg
- yambar

# dwl

Just cloned and built "mine" branch.

# remove X11 relateds

```
$ sudo rm /etc/X11/xorg.conf.d/00-keyboard.conf
$ sudo rm /etc/X11/xorg.conf.d/01-touchpad.conf
$ rm ~/.xinitrc
$ rm .Xauthority
$ sudo pacman -Rsu alacritty flameshot unclutter xclip xorg-server xorg-xinit xorg-xsetroot xsecurelock
```
