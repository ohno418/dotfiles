# Run

```
$ git clone git@github.com:ohno418/dwl.git
$ cd dwl
$ ln -f ../dotfiles/dwl/config.h ./config.h
$ make
$ ./dwl
```

# Issues

- Firefox cannot start. `glxtest: VA-API test failed to initialise VAAPI connection.`
  - solution: `$ sudo pacman -S intel-media-driver`
  - ref: https://www.reddit.com/r/archlinux/comments/xt4t2m/anyone_having_issues_with_firefox_after_update/
