node_mac(){
        local board="$(ar71xx_board_name)"
        local macaddr=""
        case "$board" in
        tl-wdr3600|\
        tl-wdr4300)
                macaddr="$(uci get wireless.radio1.macaddr)"
                ;;
        *)
                macaddr="$(uci get wireless.radio0.macaddr)"
                ;;
        esac
        echo $macaddr
}

# Convert mac-address to node_id
node_id(){
        local macaddr=$(node_mac)
        echo ${macaddr//:/}
}

