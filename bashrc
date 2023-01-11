# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;32m\]\n$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \h$\[\033[0m\033[0;32m\]\[\033[0m\] '
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
## Aliases
alias did="vim +'normal Go' +'r!date' ~/.did.md"
alias ':q'=exit
alias emacs='emacs -nw'
GOPATH="$HOME/coding/go"

PATH="$HOME/.local/bin:$HOME/.local/bin/go/bin:$HOME/bin:$GOPATH/bin:$PATH"
## Exports
export GOPATH
export PATH
if [[ $(which nvim; echo ${?})==0 ]]; then
  export EDITOR=nvim
  export GIT_EDITOR=nvim
else
  export EDITOR=vim
  export GIT_EDITOR=vim
fi

#export GIT_EDITOR=vim
#export EDITOR=vim
export AWS_REGION='us-west-2'
export SAM_CLI_TELEMETRY=0
## Functions
function reattach-ssh-sock {
  if [[ ! -z ${SSH_AUTH_SOCK} ]]; then
    AUTH_SOCK_PATH=$(echo ${SSH_AUTH_SOCK} | cut -d"=" -f 2)
    if [[ ! -e ${AUTH_SOCK_PATH} ]]; then
      export SSH_AUTH_SOCK=$(find /tmp -name "agent*" -user $(whoami) -type s -print -quit 2>/dev/null)
    fi
  fi
}

function json2yaml {
    /usr/bin/env python3 -c 'import json, yaml, sys; print(yaml.dump(json.loads(str(sys.stdin.read())), default_flow_style=False))'
}

function git-commit-count {
    echo "$(git branch | grep "^\*" | awk {'print $2'}):$(git log | grep -c "^commit")"
}

function docker-ecr-login {
    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin $(echo "$(aws sts get-caller-identity --query "Account" | tr -d '"').dkr.ecr.${AWS_REGION}.amazonaws.com")
}

##Run Node.js applications inside of Docker
function node-docker {
  docker --version &>/dev/null
  if (( ${?}!=0 )); then
    echo "Do you have Docker installed or is docker running?";
    exit 1
  fi
  ## By default, search for all node images.
  NODE_IMAGE_SEARCH="node:lts*"
  ## This will search all Node.js images that are LTS and select the newest
  NODE_DOCKER_IMAGE=$(docker images --filter reference="${NODE_IMAGE_SEARCH}" -q | head -n 1)
  docker run -it --rm -v $(pwd):/code ${NODE_DOCKER_IMAGE} node /code/${1}
}

## Grab a node REPL
function node-repl-docker {
  docker --version &>/dev/null
  if (( ${?}!=0 )); then
    echo "Do you have Docker installed or is docker running?";
    exit 1
  fi
  ## By default, search for all node images.
  NODE_IMAGE_SEARCH="node:lts*"
  ## This will search all Node.js images that are LTS and select the newest
  NODE_DOCKER_IMAGE=$(docker images --filter reference="${NODE_IMAGE_SEARCH}" -q | head -n 1)
  docker run -it --rm ${NODE_DOCKER_IMAGE} node
}

function npm-docker {
  docker --version &>/dev/null
  if (( ${?}!=0 )); then
    echo "Do you have Docker installed or is docker running?";
    exit 1
  fi
  ## By default, search for all node images.
  NODE_IMAGE_SEARCH="node:lts*"
  ## This will search all Node.js images that are LTS and select the newest
  NODE_DOCKER_IMAGE=$(docker images --filter reference="${NODE_IMAGE_SEARCH}" -q | head -n 1)
  docker run -it --rm ${NODE_DOCKER_IMAGE} npm
}
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/clairebeamer/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
if [[ -f "${HOME}/.cargo/env" ]]; then
  . "${HOME}/.cargo/env"
fi

if [[ -f "${HOME}/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
