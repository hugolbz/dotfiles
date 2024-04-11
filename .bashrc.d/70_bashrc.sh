export LANG=en_US.utf8
export EDITOR=nvim

# Remap caps lock to esc
if [[ -z "${DISPLAY}" ]]; then
# Use setxkbmap on a Xorg server
pidof Xorg && setxkbmap -option caps:escape
pidof X && setxkbmap -option caps:escape
fi
# On wayland: go to gnome-tweak-tool > keyboad > ...
