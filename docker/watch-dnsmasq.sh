#!/bin/sh
cfg="/srv/shoesmith/dnsmasq.conf"
cmd=/usr/sbin/dnsmasq --no-daemon -C \"$cfg\"

ltime=""
pid=""

set -e
trap 'kill -TERM $pid' TERM INT

while 
mtime=stat -c %Y -- $cfg

if [ "$ltime" -ne "$mtime" ]
then
ltime=$mtime
[ -z $pid ] || kill -TERM $pid
$cmd &
pid=$!
fi

kill -0 $pid
do sleep 1
done

trap - TERM INT
wait $pid
