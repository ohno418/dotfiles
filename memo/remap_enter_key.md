Use [keyd](https://github.com/rvaiya/keyd). See "Quickstart" in README.

Install end enable/start keyd daemon:

```
sudo pacman -S keyd
sudo systemctl enable keyd --now
```

Edit /etc/keyd/default.conf:

```
[ids]
*

[main]
rightalt = enter
```

Reload keyd daemon:

```
sudo keyd reload
```
