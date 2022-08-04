After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

# Install base-devel

base-devel includes `sudo`.

```
# pacman -Syu base-devel
```

# Network settings

```
# pacman -Syu networkmanager
# systemctl enable NetworkManager
```

Usage: https://wiki.archlinux.org/title/NetworkManager#Usage

# Add a user

```
# useradd -m -G wheel -s /bin/bash ohno
# passwd ohno
# EDITOR=nvim visudo /etc/sudoers
```

# Install i3-gaps

Install i3-gaps with X.

```
$ sudo pacman -Syu xorg-server i3-gaps
```

// TODO: Maybe can go without DM.

Install display manager.

```
$ sudo pacman -Syu lightdm lightdm-gtk-greeter
$ sudo systemctl enable lightdm
```

// TODO: Consider other fonts.

Install a terminal emulator and fonts.

```
$ sudo pacman -Syu alacritty noto-fonts noto-fonts-cjk noto-fonts-emoji
```

Then, reboot to get into i3.

# Install essential packages

```
$ sudo pacman -Syu firefox tmux git openssh man-db xclip
```

# CapsLock as Ctrl

https://wiki.archlinux.org/title/Xorg/Keyboard_configuration#Using_X_configuration_files

```
$ sudo nvim /etc/X11/xorg.conf.d/00-keyboard.conf
```

```
Section "InputClass"
        Identifier "Keyboard Setting"
        MatchIsKeyboard "yes"
        Option "XkbOptions" "ctrl:nocaps"
EndSection
```

Restart to apply this setting.

# Touchpad settings

```
$ sudo nvim /etc/X11/xorg.conf.d/30-touchpad.conf
```

```
Section "InputClass"
        Identifier "touchpad"
        Driver "libinput"
        MatchIsTouchpad "on"
        Option "Tapping" "on"
        Option "ScrollMethod" "twofinger"
EndSection
```

Restart to apply this setting.

# i3 settings

```
$ sudo pacman -Syu rofi i3status pulseaudio feh xorg-xset
```

- rofi: application launcher
- i3status: status bar
- pulseaudio: audio
- feh: image viewer for wallpaper
- xorg-xset: used to change key repeat rate

# Emacs keybindings for GTK applications

https://wiki.archlinux.org/title/GTK#Emacs_key_bindings
