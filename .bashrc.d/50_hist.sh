# Tune history
export HISTSIZE=10000
export HISTFILESIZE=10000
# & dont save repeated commands
export HISTIGNORE="&:[ ]*"
export HISTFILE=~/.bash_history
export HISTCONTROL=ignoreboth:erasedups

shopt -s histappend
history -n


# EOF
