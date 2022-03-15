.DEFAULT_GOAL := install-system-dotfiles
ostype := $(shell uname)
git := $(shell which git)
vim_plugin_path := ~/.vim/pack
gruvbox := "https://github.com/morhetz/gruvbox"
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
	cp .alacritty_macos.yml ~/.config/alacritty/alacritty.yml
else ifeq ($(ostype),Linux)
	cp .alacritty_linux.yml ~/.config/alacritty/alacritty.yml
endif
.PHONY := install-alacritty-config

install-tmux-conf: install-alacritty-config
ifeq ($(ostype),Darwin)
	cp .tmux_macos.conf ~/.tmux.conf
else ifeq ($(ostype),Linux)
	cp .tmux_linux.conf ~/.tmux.conf
endif
.PHONY := install-tmux-conf

install-system-dotfiles: install-tmux-conf
	cp .bashrc ~/
	cp .bash_profile ~/
	cp .vimrc ~/
.PHONY := install-system-dotfiles

#install-vim-plugins: install-system-dotfiles
#ifeq ($(git),)
#	@echo Git does not seem to be installed. Install git to add Vim plugins
#else
#	@echo Install Vim plugins
#	mkdir -p ~/.vim/pack/{colors,filemanagers,plugins}/start
#	git clone https://github.com/morhetz/gruvbox $(vim_plugin_path)/colors/start/
#endif
#.PHONY := install-vim-plugins
