# Allow DPI file settings for high resolution screens
if [ -f  ~/.DPI ]; then
    xrandr --dpi $( cat ~/.DPI )
fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec ck-launch-session dbus-launch i3
