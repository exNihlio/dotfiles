#!usr/bin/env bash

set -e

DIRNAME=$(dirname ${0})

cp .bashrc ~/

cp .bash_profile ~/

cp .vimrc ~/

cp .tmux.conf ~/

cp .bash_functions ~/

cp .bash_exports ~/

cp .bash_aliases ~/
## Install for Mac
if [[ $(uname)=='Darwin' ]]; then
  if [[ -d ~/.config/alacritty ]]; then
    cp .alacritty_macos.yml ~/.config/alacritty/alacritty.yml
  else
    mkdir -p ~/.config/.alacritty_macos.yml && cp .alacritty_macos.yml ~/.config/alacritty/alacritty.yml
  fi
## Install for Linux
elif [[ $(uname)=='Linux' ]]; then
  if [[ -d ~/.config/alacritty ]]; then
    cp .alacritty_linux.yml ~/.config/alacritty/alacritty.yml
  else
    mkdir -p ~/.config/.alacritty_linux.yml && cp .alacritty_linux.yml ~/.config/alacritty/alacritty.yml
  fi
fi


# Only copy the .git if it hasn't be copied yet
if [[ -z ~/.git ]]; then
  cp -R .git ~/
fi

#cp .did.md ~/

cp .gitignore ~/

echo "Installed dotfiles"
