#! /bin/bash

memory() {
    if (( $# == 0 )); then
        echo -n "Total usage: "
    fi
    ps aux | awk "/$@/ {sum += \$6} END {printf \"%dMB\n\", sum/1024 }"
}

whatsmyip() {
    IP=$(curl -s ifconfig.me)
    if (( $? == 1)); then
        IP=$(curl -s checkip.dyndns.com | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")
        if (( $? != 0 )); then
            echo "No internet connection!"
        fi
    fi
    if [[ "$IP" != "" ]]; then
        echo "Current public IP: $IP"
    fi
}

numdays() {
    if (( $# != 2 )); then
        echo "Usage: $0 fromdate todate"
        echo "Eg. $0 01/01/2012 01/10/2012"
        return 1
    fi

    fromdate=$1
    todate=$2

    from=`echo $fromdate | awk  -F\. '{print $3$2$1}'`
    to=`echo $todate | awk  -F\. '{print $3$2$1}'`

    START_DATE=`date --date=$from +"%s"`
    END_DATE=`date --date=$to +"%s"`

    DAYS=$((($END_DATE - $START_DATE) / 86400 ))
    echo $DAYS
}

sshtunnel() {
    echo -n "Username: "
    read user
    echo -n "Remote server: "
    read host
    echo -n "Port: "
    read port
    if [[ $port == "" ]]; then
        port="8080"
    fi
    echo "Tunneling to $user@$host at port $port.."
    ssh -ND $port $user@$host
}

mkpasswd() {
    if (( $# != 1 )); then
        echo "Usage: $0 numcharacters"
        return 1
    fi
    pwi=$RANDOM; let "pwi %= 100"; pwgen -ysCN 100 $1 | sed "s/'/./g" | sed\
    's/"/-/g' | xargs | awk "{print \$$pwi}"
}

spotty() {
    session="spotify"

    tmux new -d -s $session
    tmux split-window -h
    tmux select-pane -t 1
    # Start mopidy
    tmux send-keys -t 1 "mopidy" C-m
    tmux select-pane -t 1
    # Show the clock
    tmux split-window -v
    tmux clock
    tmux select-pane -t 0
    tmux select-pane -t 0
    # Wait for mopidy to start, then start ncmpcpp
    sleep 2
    tmux send-keys -t 0 "ncmpcpp" C-m
    # Give ncmpcpp some space
    tmux resize-pane -R 50
    tmux att -t $session
}

extract() {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Mount encrypted volume
mountcryptv() {
    cryptsetup luksOpen $1 cdisk
}

gi() {
    curl http://gitignore.io/api/$@ ;
}
