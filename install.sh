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

if [[ -d ~/.config/alacritty ]]; then
  cp alacritty.yml ~/.config/alacritty/
fi
# Only copy the .git if it hasn't be copied yet
if [[ -z ~/.git ]]; then
  cp -R .git ~/
fi

#cp .did.md ~/

cp .gitignore ~/

echo "Installed dotfiles"
