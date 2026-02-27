Install packages:

- fwupd
- udisks2

Restart fwupd service (optional?):

```
$ systemctl restart fwupd
```

Make sure there's no error or warning:

```
$ fwupdmgr get-devices
```

Get updates:

```
$ fwupdmgr refresh
$ fwupdmgr get-updates
```

Update:

```
$ fwupdmgr update
```
