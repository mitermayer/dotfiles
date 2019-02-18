# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# enable globstart by default `./**/*`
shopt -s globstar

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=4000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

case "$TERM" in
*-256color)
    alias ssh='TERM=${TERM%-256color} ssh'
    ;;
*)
    POTENTIAL_TERM=${TERM}-256color
    POTENTIAL_TERMINFO=${TERM:0:1}/$POTENTIAL_TERM

    # better to check $(toe -a | awk '{print $1}') maybe?
    BOX_TERMINFO_DIR=/usr/share/terminfo
    [[ -f $BOX_TERMINFO_DIR/$POTENTIAL_TERMINFO ]] && \
        export TERM=$POTENTIAL_TERM

    HOME_TERMINFO_DIR=$HOME/.terminfo
    [[ -f $HOME_TERMINFO_DIR/$POTENTIAL_TERMINFO ]] && \
        export TERM=$POTENTIAL_TERM
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

set bell-style none
# setup keychain for ssh key management

KEYCHAIN_KEYS_FILE=$HOME/.key_chain_key
if [ -f $KEYCHAIN_KEYS_FILE ]; then
    source $HOME/.keychain/$HOSTNAME-sh 2>/dev/null

    while read line; do
        eval `keychain --eval --agents ssh $line 2>/dev/null`
    done < $KEYCHAIN_KEYS_FILE
fi

# vill shell
set -o vi

source $HOME/.aliases
source $HOME/.functions

# display some banner art
cat $HOME/.banner_art

# export custom bin
export PATH=$PATH:$HOME/bin:$HOME/.local/bin

# making sure the colors will work for some weird servers
alias tmux="tmux -2"
