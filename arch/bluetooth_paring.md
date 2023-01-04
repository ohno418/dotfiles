# An issue on paring a headset device

```
$ bluetoothctl
[bluetooth]# pair xx:xx:xx
Attempting to pair with xx:xx:xx
[CHG] Device xx:xx:xx Connected: yes
Failed to pair: org.bluez.Error.AuthenticationFailed
[CHG] Device xx:xx:xx Connected: no
```

# Attempting logs

## pulseaudio-bluetooth

```
$ sudo pacman -S pulseaudio-bluetooth
$ pulseaudio -k
$ pulseaudio --start
```

Doesn't work.

## SSP mode

ref: https://wiki.archlinux.org/title/bluetooth_headset#Pairing_fails_with_AuthenticationFailed

### enable

```
$ sudo systemctl stop bluetooth.service
$ sudo btmgmt ssp on
hci0 Set Secure Simple Pairing complete, settings: powered ssp br/edr le secure-conn
$ sudo systemctl start bluetooth.service
$ bluetoothctl
[bluetooth]# pair xx:xx:xx
```

Doesn't work.

### disable

```
$ sudo systemctl stop bluetooth.service
$ sudo btmgmt ssp off
hci0 Set Secure Simple Pairing complete, settings: powered ssp br/edr le secure-conn
$ sudo systemctl start bluetooth.service
$ bluetoothctl
[bluetooth]# pair xx:xx:xx
```

Doesn't work.

### After doing a lot of things...

```
$ bluetoothctl
[bluetooth]# connect xx:xx:xx
```

does work.

I didn't find what is essential. But when I removed `pulseaudio-bluetooth`, as an experiment, the bluetooth connection stopped working. So this package must have something to do with it.

To debug, the following command may help:

```
[bluetooth]# info xx:xx:xx
```
