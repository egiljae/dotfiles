#! /bin/bash

# General aliases
alias l="ls --color=auto"
alias ll="ls -lh --color=auto"
alias lla="ls -lah --color=auto"
alias updateupgrade="sudo apt-get update && sudo apt-get upgrade"

# Find hosts at line
function hostAtLine() {
    user=$(sed -n "$1p" $HOME/.hosts | awk '{print $1}')
    host=$(sed -n "$1p" $HOME/.hosts | awk '{print $2}')
    port=$(sed -n "$1p" $HOME/.hosts | awk '{print $3}')
    tool=$(sed -n "$1p" $HOME/.hosts | awk '{print $4}')
    if [[ $port == "" ]]; then 
        port="22"
    fi
    if [[ $tool == "" ]]; then 
        tool="ssh" 
    fi
    echo "$tool -p $port $user@$host"
}


if [ -s $HOME/.hosts ]; then
    alias bos="`hostAtLine 1`"
    alias col="`hostAtLine 2`"
    alias xfiles="`hostAtLine 3`"
    alias bubba="`hostAtLine 4`"
    alias mediabox="`hostAtLine 5`"
    alias wally="`hostAtLine 6`"
    alias slimbox="`hostAtLine 7`"

    # WOL
    alias wakemediabox="`hostAtLine 4` bin/wake_mediabox"
    alias wakewally="`hostAtLine 4` bin/wake_wally"

    # X related
    alias xnews="`hostAtLine 3` news"
    alias xsearch="`hostAtLine 3` search"

    # B related
    if [[ `hostname` == "boss" ]]; then
        alias bnews="cat bin/wopr/list*"
        alias bsearch="search"
    else
        alias bnews="`hostAtLine 1` 'cat bin/wopr/list*'"
        alias bsearch="`hostAtLine 1` search"
    fi
fi
