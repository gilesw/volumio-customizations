#!/usr/bin/env bash
# resize the volumio partition table to use all the sd card


(echo d; echo 3; echo n; echo 3; echo ; echo; echo w; echo quit) | sudo fdisk /dev/mmcblk0
reboot


