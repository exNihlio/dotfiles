#!usr/bin/env bash

set -e

DIRNAME=$(dirname ${0})
OS_TYPE=$(uname)
cp .bashrc ~/

cp .bash_profile ~/

cp .vimrc ~/

## Install alacritty.yml and .tmux.conf or Mac
if [[ ${OS_TYPE} == 'Darwin' ]]; then
  echo "Installing for Darwin"
  cp .tmux_macos.conf ~/.tmux.conf
  if [[ -d ~/.config/alacritty ]]; then
    cp .alacritty_macos.yml ~/.config/alacritty/alacritty.yml
  else
    mkdir -p ~/.config/alacritty && cp .alacritty_macos.yml ~/.config/alacritty/alacritty.yml
  fi
## Install for Linux
elif [[ ${OS_TYPE} == 'Linux' ]]; then
  echo "Installing for Linux"
  cp .tmux_linux.conf ~/.tmux.conf
  if [[ -d ~/.config/alacritty ]]; then
    cp .alacritty_linux.yml ~/.config/alacritty/alacritty.yml
  else
    mkdir -p ~/.config/alacritty && cp .alacritty_linux.yml ~/.config/alacritty/alacritty.yml
  fi
fi


# Only copy the .git if it hasn't be copied yet
if [[ ! -d ~/.git ]]; then
  cp -R .git ~/
fi

#cp .did.md ~/

cp .gitignore ~/

echo "Installed dotfiles"
