dotfiles
========

My configuration files: .vimrc, xmonad.hs, fish.conf &amp; others

If you're brave, you can use `./install.sh` to become @zbanks.

fish
----
`config.fish`

- Use vim keybindings! (Way better than readline vim keybindings, but still not complete...)
- Export `EDITOR=vim`

/etc/hosts
----------
`hosts`

- DIY ad blocking and anti-tracking, specifically:
    - Watch Cartoon Online
    - The Pirate Bay
    - Reddit
    - Facebook (both facebook.com & facebook ads/tracking)
    - Google Analytics
    - And a crapton more from a list I found once

python
------
`requirements.txt`

- Django, DDT, celery, django-extensions
- flask, werkzeug
- numpy, matplotlib, pandas, scipy
- requests, httpie
- ipython, virtualenv
- ...and so much more!

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

- Tango color palette (to match my terminals), dark on light-grey
- Battery | CPU | Memory | Top ... Weather (KBOS) | WiFi | Date
- (I really wish xmobar used normal Haskell files to configure!)
