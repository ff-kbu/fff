#!/bin/sh
echo '***'
echo '***  Building Attitude Adjustment in openwrt-aa '
echo '***' 
cd openwrt-aa

rm -rf bin/ar71xx/* #remove old images

scripts/feeds update -a 
scripts/feeds install -a
cp ../configs/config-aa .config

# Version-Strings codieren
make CONFIG_VERSION_NUMBER="${BUILD_ID} (ff-kbu-master-aa-continuous)" -j16

 