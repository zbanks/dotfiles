dotfiles
========

My configuration files: .vimrc, xmonad.hs, fish.conf &amp; others

If you're brave, you can use `./install.sh` to become @zbanks.

fish
----
`config.fish`

- Use vim keybindings
- Export `EDITOR=vim`

/etc/hosts
----------
`hosts`

- DIY ad blocking and anti-tracking, specifically:
    - Reddit
    - Facebook (both facebook.com & facebook ads/tracking)
    - Google Analytics
    - And a ton more from a list I found once

apt
---
`apt` and `apt-build-dep`

- Basic tools (python, fish-shell, xmonad/xmobar)
- Media: vlc, ffmpeg
- EE: kicad, gerbv
- Missing google-chrome; download from Chrome's website

python
------
`requirements.txt`

- Django, DDT, celery, django-extensions
- flask, werkzeug
- numpy, matplotlib, pandas, scipy
- requests, httpie
- ipython, virtualenv
- (Relatively unmaintained)

Xmonad
------
`xmonad.hs`

- Use `xmodmap` to map Caps Lock to Escape
- Meta key: "Windows"
    - `Meta-Enter` launches terminal
    - `Meta-Ctrl-1`, etc. swap workspaces
    - `Shift-Volume` up/down/mute control Musicazoo
- 3 additional workspaces on `~`, `-`, and `=`
- Focus follows mouse
- Based on Gnome, Ubuntu orange border
- Top panel: `xmobar`
    - Todo: proper integration & reloading; hiding
- Launcher: `dmenu` at the top (`M-p`)

Xmobar
------
`xmobarrc`

- Tango color palette, dark on light-grey
- Battery | CPU | Memory | Top ... Mz | Weather (KBOS) | WiFi | Date
