#!/bin/bash
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Install Nerd Fonts
install_font(){
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/$1.zip
    unzip $1.zip -d ~/.local/share/fonts
    fc-cache -fv
    rm $1.zip
}

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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

