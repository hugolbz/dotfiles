export LANG=en_US.utf8
export EDITOR=nvim

# Remap caps lock to esc
pidof Xorg && setxkbmap -option caps:escape
pidof X && setxkbmap -option caps:escape
# On wayland: go to gnome-tweak-tool > keyboard > ...
