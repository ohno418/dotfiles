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

  3. Restart
