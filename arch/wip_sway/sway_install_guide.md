After official [installation guilde](https://wiki.archlinux.org/title/installation_guide).

# User

Add a user with sudo.

```
$ useradd -m -G wheel -s /bin/bash ohno
$ passwd ohno

# sudo
$ pacman -Syu sudo
$ EDITOR=nvim visudo /etc/sudoers
```

# Sway

https://wiki.archlinux.org/title/Sway

Install Sway with Alacritty (a text editor).

```
$ pacman -Syu sway alacritty
```

Enable access to hardware devices.

```
$ systemctl start seatd
$ systemctl enable seatd
$ usermod -a -G seat ohno
```

(maybe reboot requires to enable the group)

Configure.

```
$ mkdir ~/.config/sway/
$ cp /etc/sway/config ~/.config/sway/
```

- Set Alt key as mod key.
- Set Alacritty as default terminal.

Start Sway.

```
$ sway
```

# Essential apps and settings

```
$ pacman -Syu git openssh tmux neovim wl-clipboard base-devel man-db
```

Set up Github ([Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)), then pull and deploy dotfiles.

# Launcher

```
$ pacman -Syu wofi
```

(wip)
