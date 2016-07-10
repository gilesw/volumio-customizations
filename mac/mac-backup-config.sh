#!/usr/bin/env bash
# simple script to backup config from volumio

if [[ ! "$OSTYPE" == "darwin"* ]]; then
  echo "Please run this on mac osx!"
  exit
fi

echo quit | telnet volumio 22 2>/dev/null | grep Connected
if [ ! "$?" -eq 0 ];then
  echo "please run once volumio is up"
  exit
fi
echo "backup volumio config"
scp -r volumio:/etc/mpd.conf .
