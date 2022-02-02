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
  fi
  ## By default, search for all node images.
  NODE_IMAGE_SEARCH="node:lts*"
  ## This will search all Node.js images that are LTS and select the newest
  NODE_DOCKER_IMAGE=$(docker images --filter reference="${NODE_IMAGE_SEARCH}" -q | head -n 1)
  docker run -it --rm ${NODE_DOCKER_IMAGE} npm
}