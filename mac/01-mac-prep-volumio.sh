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
echo "setup your ssh config to make connecting to volumio: ssh volumio"
cp ~/.ssh/config ~/.ssh/config.bak
echo -e "Host volumio*\nUser volumio" > /tmp/$$.ssh.config
cat ~/.ssh/config.bak >> /tmp/$$.ssh.config
cp /tmp/$$.ssh.config ~/.ssh/config

echo "correct permissions of homedir on volumio"
ssh volumio sudo chown volumio.volumio /home/volumio

echo "transfer authorized keys over to allow key based ssh auth"
scp -r ~/.ssh volumio:~/
echo "transfer volumio install scripts"
scp -r ../volumio/*.sh volumio:~/
