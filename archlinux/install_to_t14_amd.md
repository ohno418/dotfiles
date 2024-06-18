Installation memo for T14 AMD.

# Packages on chroot

networkmanager
neovim
amd-ucode

# After installation guide

1. Enable and start networkmanager.service.
2. Install base-devel.
3. Add user to `wheel` group, passwd, and edit /etc/sudoers.
4. Reboot and login as the new user.
5. Install git, zsh, river, foot, and firefox.
6. Change default shell: `chsh -s /bin/zsh`.
7. Git clone dotfiles and deploy it.
8. Reboot. (Re-login is not enough.)

# misc

packages:
- tmux, openssh, waylock
- media: pipewire-pulse (needs rebooting), pamixer, brightnessctl
- screenshot: grim, slurp
- font: noto-fonts-emoji, otf-ipaexfont (noto-fonts is dependency of firefox and others.)
- IME: fcitx5-im fcitx5-mozc (then add "mozc" on `fcitx5-configtool`)

screen sharing:
Install xdg-desktop-portal-wlr, then reboot.

Emacs-like keybindings for GTK apps:
https://wiki.archlinux.org/title/GTK#Emacs_key_bindings

# Power management

With s2idle state, the battery drains too much even when on sleep. Fix by adding
`acpi.ec_no_wakeup=1` to the kernel parameters in
`/boot/loader/entries/arch.conf`.
