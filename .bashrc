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
GOPATH="$HOME/coding/go"
export GOPATH
PATH="$HOME/.local/bin:$HOME/.local/bin/go/bin:$HOME/bin:/usr/local/bin/go/bin/:$GOPATH/bin:$PATH"
export PATH
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/adam.beamer/.local/bin/gcloud/google-cloud-sdk/path.bash.inc' ]; then . '/Users/adam.beamer/.local/bin/gcloud/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/adam.beamer/.local/bin/gcloud/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/adam.beamer/.local/bin/gcloud/google-cloud-sdk/completion.bash.inc'; fi
# Source things here
source .bash_aliases
source .bash_exports
