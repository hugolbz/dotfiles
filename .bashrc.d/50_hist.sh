# Tune history
export HISTSIZE=10000
export HISTFILESIZE=10000
# See https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history/18443#18443
# & dont save repeated commands
export HISTCONTROL=ignorespace:erasedups
shopt -s histappend
function historymerge {
    history -n; history -w; history -c; history -r;
}
trap historymerge EXIT
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# EOF
