1. Change the mirror list, and synchronize to it.

```
$ sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
```

2. Install packages.

For installing packages, make sure to update the system together.

```
$ sudo pacman -Syu <newpackage>
```

3. Change keymapping.

Both console and X11 keyboard settings are needed.

(ref: https://wiki.archlinux.org/index.php/Linux_console/Keyboard_configuration)

  1. Console

  ```
  $ sudo mkdir -p /usr/local/share/kbd/keymaps
  $ sudo vim /usr/local/share/kbd/keymaps/personal.map
    ```
    keycode 58 = Control
    ```
  $ sudo vim /etc/vconsole.conf
    ```
    VC Keymap: /usr/local/share/kbd/keymaps/personal.map
    ```
  ```

  2. X11/Xorg

  ```
  $ sudo vim /etc/X11/xorg.conf.d/00-keyboard.conf
    ```
    Option "XkbOptions" "ctrl:swapcaps"
    ```
  ```

Restart.

4. Japanese input.

```
$ sudo pacman -Syu fcitx-mozc fcitx-gtk2 fcitx-gtk3 fcitx-qt5 fcitx-im
$ vim ~/.xprofile
  ```
  export LANG="ja_JP.UTF-8"
  export XMODIFIERS="@im=fcitx"
  export XMODIFIER="@im=fcitx"
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export DefaultIMModule=fcitx
  ```
$ vim ~/.bashrc
  ```
  export GTK_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  export QT_IM_MODULE=fcitx
  ```
```

Restart.

5. Xfce terminal settings.

For shortcuts, edit `~/.config/xfce4/terminal/accels.scm`.

6. Xfce keybindings settings.

```
$ vim ~/.config/gtk-3.0/settings.ini
  ```
  [Settings]
  gtk-key-theme-name = Emacs
  ```
$ xfconf-query -c xsettings -p /Gtk/KeyThemeName -s Emacs
```

7. Power management

Make sure to suspend or hibernate when lid is closed.
