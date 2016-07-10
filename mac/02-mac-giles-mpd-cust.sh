#!/usr/bin/env bash
# prep ssh connection to volumio

if [[ ! "$OSTYPE" == "darwin"* ]]; then
  echo "Please run this on mac osx!"
  exit
fi

echo quit | telnet volumio 22 2>/dev/null | grep Connected
if [ ! "$?" -eq 0 ];then
  echo "please run once volumio is up"
  exit
fi
echo "transfer volumio install scripts"
scp -r mpd.conf volumio:/var/tmp
ssh volumio "sudo cp /var/tmp/mpd.conf /etc/mpd.conf"
