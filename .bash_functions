function reattach-ssh-sock {
  if [[ ! -z ${SSH_AUTH_SOCK} ]]; then
    AUTH_SOCK_PATH=$(echo ${SSH_AUTH_SOCK} | cut -d"=" -f 2)
    if [[ ! -e ${AUTH_SOCK_PATH} ]]; then
      export SSH_AUTH_SOCK=$(find /tmp -name "agent*" -user $(whoami) -type s 2>/dev/null)
    fi
  fi
}
