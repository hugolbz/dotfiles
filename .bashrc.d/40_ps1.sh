# Set git prompt

# non-printable characters must be encloed inside \[ and \]
# PS1='\[\033]0;$MSYSTEM:\w\007\]' # set window title
# PS1="$PS1"'\[\033[32m\]'       # change color
# PS1="$PS1"'\u@\h '             # user@host<space>
# PS1="$PS1"'\[\033[33m\]'       # change color
# PS1="$PS1"'\w'                 # curent working directory
# PS1="$PS1"'\[\033[35m\]'       # change color
# PS1="$PS1"'$(__git_ps1)'       # git prompt bash function
# PS1="$PS1"'\[\033[0m\]'        # change color
# PS1="$PS1"'\n'                 # new line
# PS1="$PS1"'$ '                 # prompt: always $

PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]\[\e[1;32m\]\$\[\e[m\] '

# Show all extra information about repo in few extra chars like *+%
# See .git-prompt for explanations
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWUPSTREAM="auto"

# EOF
