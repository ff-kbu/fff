#!/bin/sh
echo '***'
echo '*** Building Barrier Breaker in openwrt-bb'
echo '***'
cd openwrt-bb

rm -rf bin/ar71xx/* #remove old images

scripts/feeds update -a 
scripts/feeds install -a
cp ../configs/config-bb .config

# Version-Strings codieren
make clean
make CONFIG_VERSION_NUMBER="${BUILD_ID} (ff-kbu-master-bb-continuous)" -j 8

