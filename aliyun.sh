#!/bin/bash

set -ex

apt update
apt install -y unzip

curl -LORk 'https://github.com/elseif/MikroTikPatch/releases/download/7.16.2/chr-7.16.2.img.zip'
unzip chr-7.16.2.img.zip

vdisk=`df --output=source /|tail -n 1|grep -oE '^[^0-9]+'`

dd if=chr-7.16.2.img of=$vdisk
dd if=chr-7.16.2.img of=$vdisk

sync

exit

