#!/usr/bin/lua
local ut=require("luci.util")

-- Helper function for parsing current config
function parse_vlan_index(key)
  -- Index = last_digit
  local index
  for word in string.gfind(key, "%d+") do
    index = word
  end
  return(index)
end

-- Helper function: Create a port-set for a vlan, specified by vid, using the given lookup tables
function create_port_set(vid, vid_table,port_table)
  port_set = {}
  index = vid_table[vid]
  ports = port_table[index]
  for port in string.gfind(ports, "%w+") do
    port_set[port] = 1
  end
  return(port_set)  
end



-- Iterate, gather data on lan, wan ifnames
local wan_if
local lan_if
local vlan_index_by_vid = {}
local vlan_ports_by_index = {}

-- Dump network configuration
local config = ut.split(ut.exec("uci show network"),"\n")

-- Parse current network configuration
for num, line in ipairs(config) do

  if string.find(line, "network%.wan%.ifname") then --lan-interface
    
    wan_if = ut.split(line,'=')[2]  
  elseif string.find(line,"network%.lan%.ifname") then --wan interface
    lan_if = ut.split(line,'=')[2]

  elseif string.find(line,"network%.@switch_vlan%[.%]") then -- Ports or vid
    local key = ut.split(line,'=')[1] -- Split line
    local value = ut.split(line,'=')[2]
    local index = parse_vlan_index(key) -- Common part: Extract key, value, index
    
    if string.find(line, "ports=") then
      vlan_ports_by_index[index] = value
    elseif string.find(line, "vlan=") then
      vlan_index_by_vid[value] = index
    end
  end
end
  
  -- Rules for setting up network
  if wan_if and lan_if then --Only, if both exist, if not: No configuration is needed
    local wan_base = ut.split(wan_if,".")[1]
    local lan_base = ut.split(lan_if,".")[1]
    if wan_base == lan_base then -- Different vlans - change ports
      local wan_vid = ut.split(wan_if,".")[2]
      local lan_vid = ut.split(lan_if,".")[2]
      local wan_index = vlan_index_by_vid[wan_vid]
      local lan_index = vlan_index_by_vid[lan_vid]
      -- Merge ports - strategy: Create sets of wan / lan ports. Move ports from wan to lan if they don't exist yet
      wan_port_set = create_port_set(wan_vid,vlan_index_by_vid,vlan_ports_by_index)
      old_lan_port_set = create_port_set(lan_vid,vlan_index_by_vid,vlan_ports_by_index)
      new_lan_port_set = {}
      for i,v in pairs(old_lan_port_set) do
        if wan_port_set[i] == nil then
          wan_port_set[i] = 1
        else 
          new_lan_port_set[i] = 1
        end
      end
      local wan_port_str = table.concat(ut.keys(wan_port_set), " ")
      local lan_port_str = table.concat(ut.keys(new_lan_port_set), " ")
      ut.exec("uci set network.@switch_vlan["..wan_index.."].ports="..wan_port_str)
      ut.exec("uci set network.@switch_vlan["..lan_index.."].ports="..lan_port_str)
    else -- Different interfaces, create bridge
      ut.exec("uci set network.wan.ifname='"..wan_if.." "..lan_if.."'")
      ut.exec("uci set network.lan.ifname=''")
    end
    ut.exec("uci commit network")
  end
  
