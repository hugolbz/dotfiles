if [[ `uname -s` == "MINGW"* ]] || [[ `uname -s` == "MSYS"* ]] ; then
ssh-start-agent


. /etc/profile

alias cdsocosync="cd ~/socosync && . setup.sh"
alias cdnexo="cd ~/superproject/firmwares_rpu && . setup.sh"
alias fdfind="fd"

export PATH="$PATH":"/c/Program Files/LLVM/bin/:/c/Users/hl215844/AppData/Local/Programs/KDiff3/bin"
# So nvim uses dotfiles
export XDG_CONFIG_HOME="$HOME/.config"

[ ! -f ~/.fzf.bash ] && fzf --bash > ~/.fzf.bash
. ~/.fzf.bash

fi
