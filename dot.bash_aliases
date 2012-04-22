#! /bin/bash

# General aliases
alias l="ls --color=auto"
alias ll="ls -lh --color=auto"
alias lla="ls -lah --color=auto"
alias updateupgrade="sudo apt-get update && sudo apt-get upgrade"

# Find a host in $HOME/.hosts, eventually with SSH options $2 
function getHostAtLine() {
    user=$(sed -n "$1p" $HOME/.hosts | awk '{print $1}')
    host=$(sed -n "$1p" $HOME/.hosts | awk '{print $2}')
    port=$(sed -n "$1p" $HOME/.hosts | awk '{print $3}')
    tool=$(sed -n "$1p" $HOME/.hosts | awk '{print $4}')
    if [[ $port == "" ]]; then 
        port="22"
    fi
    echo "ssh -p $port $2 $user@$host"
}


if [ -s $HOME/.hosts ]; then
    # Hosts
    alias bos="`getHostAtLine 1`"
    alias col="`getHostAtLine 2`"
    alias xfiles="`getHostAtLine 3`"
    alias bubba="`getHostAtLine 4`"
    alias mediabox="`getHostAtLine 5`"
    alias wally="`getHostAtLine 6`"
    alias slimbox="`getHostAtLine 7`"

    # IRC
    alias irc="`getHostAtLine 2 -t` 'screen -dr irc'"

    # WOL
    alias wakemediabox="`getHostAtLine 4` bin/wake_mediabox"
    alias wakewally="`getHostAtLine 4` bin/wake_wally"

    # X related
    alias xnews="`getHostAtLine 3` news"
    alias xsearch="`getHostAtLine 3` search"

    # B related
    if [[ `hostname` == "boss" ]]; then
        alias bnews="cat bin/wopr/list*"
        alias bsearch="search"
    else
        alias bnews="`getHostAtLine 1` 'cat bin/wopr/list*'"
        alias bsearch="`getHostAtLine 1` search"
    fi
fi
