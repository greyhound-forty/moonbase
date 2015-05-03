#!/usr/bin/env bash

## Check to see if git, tmux, keychain, zsh, and wget are installed, prompt to install if not 
## pkglist = vim, tmux, zsh, git, keychain

## maybe a case statement here instead
## for s in 
## Send notice about package checking and install

if [[ $(dpkg-query -W -f='${Status}' "$i" 2>/dev/null | grep -c "ok installed") = "1" ]]; then
    echo '"$i" installed'
else
    echo '"$i" not installed, installing now'
    apt-get -y "$i"
fi


## Grab repo with prezto setup

git clone --recursive https://github.com/greyhound-forty/moonbase.git "${MOONBASE:-$HOME}/.moonbase"


