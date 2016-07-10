#!/usr/bin/env bash

# setup specific to me..
sudo su

echo "//diskstation.local/flac /mnt/NAS cifs ro,relatime,vers=2.0,cache=strict,username=volumio,domain=DISKSTATION,uid=0,noforceuid,gid=0,noforcegid,addr=192.168.142.131,unix,posixpaths,serverino,acl,rsize=8048,wsize=8096,actimeo=1 0 0" >> /etc/mtab
