#!/bin/bash

mkdir -p deploy
rm -rf deploy/*
mkdir -p deploy/untested/attitude_adjustment
mkdir -p deploy/untested/barrier_breaker
mkdir -p deploy/packages/attitude_adjustment
mkdir -p deploy/packages/barrier_breaker

if [[ -z "$VERSION" ]]; then
  VERSION="${BUILD_ID}"
fi
echo '##'
echo '## Copy Attitude Adjustment'
echo '##'

for file in `ls openwrt-aa/bin/ar71xx/*.bin`
do
  f=${file##*/} #Strip basename
  f=${f/-squashfs-factory.bin/} #Remove annoying suffix
  f=${f/-squashfs-sysupgrade.bin/-upgrade} #Remove annoying suffix
  f=${f/openwrt-ar71xx-generic/ff-kbu} #Change prefix
  cp -a $file deploy/untested/attitude_adjustment/$f-${VERSION}-legacy.bin
done
cp -a openwrt-aa/bin/ar71xx/packages deploy/packages/attitude_adjustment

## Pick tested AA firmware
# This is legacy - do not to this
#cp deploy/untested/attitude_adjustment/{*741*,*1043*,*wr740n*} deploy/
#cp deploy/untested/attitude_adjustment/{*wdr3600*,*wdr4300*,*842*,*841*} deploy/


# Copy Barrier Breaker
echo '##'
echo '## Copy Barrier Breaker'
echo '##'

for file in `ls openwrt-bb/bin/ar71xx/*.bin`
do
  f=${file##*/} #Strip basename
  f=${f/-squashfs-factory.bin/} #Remove annoying suffix
  f=${f/-squashfs-sysupgrade.bin/-upgrade} #Remove annoying suffix
  f=${f/openwrt-ar71xx-generic/ff-kbu} #Change prefix
  cp -a $file deploy/untested/barrier_breaker/$f-${VERSION}.bin
done
cp -a openwrt-bb/bin/ar71xx/packages deploy/packages/barrier_breaker

## Pick tested AA firmware
#cp deploy/untested/barrier_breaker/{*741*,*1043*,*wr740n*} deploy/
#cp deploy/untested/barrier_breaker/{*wdr3600*,*wdr4300*,*842*,*841*} deploy/

cp deploy/untested/barrier_breaker/{*841*v9*,*842*v2*,*wdr3500*} deploy/
