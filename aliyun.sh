#!/bin/bash

set -ex

apt update
apt install -y unzip

curl -LORk 'https://github.com/elseif/MikroTikPatch/releases/download/7.16.2/chr-7.16.2.img.zip'
unzip chr-7.16.2.img.zip

dd if=chr-7.16.2.img of=/dev/vda
dd if=chr-7.16.2.img of=/dev/vda

sync

exit

