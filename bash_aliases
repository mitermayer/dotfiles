# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# add some colours
# Fix gnome-terminal color support
if [ "$COLORTERM" == "gnome-terminal" ]; then
    export TERM="xterm-256color"
elif [ "$COLORTERM" == "mate-terminal" ]; then
    export TERM="xterm-256color"
elif [ "$COLORTERM" == "Terminal" ]; then
    # XFCE Terminal
    export TERM="xterm-256color"
elif [ "$COLORTERM" == "xfce4-terminal" ]; then
    export TERM="xterm-256color"
elif [ "$FBTERM" == "1" ]; then
    export TERM="fbterm"
elif [ "$TERM" == "xterm" ]; then
    # If shell reports just 'xterm', it may be PuTTY
    if [ -e ~/bin/answerback ]; then
        export ANSWERBACK=$(~/bin/answerback)
        if [ "x$ANSWERBACK" == "xPuTTY" ]; then
            export TERM="xterm-256color"
            export COLORTERM="putty-256color"
            export LANG="C"
        fi
    fi
fi

if [ "$TERMINAL_OVERRIDE" != "" ]; then
    # Some things just refuse to accept their own
    # configuration options for these things.
    export TERM=$TERMINAL_OVERRIDE
fi

if [ "$TERM" == "screen-bce" ]; then
    # I use screen under 256-color-supportive things
    # far more often than not, so give me 256-colors
    export TERM=screen-256color
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# virtualenv settings
#export WORKON_HOME=$HOME/.virtualenvs

source ~/.aliases
source ~/.functions
