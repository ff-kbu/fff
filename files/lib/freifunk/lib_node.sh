#!/bin/sh
. /lib/ar71xx.sh

# Hardware-Address according to sticker
get_main_address() {
    dual_wifi=$(is_dual_wifi)
    if [ $dual_wifi -eq 1 ];then
    	uci get wireless.radio1.macaddr
    else
	uci get wireless.radio0.macaddr
    fi
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