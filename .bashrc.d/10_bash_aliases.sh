alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias gti='git'
if [ -f /usr/share/bash-completion/completions/git ]; then
	. /usr/share/bash-completion/completions/git
    __git_complete dotfiles __git_main
    __git_complete gti __git_main
fi

# list stuff
alias ll='ls -l'
alias la='ls -a'
alias l1='ls -1'
alias lr='ls -rst1'
alias lr2='ls -rst'

if  [ `uname -s` == "Linux" ] ; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ls='ls -F --color=auto'
elif [ `uname -s` == "MINGW32_NT-6.1" ] ; then
    alias gitk='git fetch && cmd.exe /c "gitk.cmd --all" &'
    alias ls='ls --color'
fi

alias mps='ps -u $USER'
alias cp='cp -i'
alias mv='mv -i'

function cheat() {
    curl cht.sh/$1
}

if ! command -v fd >/dev/null 2>&1
then
    alias fd='fdfind'
fi
alias qtvim='nvim-qt --nvim $HOME/.local/bin/nvim --no-ext-tabline --no-ext-popupmenu' 
alias vim='$HOME/.local/bin/nvim'
alias neovim='$HOME/.local/bin/nvim'
alias wim='wezterm start -- nvim'
alias rga='rg --no-ignore --hidden'
alias fda='fd --no-ignore --hidden'
alias clip='xsel --clipboard' # Copy to/paste from clipboard
