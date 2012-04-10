#! /bin/bash

# cd, because typing the backslash is ALOT of work!!
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias l="ls --color=auto"
alias ll="ls -lh --color=auto"
alias 'ls -la'="ls -lah --color=auto"
alias updateupgrade="sudo apt-get update && sudo apt-get upgrade"

# hosts
function hostAtLine() {
    user=$(sed -n "$1p" $HOME/.hosts | awk '{print $1}')
    host=$(sed -n "$1p" $HOME/.hosts | awk '{print $2}')
    port=$(sed -n "$1p" $HOME/.hosts | awk '{print $3}')
    if [[ $port == "" ]]; then
        port="22"
    fi
    tool=$(sed -n "$1p" $HOME/.hosts | awk '{print $4}')
    if [[ $tool == "" ]]; then
        tool="ssh"
    fi
    echo "$tool -p $port $user@$host"
}

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


# boss related
if [[ `hostname -s` == "boss" ]]; then
    alias list="cat $HOME/bin/list*"
fi

# X related
alias news="`hostAtLine 3` news"
alias search="`hostAtLine 3` search"
