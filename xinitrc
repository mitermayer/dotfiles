# Allow DPI file settings for high resolution screens

# Add Xsettings
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# for HIDPI support
if [ -f  ~/.DPI ]; then
    xrandr --dpi $( cat ~/.DPI )

    # HiDPI seetings
    [ -f ~/.XresourcesHIDPI ] && xrdb -merge ~/.XresourcesHIDPI
fi

exec ck-launch-session dbus-launch i3
