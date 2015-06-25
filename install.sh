#!/bin/bash
ln -s -bi $PWD/vimrc ~/.vimrc

mkdir -p ~/.config/fish/
ln -sbi $PWD/config.fish ~/.config/fish/config.fish

ln -sbi $PWD/xmonad.hs ~/.xmonad/xmonad.hs
ln -sbi $PWD/xmobarrc ~/.xmobarrc

sudo ln -sbi $PWD/hosts /etc/hosts

sudo pip install --upgrade -r requirements.txt
