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

Reboot to login as a general user.

# Install i3-gaps

Install i3-gaps with X.

```
$ sudo pacman -Syu xorg-server i3-gaps
```

Install a terminal emulator and fonts that are necessary for i3.

```
$ sudo pacman -Syu alacritty noto-fonts noto-fonts-cjk noto-fonts-emoji
```

Install xinit and set up to start i3 automatically with `startx`. Then get into i3.

```
$ sudo pacman -Syu xorg-xinit
$ echo 'exec i3' > ~/.xinitrc
$ startx
```

# Install essential packages

```
$ sudo pacman -Syu firefox tmux git openssh man-db man-pages xclip
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

Restart to apply this setting.

### key repeat rate

Actual setting is in i3 config. All have to do is to enable `xset` command.

```
$ sudo pacman -Syu xorg-xset
```

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

# Audio

```
$ sudo pacman -Syu pulseaudio pamixer
```

Make sure sound and microphone are available. If mic volume is too low:

```
$ pamixer --default-source --get-volume
$ pamixer --default-source --set-volume 80
```

# Backlight

memo: `brightnessctl` is a much lighter package and works fine.

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

# Launcher and status bar

```
$ sudo pacman -Syu rofi i3blocks acpi
```

`acpi` is for battery status.

# Wallpaper

Put a wallpaper image in `/usr/share/backgrounds/`.

```
$ mkdir /usr/share/backgrounds/
$ sudo cp dotfiles/i3/wallpaper.png /usr/share/backgrounds/wallpaper.png
$ sudo pacman -Syu feh
```

# Lock on lid closed

```
$ sudo pacman -Syu i3lock xss-lock
```

# Emacs keybindings for GTK applications

https://wiki.archlinux.org/title/GTK#Emacs_key_bindings

# Japanese input method

https://wiki.archlinux.org/title/Fcitx5

```
$ sudo pacman -Syu fcitx5-im fcitx5-mozc
```

Add the following code to the beginning of `~/.xinitrc`.

```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx5 &
```

Add "Mozc" as an input method on Fcitx Configuration app.

# Battery saving

https://wiki.archlinux.org/title/TLP#Installation

```
$ sudo pacman -Syu tlp
$ sudo systemctl enable tlp.service
$ sudo systemctl start tlp.service
```

# Hide mouse cursor when unneeded

```
$ sudo pacman -Syu unclutter
```

Add the following code to the beginning of `~/.xinitrc`.

```
unclutter &
```

# Screenshot

```
$ pacman -Syu maim
```

# Enable SDD TRIM

```
$ sudo systemctl enable fstrim.timer
```

# Set up to run `startx` automatically when login

Add the following code to the beginning of `~/.bash_profile`.

```
[ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ] && startx
```
