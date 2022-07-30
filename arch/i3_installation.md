After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

# Install base-devel

base-devel includes `sudo`.

```
$ pacman -Syu base-devel
```

# Network settings

```
$ pacman -Syu networkmanager
$ systemctl enable NetworkManager
```
