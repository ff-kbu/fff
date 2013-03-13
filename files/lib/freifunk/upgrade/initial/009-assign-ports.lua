#!/usr/bin/lua

local ut=require("luci.util")
ut.exec("uci show network > /etc/network.dump")
ut.exec("swconfig dev swconfig dev rtl8366rb show > /etc/switch.dump")

-- Remove duplicates from table, return new table
function uniq(tbl)
    local res_table = {}
    for k,v in ipairs(tbl) do
      if not ut.contains(res_table,v) then
        table.insert(res_table,v)
      end
    end
  return(res_table)
end

-- Join Table by given string
function join(tbl,str)
  local port_str = ""
  for k,v in ipairs(tbl) do
    port_str = port_str..str..v
  end
  return(port_str)
end

-- Reads Switch-Device name (needed for swconfig)
function switch_device()
  local dev = ut.exec("uci get network.@switch[0].name")
  return(ut.trim(dev))
end



-- Get ports of known vlan by swconfig
function get_ports(if_name)
  local vlanId = ut.split(if_name, ".")[2]
  local switch_device = switch_device()
  -- eg. swconfig dev eth0 vlan 1 show
  local cmd_str = "swconfig dev "..switch_device.. " vlan "..vlanId.. " get ports"
  local result = ut.trim(ut.exec(cmd_str))
  local parsed_result = ut.split(result, " ")
  return(parsed_result)
end


-- Actual code 
-- Query interface names
local wan_if_name = ut.trim(ut.exec("uci get network.wan.ifname"))  
local lan_if_name = ut.trim(ut.exec("uci get network.lan.ifname")) 

local wan_basename = ut.split(wan_if_name,".")[1]
local lan_basename = ut.split(lan_if_name,".")[1]

-- Two cases
if wan_basename ~= lan_basename then
  -- Simple one: Interfaces differ, ignore switch-paritioning, set up a common bridge
  ut.exec("uci set network.wan.ifname="..wan_if_name.." "..lan_if_name)
  ut.exec("uci set network.lan.ifname=''")
  
else 
  -- Not so simple one - change switch partioning
  
  local wan_ports = get_ports(wan_if_name)
  local lan_ports = get_ports(lan_if_name)
  local ports = uniq(ut.combine(lan_ports, wan_ports))
  local port_str = join(ports," ")
  
  -- Get network setup, find matching vlan-definitions, set vlan done
  local network_config = ut.split(ut.exec("uci show network"),"\n")
  
  local wan_id = ut.split(wan_if_name,".")[2]
  local lan_id = ut.split(lan_if_name,".")[2]
  
  for num, line in ipairs(network_config) do
    if string.find(line,"network%.@switch_vlan%[.%]%.vlan") then
      local vid = ut.split(line,"=")[2]
      if vid == ""..wan_id then
        local cmd = string.gsub(line,"vlan="..vid,"ports=\""..port_str.."\"")
        ut.exec("uci set "..cmd)
      elseif vid == ""..lan_id then
        local cmd = string.gsub(line,"vlan="..vid,"ports=\"\"")
        ut.exec("uci set "..cmd)
      
      end
    end
  end
  ut.exec("uci commit network")
end

