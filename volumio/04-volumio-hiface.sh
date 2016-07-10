#!/usr/bin/env bash
# script to compile the m2tech usb driver for volumio on raspbery pi. Run on the volumio server

# m2tech install
sudo wget https://raw.githubusercontent.com/notro/rpi-source/master/rpi-source -O /usr/bin/rpi-source

# Make it executable
sudo chmod +x /usr/bin/rpi-source

# Tell the update mechanism that this is the latest version of the script
sudo /usr/bin/rpi-source -q --tag-update

# prep our build environment
sudo apt-get -y install build-essential
sudo apt-get -y install gcc-4.8 g++-4.8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 100

# grab a makefile from the original project
sudo su
git clone git://github.com/panicking/snd-usb-asyncaudio.git
cd /lib/modules/`uname -r`/source/sound/usb/hiface
cp /root/snd-usb-asyncaudio/Makefile .

# compiling the kernel module
make

# copy it into the running kernels module tree
mkdir  /lib/modules/`uname -r`/kernel/sound/usb/hiface
cp snd-usb-hiface.ko /lib/modules/`uname -r`/kernel/sound/usb/hiface
# re-read the module tree
depmod -a

# load on bootup
echo "snd-usb-hiface" >> /etc/modules
# make this card the default alsa device
echo "options snd-usb-hiface index=0" >> /etc/modprobe.d/alsa-base.conf

reboot


