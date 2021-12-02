#!usr/bin/env bash

set -e

DIRNAME=$(dirname ${0})

cp .bashrc ~/

cp .bash_profile ~/

cp .vimrc ~/

cp .bash_functions ~/

cp .bash_exports ~/

cp .bash_aliases ~/
# Only copy the .git if it hasn't be copied yet
if [[ -z ~/.git ]]; then
  cp -R .git ~/
fi

#cp .did.md ~/

cp .gitignore ~/

echo "Installed dotfiles"
