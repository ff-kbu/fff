#!/bin/sh

# Data will vanish after 10min by design of alfred
# Thus this script is be called every 5 minutes

version=$(cat /etc/freifunk_version)
mac=$(uci get freifunk.@node[0].nodeid)

echo $version | /usr/sbin/alfred -s 94
echo $mac |  /usr/sbin/alfred -s 192


