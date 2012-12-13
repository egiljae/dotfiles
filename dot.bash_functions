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
    pwi=$RANDOM; let "pwi %= 100"; pwgen -sN 100 $1 | xargs | awk "{print \$$pwi}"
}
