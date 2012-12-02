#! /bin/bash

# General aliases
alias l="ls --color=auto"
alias ll="ls -lh --color=auto"
alias lla="ls -lah --color=auto"
alias updateupgrade="sudo apt-get update && sudo apt-get upgrade"
alias grep="grep --color=auto"

# Find a host in $HOME/.aliases 
function getSSHLineFromAliases {
    user=$(sed -n "$1p" $HOME/.aliases | awk '{print $3}')
    if [[ $user == "" ]]; then
        # Line does not exist, return 1
        return 1
    fi 
    type=$(sed -n "$1p" $HOME/.aliases | awk '{print $2}')
    host=$(sed -n "$1p" $HOME/.aliases | awk '{print $4}')
    port=$(sed -n "$1p" $HOME/.aliases | awk '{print $5}')
    if [[ $port == "" ]]; then 
        port="22"
    fi
    if [[ $type == "mosh" ]]; then
        port="2222"
    fi
    echo "$type -p $port $2 $user@$host"
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
    alias irc="`getSSHLineFromAliases 3` -- screen -dr irc"

    # WOL
    alias wake_wally="`getSSHLineFromAliases 2` wake wally"
    alias wake_mediabox="`getSSHLineFromAliases 2` wake mediabox"

    # B related
    alias bnews="`getSSHLineFromAliases 2` 'bin/pathscripts/news'"
    alias bsearch="`getSSHLineFromAliases 2` 'bin/pathscripts/search'"

    # X related
    alias xnews="`getSSHLineFromAliases 4` news"
    alias xsearch="`getSSHLineFromAliases 4` search"

    # S releated
    alias snews="`getSSHLineFromAliases 9` 'bin/news'"
    alias sup="`getSSHLineFromAliases 9` 'if pgrep rtorrent &> /dev/null; then echo UP; else echo DOWN; fi'"

    # All news
    alias news="echo '***** `getFieldFromAliases 2 4` *****'; bnews; echo '***** `getFieldFromAliases 4 4` *****'; xnews; echo '***** `getFieldFromAliases 9 4` *****'; snews"
fi
