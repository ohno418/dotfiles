# Run

exec:
```
$ git clone
$ cd dwl
$ make
$ ./dwl
```

config:
```
$ ln -f ../dotfiles/dwl_config.h ./config.h
```

# Issues

- Firefox cannot start. `glxtest: VA-API test failed to initialise VAAPI connection.`
  - solution: `$ sudo pacman -S intel-media-driver`
  - ref: https://www.reddit.com/r/archlinux/comments/xt4t2m/anyone_having_issues_with_firefox_after_update/
