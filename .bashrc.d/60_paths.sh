if  [ `uname -s` == "Linux" ] ; then

    # Setting CDPATH
    CDPATH="$HOME/projects/"

elif [ `uname -s` == "MINGW32_NT-6.1" ] ; then

    # Setting CDPATH to point sw/fgc
    # Customize the subdirs to suit your needs
    CDPATH="/c/local/$USERNAME/projects/"

    # Add kdiff3 to path
    export PATH="$PATH:/c/Program Files (x86)/Kdiff3/"
    export PATH="$PATH:/c/Program Files/Kdiff3/"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# EOF
