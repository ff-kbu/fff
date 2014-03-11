#!/bin/sh
. /lib/ar71xx.sh

# Hardware-Address according to sticker
get_main_address() {
    dual_wifi=$(is_dual_wifi)
    if [ $dual_wifi -eq 1 ];then
    	$(get_radio_address "wlan1")
    else
	$(get_radio_address "wlan0")
    fi
}

get_radio_address(){
	$(ifconfig $1 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | awk '{print tolower($0)}')
}


# Node_Id = HW-Address, alphanumeric
get_node_id(){
	macaddr=$(get_main_address)
        echo ${macaddr//:/}
}

# Dual wifi? yes / no
is_dual_wifi(){
  local board="$(ar71xx_board_name)"
  case "$board" in
    tl-wdr3600|tl-wdr4300)
            echo 1
            ;;
    *)
            echo 0
            ;;
    esac
}