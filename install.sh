#!/bin/bash
ln -s -bi $PWD/vimrc ~/.vimrc
mkdir -p ~/.vim/swap ~/.vim/backups

mkdir -p ~/.config/fish/
ln -sbi $PWD/config.fish ~/.config/fish/config.fish

ln -sbi $PWD/xmonad.hs ~/.xmonad/xmonad.hs
ln -sbi $PWD/xmobarrc ~/.xmobarrc

sudo ln -sbi $PWD/hosts /etc/hosts

sudo apt-get update
sudo apt-get install $(cat apt | grep -v '^#' | tr '\n' ' ')
sudo apt-get build-dep $(cat apt-build-dep | grep -v '^#' | tr '\n' ' ')
sudo pip install --upgrade -r requirements.txt
