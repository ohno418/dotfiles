1. Change the mirror list, and synchronize to it.

```
$ sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
```

2. For installing packages, make sure to update the system together.

```
$ sudo pacman -Syu newpackage
```
