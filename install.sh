#!/bin/bash
ln -s -bi $PWD/vimrc ~/.vimrc

mkdir -p ~/.config/fish/config.fish
ln -sbi $PWD/config.fish ~/.config/fish/config.fish

ln -sbi $PWD/xmonad.hs ~/.xmonad/xmonad.hs

sudo ln -sbi $PWD/hosts /etc/hosts

sudo pip install --upgrade -r requirements.txt
