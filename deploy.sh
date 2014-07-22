#!/bin/bash

mkdir -p deploy
rm -rf deploy/*
mkdir -p deploy/untested/aa
mkdir -p deploy/untested/bb
mkdir -p deploy/packages/aa
mkdir -p deploy/packages/aa

echo '##'
echo '## Copy Attitude Adjustment'
echo '##'

for file in `ls openwrt-aa/bin/ar71xx/*.bin`
do
  f=${file##*/} #Strip basename
  f=${f/-squashfs-factory.bin/} #Remove annoying suffix
  f=${f/-squashfs-sysupgrade.bin/-upgrade} #Remove annoying suffix
  f=${f/openwrt-ar71xx-generic/ff-kbu} #Change prefix
  cp -a $file deploy/untested/aa/$f-${BUILD_ID}aa.bin
done
cp -a openwrt-aa/bin/ar71xx/packages deploy/packages/aa

## Pick tested AA firmware
cp deploy/untested/aa/{*741*,*1043*,*wr740n*} deploy/
cp deploy/untested/aa/{*wdr3600*,*wdr4300*,*842*,*841*} deploy/


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
  cp -a $file deploy/untested/bb/$f-${BUILD_ID}bb.bin
done
cp -a openwrt-bb/bin/ar71xx/packages deploy/packages/bb

## Pick tested AA firmware
cp deploy/untested/bb/{*841*v9*,*842*v2*,*wdr3500*} deploy/
