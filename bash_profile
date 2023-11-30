# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
# User specific environment and startup programs
if [[ -f /opt/homebrew/bin/brew ]]; then
  if [[ -z ${BREW_ANALYTICS} ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew analytics | grep "are enabled" &>/dev/null
    if [[ ${?}!=0 ]]; then
      brew analytics off &>/dev/null
      export BREW_ANALYTICS="disabled"
    fi
  fi
fi

if [[ -d "${HOME}/.nvm" ]]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [[ -f "${HOME}/.cargo/env" ]]; then
  . "${HOME}/.cargo/env"
fi

if [[ -f "${HOME}/.asdf" ]]; then
  . "${HOME}/.asdf/completions/asdf.bash"
fi

if [[ -d "${HOME}/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
