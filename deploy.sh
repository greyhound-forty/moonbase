#!/usr/bin/env bash

## Check to see if git, tmux, keychain, zsh, and wget are installed, prompt to install if not 
## pkglist = vim, tmux, zsh, git, keychain

## maybe a case statement here instead
## for s in 
## Send notice about package checking and install

apt-get update && apt-get upgrade -y

cat<<EOF> "$HOME"/pkglist
python-pip
zsh
git
tmux
keychain
python-dev
vim
wget
exuberant-ctags
EOF


for i in `cat "$HOME"/pkglist`; do
    if [[ $(dpkg-query -W -f='${Status}' "$i" 2>/dev/null | grep -c "ok installed") = "1" ]]; then
        echo "$i" already installed
    else
        echo "$i" not installed, installing now;
        sudo apt-get install -y "$i"
    fi
; done


ssh-keygen -b 2048 -N '' -f "$HOME"/.ssh/id_rsa -t rsa -q
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> "$HOME"/.ssh/config


## Grab repo with prezto setup

git clone --recursive https://github.com/greyhound-forty/moonbase.git "${MOONBASE:-$HOME}/.moonbase"

chsh -s /bin/zsh

chmod "$HOME"/.moonbase/post_install.zsh
/bin/zsh "$HOME"/.moonbase/post_install.zsh

curl -s ping.gg/ryantiffany@gmail.com >/dev/null 2>&1
sleep 60 && shutdown -r now 
