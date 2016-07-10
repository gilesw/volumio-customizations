#!/usr/bin/env bash
# install squeezlite client onto volumio on raspberrrypi

sudo su
cd

# grab the squeezelite source
wget http://squeezelite.googlecode.com/files/squeezelite-armv6hf
wget http://www.gerrelt.nl/RaspberryPi/squeezelitehf.sh
wget http://www.gerrelt.nl/RaspberryPi/squeezelite_settings.sh

mv squeezelite-armv6hf /usr/bin
chmod u+x /usr/bin/squeezelite-armv6hf

# setup initscript and to start on boot
mv squeezelitehf.sh /etc/init.d/squeezelite
chmod u+x /etc/init.d/squeezelite
update-rc.d squeezelite defaults


mv squeezelite_settings.sh /usr/local/bin
chmod a+x /usr/local/bin/squeezelite_settings.sh

perl -pi -e 's/^SL_SOUNDCARD/#SL_SOUNDCARD/g'  /usr/local/bin/squeezelite_settings.sh
echo "SL_ALSA_PARAMS="200"" >> /usr/local/bin/squeezelite_settings.sh

/etc/init.d/squeezelite start


