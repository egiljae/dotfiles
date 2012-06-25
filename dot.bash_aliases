#! /bin/bash

# General aliases
alias l="ls --color=auto"
alias ll="ls -lh --color=auto"
alias lla="ls -lah --color=auto"
alias updateupgrade="sudo apt-get update && sudo apt-get upgrade"
alias grep="grep --color=auto"

# Find a host in $HOME/.aliases 
function getSSHLineFromAliases {
    user=$(sed -n "$1p" $HOME/.aliases | awk '{print $2}')
    if [[ $user == "" ]]; then
        # Line does not exist, return 1
        return 1
    fi
    host=$(sed -n "$1p" $HOME/.aliases | awk '{print $3}')
    port=$(sed -n "$1p" $HOME/.aliases | awk '{print $4}')
    if [[ $port == "" ]]; then 
        port="22"
    fi
    echo "ssh -p $port $2 $user@$host"
}

function getFieldFromAliases {
    echo `sed -n "$1p" $HOME/.aliases | awk "{print \\$$2}"`
}

if [ -s $HOME/.aliases ]; then
    # Hosts, first line has a comment
    count=0
    while read line; do
        count=$(($count + 1))
        if echo $line | grep -q "#"; then
            # Line has a hash comment, skip
            continue
        fi
        alias `getFieldFromAliases $count 1`="`getSSHLineFromAliases $count`"
    done < $HOME/.aliases

    # IRC
    alias irc="`getSSHLineFromAliases 3 -t` 'screen -dr irc'"

    # WOL
    alias wakemediabox="`getSSHLineFromAliases 5` bin/wake_mediabox"
    alias wakewally="`getSSHLineFromAliases 5` bin/wake_wally"

    # B related
    alias bnews="`getSSHLineFromAliases 2` 'bin/news'"
    alias bsearch="`getSSHLineFromAliases 2` 'bin/search'"

    # X related
    alias xnews="`getSSHLineFromAliases 4` news"
    alias xsearch="`getSSHLineFromAliases 4` search"

    # S releated
    alias snews="`getSSHLineFromAliases 9` 'bin/news'"

    # All news
    alias news="echo '***** `getFieldFromAliases 2 3` *****'; bnews; echo '***** `getFieldFromAliases 4 3` *****'; xnews; echo '***** `getFieldFromAliases 9 3` *****'; snews"
fi
