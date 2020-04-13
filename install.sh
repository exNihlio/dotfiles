#!usr/bin/env bash

set -e

DIRNAME=$(dirname ${0})

cp .bashrc ~/

cp .bash_profile ~/

cp .vimrc ~/

cp -R .git ~/

echo "Installed dotfiles"
