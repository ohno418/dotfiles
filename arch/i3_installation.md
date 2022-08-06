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

Install display manager.

```
$ sudo pacman -Syu lightdm lightdm-gtk-greeter
$ sudo systemctl enable lightdm
```

Install a terminal emulator and fonts.

```
$ sudo pacman -Syu alacritty noto-fonts noto-fonts-cjk noto-fonts-emoji
```

Then, reboot to get into i3.

# Install essential packages

```
$ sudo pacman -Syu firefox tmux git openssh man-db xclip
```

# Keyboard settings

### CapsLock as Ctrl

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

### key repeat rate

```
$ sudo pacman -Syu xorg-xset
```

Restart to apply this setting.

# Touchpad settings

```
$ sudo nvim /etc/X11/xorg.conf.d/30-touchpad.conf
```

```
Section "InputClass"
        Identifier "Touchpad"
        Driver "libinput"
        MatchIsTouchpad "on"
        Option "Tapping" "on"
        Option "ScrollMethod" "twofinger"
EndSection
```

Restart to apply this setting.

# Get dotfiles

Clone dotfiles from GitHub.

# Application launcher

```
$ sudo pacman -Syu rofi
```

# Status bar

```
$ sudo pacman -Syu i3blocks
```

# Audio

```
$ sudo pacman -Syu pulseaudio pavucontrol
```

Make sure sound and microphone are available.

# Backlight

https://wiki.archlinux.org/title/backlight

(In my case,`xorg-xbacklight` couldn't handle backlight.)

```
$ sudo pacman -Syu acpilight
```

To allow a normal user to do `xbacklight`:

```
$ sudo usermod -a -G video <user-name>
```

Re-login to activate new group.

# Wallpaper

```
$ sudo pacman -Syu feh archlinux-wallpaper
```

# Suspend on lid switch

// TODO

i3lock

```
# /etc/systemd/logind.conf
...
HandleLidSwitch=suspend
...
```

```
// TODO:
// - Install `tlp` for battery life. (https://linrunner.de/tlp/)
```

# Emacs keybindings for GTK applications

https://wiki.archlinux.org/title/GTK#Emacs_key_bindings

# Japanese input method

https://wiki.archlinux.org/title/Fcitx5

```
$ sudo pacman -Syu fcitx5-im fcitx5-mozc
```

Append the following code to `~/.xprofile`.

```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx5 &
```

Add "Mozc" as an input method on Fcitx Configuration app.
