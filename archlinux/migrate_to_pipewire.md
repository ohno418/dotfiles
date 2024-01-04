Migrate from PulseAudio to PipeWire.

```
$ systemctl status --user pulseaudio
● pulseaudio.service - Sound Service
     Loaded: loaded (/usr/lib/systemd/user/pulseaudio.service; disabled; preset: enabled)
     Active: active (running) since Thu 2024-01-04 18:38:00 JST; 21min ago
TriggeredBy: ● pulseaudio.socket
   Main PID: 2878 (pulseaudio)
      Tasks: 8 (limit: 18786)
     Memory: 6.1M (peak: 8.1M)
        CPU: 133ms
     CGroup: /user.slice/user-1000.slice/user@1000.service/session.slice/pulseaudio.service
             ├─2878 /usr/bin/pulseaudio --daemonize=no --log-target=journal
             └─2986 /usr/lib/pulse/gsettings-helper

Jan 04 18:38:00 ohnotp systemd[469]: Starting Sound Service...
Jan 04 18:38:00 ohnotp systemd[469]: Started Sound Service.
```

# 1. Remove PulseAudio.

```
$ sudo pacman -Rsu pulseaudio
```

```
$ systemctl status --user pulseaudio
● pulseaudio.service
     Loaded: not-found (Reason: Unit pulseaudio.service not found.)
     Active: active (running) since Thu 2024-01-04 18:38:00 JST; 23min ago
   Main PID: 2878 (pulseaudio)
        CPU: 134ms
     CGroup: /user.slice/user-1000.slice/user@1000.service/session.slice/pulseaudio.service
             ├─2878 /usr/bin/pulseaudio --daemonize=no --log-target=journal
             └─2986 /usr/lib/pulse/gsettings-helper

Jan 04 18:38:00 ohnotp systemd[469]: Starting Sound Service...
Jan 04 18:38:00 ohnotp systemd[469]: Started Sound Service.

# No unit service file.
$ ls /usr/lib/systemd/user | grep -i pulse
```

Rebooted.

```
$ systemctl status --user pulseaudio
Unit pulseaudio.service could not be found.
```

"Mute" or "Volume up/down" button doesn't work now. This is because pamixer
can't find PulseAudio (and it no longer exists).

# 2. Make pamixer work again.

```
$ sudo pacman -S pipewire-pulse
```

Rebooted to enable pipewire-pulse

```
$ ls /usr/lib/systemd/user | grep -i pulse
pipewire-pulse.service
pipewire-pulse.socket
```

```
$ systemctl status --user pipewire-pulse.service
● pipewire-pulse.service - PipeWire PulseAudio
     Loaded: loaded (/usr/lib/systemd/user/pipewire-pulse.service; disabled; preset: enabled)
     Active: active (running) since Thu 2024-01-04 19:12:04 JST; 2min 4s ago
TriggeredBy: ● pipewire-pulse.socket
   Main PID: 593 (pipewire-pulse)
      Tasks: 3 (limit: 18786)
     Memory: 4.8M (peak: 5.3M)
        CPU: 60ms
     CGroup: /user.slice/user-1000.slice/user@1000.service/session.slice/pipewire-pulse.service
             └─593 /usr/bin/pipewire-pulse

Jan 04 19:12:04 ohnotp systemd[449]: Started PipeWire PulseAudio.
```

# 3. Remove Jack.

```
$ sudo pacman -S pipewire-jack
resolving dependencies...
looking for conflicting packages...
:: pipewire-jack and jack2 are in conflict (jack). Remove jack2? [y/N] y

Package (2)          Old Version  New Version  Net Change  Download Size

jack2                1.9.22-1                   -1.89 MiB
extra/pipewire-jack               1:1.0.0-2      0.70 MiB       0.15 MiB

Total Download Size:    0.15 MiB
Total Installed Size:   0.70 MiB
Net Upgrade Size:      -1.18 MiB

:: Proceed with installation? [Y/n]
:: Retrieving packages...
 pipewire-jack-1:1.0.0-2-x86_64                                                         156.9 KiB   839 KiB/s 00:00 [---------------------------------------------------------------------] 100%
(1/1) checking keys in keyring                                                                                      [---------------------------------------------------------------------] 100%
(1/1) checking package integrity                                                                                    [---------------------------------------------------------------------] 100%
(1/1) loading package files                                                                                         [---------------------------------------------------------------------] 100%
(1/1) checking for file conflicts                                                                                   [---------------------------------------------------------------------] 100%
(2/2) checking available disk space                                                                                 [---------------------------------------------------------------------] 100%
:: Processing package changes...
(1/1) removing jack2                                                                                                [---------------------------------------------------------------------] 100%
(1/1) installing pipewire-jack                                                                                      [---------------------------------------------------------------------] 100%
Optional dependencies for pipewire-jack
    jack-example-tools: for official JACK example-clients and tools
:: Running post-transaction hooks...
(1/2) Reloading user manager configuration...
(2/2) Arming ConditionNeedsUpdate...
```

# 4. Reinstall pipewire as explicitly-installed.

```
$ sudo pacman -S --asexplicit pipewire
[sudo] password for ohno:
warning: pipewire-1:1.0.0-2 is up to date -- reinstalling
resolving dependencies...
looking for conflicting packages...

Package (1)     Old Version  New Version  Net Change

extra/pipewire  1:1.0.0-2    1:1.0.0-2      0.00 MiB

Total Installed Size:  3.16 MiB
Net Upgrade Size:      0.00 MiB

:: Proceed with installation? [Y/n]
(1/1) checking keys in keyring                            [-------------------------------] 100%
(1/1) checking package integrity                          [-------------------------------] 100%
(1/1) loading package files                               [-------------------------------] 100%
(1/1) checking for file conflicts                         [-------------------------------] 100%
(1/1) checking available disk space                       [-------------------------------] 100%
:: Processing package changes...
(1/1) reinstalling pipewire                               [-------------------------------] 100%
:: Running post-transaction hooks...
(1/2) Reloading user manager configuration...
(2/2) Arming ConditionNeedsUpdate...
```
