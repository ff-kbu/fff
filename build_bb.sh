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
#make clean
if [ -z "$VERSION" ]; then
	VERSION=$BUILD_ID
fi

echo "${VERSION}" > files/etc/freifunk_version
make CONFIG_VERSION_NUMBER="${VERSION}" V=99 

