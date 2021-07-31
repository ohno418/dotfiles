# Package install settings

### Change the mirror list, and synchronize to it

```
$ sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
```

### Install packages

For installing packages, make sure to update the system together.

```
$ sudo pacman -Syu <newpackage>
```

# Change keymapping

Both vconsole and X11 keyboard settings are needed.

### Virtual Console

Map CapsLock to Ctrl.

https://wiki.archlinux.org/index.php/Linux_console/Keyboard_configuration

```
$ sudo mkdir -p /usr/local/share/kbd/keymaps
$ sudo vim /usr/local/share/kbd/keymaps/personal.map

  keycode 58 = Control

$ sudo vim /etc/vconsole.conf

  VC Keymap: /usr/local/share/kbd/keymaps/personal.map
```

### X11/Xorg

Exchange Ctrl and CapsLock.

https://wiki.archlinux.org/title/Xorg/Keyboard_configuration

```
$ sudo vim /etc/X11/xorg.conf.d/00-keyboard.conf

  Option "XkbOptions" "ctrl:swapcaps"
```

Restart.

# Xfce terminal shortcut settings

For shortcuts, edit `~/.config/xfce4/terminal/accels.scm`.

# Power management

On Xfce power manager,

- Suspend or hibernate when lid is closed.
- Sleep settings.

# Japanese input

// TODO:
//   There's room to improve this code.
//   https://wiki.archlinux.org/title/fcitx

```
$ sudo pacman -Syu fcitx-mozc fcitx-gtk2 fcitx-gtk3 fcitx-qt5 fcitx-im
$ vim ~/.xprofile

  // This line may be unneeded.
  // export LANG="ja_JP.UTF-8"
  export XMODIFIERS="@im=fcitx"
  export XMODIFIER="@im=fcitx"
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export DefaultIMModule=fcitx

$ vim ~/.bashrc

  export GTK_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  export QT_IM_MODULE=fcitx
```

Restart.

# Xfce keybindings settings

Change to Emacs keybindings.

```
$ vim ~/.config/gtk-3.0/settings.ini

  [Settings]
  gtk-key-theme-name = Emacs

$ xfconf-query -c xsettings -p /Gtk/KeyThemeName -s Emacs
```
