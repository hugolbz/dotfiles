#!/bin/bash

## Bootstrap dotfiles:
# git clone --bare <git-repo-url> $HOME/.dotfiles
# git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
# . .bashrc
# install_font FiraMono
# dotfiles config --local status.showUntrackedFiles no

## Finish nvim install
# nvim +MasonInstallAll

## Update tools
# curl -L https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage -o ~/.local/bin/nvim && chmod u+x  ~/.local/bin/nvim
# For old linux systems:
# curl -L https://github.com/neovim/neovim-releases/releases/download/v0.11.1/nvim-linux-x86_64.appimage -o ~/.local/bin/nvim && chmod u+x  ~/.local/bin/nvim
#
# curl -L https://github.com/wez/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage -o ~/.local/bin/wezterm && chmod u+x  ~/.local/bin/wezterm

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Install Nerd Fonts
install_font(){
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/$1.zip
    unzip $1.zip -d ~/.local/share/fonts
    fc-cache -fv
    rm $1.zip
}

# git prompt
[ -f /usr/share/doc/git/contrib/completion/git-prompt.sh ] && source /usr/share/doc/git/contrib/completion/git-prompt.sh
# [ -f /etc/bash_completion.d/git-prompt ] && source /etc/bash_completion.d/git-prompt

#FZF
# On ubuntu:
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/bash-completion/completions/fzf ] && source /usr/share/bash-completion/completions/fzf
# On fedora
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "" || eval "LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -d ~/.bashrc.d ]; then
    for f in ~/.bashrc.d/*.sh; do
       . $f
    done
fi

if [ -d ~/.bash_completion.d ]; then
    for f in ~/.bash_completion.d/*.sh; do
       . $f
    done
fi

