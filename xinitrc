[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec ck-launch-session dbus-launch i3
