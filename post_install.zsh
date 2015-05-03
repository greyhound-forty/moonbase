#!/usr/bin/env zsh

setopt EXTENDED_GLOB
for rcfile in "${MOONBASE:-$HOME}"/.moonbase/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${MOONBASE:-$HOME}/.${rcfile:t}"
done


git clone git://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh >/dev/null 2>&1