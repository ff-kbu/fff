#!/bin/sh

# Data will vanish after 10min by design of alfred
# Thus this script is be called every 5 minutes

version=$(cat /etc/freifunk_version)
mac=$(uci get freifunk.@node[0].nodeid)
machine=$(awk 'BEGIN{FS="[ \t]+:[ \t]"} /machine/ {print $2}' /proc/cpuinfo)

echo $version | /usr/sbin/alfred -s 94
echo $mac |  /usr/sbin/alfred -s 192
echo $machine | /usr/sbin/alfred -s 110

. /etc/functions.sh
. /lib/ar71xx.sh
tp_model=$(tplink_get_hwid)
echo $tp_model | /usr/sbin/alfred -s 158
