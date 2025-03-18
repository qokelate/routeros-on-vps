#!/bin/bash

# https://wiki.mikrotik.com/wiki/Manual:CHR_GCE

set -ex

# 安装unzip
which unzip || {
apt update
apt install -y unzip
}

# 下载镜像
[ -f chr-7.15.3-auto-setup.zip ] || \
curl -LORk 'https://github.com/qokelate/routeros-cloud-image/raw/master/chr-7.15.3-auto-setup.zip'

# 解压镜像
rm -fv chr-7.15.3.img
unzip chr-7.15.3-auto-setup.zip

# 转换镜像
truncate --size=1G chr-7.15.3.img
mv -fv chr-7.15.3.img disk.raw
tar -Sczf chr-7.15.3.tar.gz disk.raw

# 创建bucket
gsutil mb gs://ros-7-15-3
gsutil cp chr-7.15.3.tar.gz gs://ros-7-15-3

# 上传镜像
gcloud compute images create "ros-7-15-3" \
--family=ros-7-15-3 \
--source-uri "https://storage.googleapis.com/ros-7-15-3/chr-7.15.3.tar.gz"

# 创建实例
gcloud compute instances create "ros-v7-15-3" \
--zone=asia-east1-b \
--machine-type=e2-micro \
--image-family=ros-7-15-3

# 连接到控制台
# gcloud compute connect-to-serial-port ros-v7-15-3

# 删除镜像
# gcloud compute images delete ros-7-15-3
# gcloud storage rm --recursive gs://ros-7-15-3

exit
