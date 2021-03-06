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
