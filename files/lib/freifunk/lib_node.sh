get_main_address() {
    case "$board" in
        tl-wdr3600|tl-wdr4300)
            uci get wireless.radio1.macaddr
            ;;
        *)
            uci get wireless.radio0.macaddr
            ;;
    esac
}

get_node_id(){
	macaddr=$(get_main_address)
        echo ${macaddr//:/}
}

