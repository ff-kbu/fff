#!/bin/sh

# Data will vanish after 10min by design of alfred
# Thus this script is be called every 5 minutes

# Test - if alfred is crashed / frozen, restart
# No data -> return code 0, too
/usr/sbin/alfred -r 94

#Check for non-zero return code
if [ $? -ne 0 ]; then
    /etc/init.d/alfred restart 
fi


version=$(cat /etc/freifunk_version)
machine=$(cat /tmp/sysinfo/model)

echo -n $version | /usr/sbin/alfred -s 94
echo -n $machine | /usr/sbin/alfred -s 110

. /lib/functions.sh
. /lib/ar71xx.sh
tp_model=$(tplink_get_hwid)
echo -n $tp_model | /usr/sbin/alfred -s 158
