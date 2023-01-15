This is my personal logs.

# Install

From AUR: https://aur.archlinux.org/packages/river

# init file

Copy from `/example/init` in the source code to `~/.config/river/init`.

```
$ cp ~/aur/river/src/river-0.1.3/example/init ./river_init
$ chmod 755 ./river_init
$ mkdir ~/.config/river
$ ln -sf $(pwd)/river_init ~/.config/river/init
```

# seatd

```
$ sudo systemctl enable seatd
$ sudo systemctl start seatd
```

Disabled later.

# status bar

Installed `yambar-git`: https://codeberg.org/dnkl/yambar

# To build from the source

got zig 0.10.0 from aur:

https://aur.archlinux.org/packages/zig-static

```
$ zig build
```
