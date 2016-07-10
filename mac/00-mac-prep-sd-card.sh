#!/usr/bin/env bash
# copy stable raspberrypi version of volumio onto 8gb sd card using a mac retina sd card slot
# insert sd card before running

if [[ ! "$OSTYPE" == "darwin"* ]]; then
  echo "Please run this on mac osx!"
  exit
fi

if [[ ! -d /dev/disk3 ]];then
  echo "please insert sd card into macbook sdcard slot"
  exit
fi

cd
mkdir tmp
cd tmp
wget "http://downloads.sourceforge.net/project/volumio/Raspberry%20PI/1.5/Volumio1.55PI.img.zip"
sudo diskutil unmount /dev/disk3s1
sudo dd bs=1m if=Volumio1.55PI.img of=/dev/disk3
sudo diskutil eject /dev/rdisk3
