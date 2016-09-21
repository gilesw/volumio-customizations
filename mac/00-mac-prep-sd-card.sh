#!/usr/bin/env bash
# copy stable raspberrypi version of volumio onto 8gb sd card using a mac retina sd card slot

confirm () {
    read -r -p "${1:-Are you sure? [Y/n]} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            exit
            ;;
    esac
}


if [[ ! "$OSTYPE" == "darwin"* ]]; then
  echo "Please run this on mac osx!"
  exit
fi

fatal(){
    echo "$@"
    exit 1
}

model=$(sysctl hw.model | awk '{print $2}' | perl -ne '/(.*)\,/ && print $1' )
echo "$model detected"

case $model in
    MacBookPro9)
        disk_to_use="/dev/disk3"
    ;;
    *)
        fatal "Fatal: $model not supported"
        exit
    ;;
esac

echo "detecting whether we have correctly identified the sdcard slot"

echo $(diskutil list) | grep -q "$disk_to_use" && fatal "either disk $disk_to_use is a local disk or you already inserted the sd card and need to eject"

confirm "Please insert your sd card and type y"


if [[ ! -d "$disk_to_use" ]];then
  echo "please insert sd card into macbook sdcard slot"
  exit
fi

cd
mkdir tmp
cd tmp
wget "http://downloads.sourceforge.net/project/volumio/Raspberry%20PI/1.5/Volumio1.55PI.img.zip"
sudo diskutil unmount ${disk_to_use}s1
sudo dd bs=1m if=Volumio1.55PI.img of=${disk_to_use}
sudo diskutil eject ${disk_to_use}
