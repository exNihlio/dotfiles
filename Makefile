.DEFAULT_GOAL := install-did-md
ostype := $(shell uname)
git := $(shell which git)
nvim_plugin_start_path := ~/.local/share/nvim/site/pack/plugins/start
plugin_urls := ("https://github.com/morhetz/gruvbox", \
                "https://github.com/kevinhwang91/rnvimr")
export  nvim_plugin_start_path
export  plugin_urls
detect-os:
ifeq ($(ostype),Darwin)
	@echo Detected OS type as Darwin
else ifeq ($(ostype),Linux)
	@echo Detected OS type as Linux
endif
.PHONY := detect-os

install-alacritty-config: detect-os
	mkdir -p ~/.config/alacritty
ifeq ($(ostype),Darwin)
	cp alacritty_macos.yml ~/.config/alacritty/alacritty.yml
else ifeq ($(ostype),Linux)
	cp alacritty_linux.yml ~/.config/alacritty/alacritty.yml
endif
.PHONY := install-alacritty-config

install-tmux-conf: install-alacritty-config
ifeq ($(ostype),Darwin)
	cp tmux_macos.conf ~/.tmux.conf
else ifeq ($(ostype),Linux)
	cp tmux_linux.conf ~/.tmux.conf
endif
.PHONY := install-tmux-conf

install-system-dotfiles: install-tmux-conf
	cp bashrc ~/.bashrc
	cp bash_profile ~/.bash_profile
	cp vimrc ~/.vimrc
.PHONY := install-system-dotfiles

install-neovim-init: install-system-dotfiles
	cp init.vim ~/.config/nvim/
.PHONY := install-neovim-initi

install-did-md: install-neovim-init
	gpg -d did.md.gpg >> did.md
	mv did.md ~/.did.md
