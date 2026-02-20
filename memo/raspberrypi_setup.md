Run RaspberryPi Imager:

```
$ sudo WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_RUNTIME_DIR=$XDG_RUNTIME
_DIR rpi-imager
```

In order to LAN local access, you need these packages:

- avahi
- nss-mdns

Then you can access with:

```
$ ping raspberrypi.local
$ ssh raspberrypi.local
```
