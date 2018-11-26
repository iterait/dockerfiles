#!/bin/bash -ex

[ $UID -ne 0 ] && echo "This script should get executed as root. Otherwise file special permissions are not set correctly." >&2

URL="http://os.archlinuxarm.org/os"
IMAGE_TAR="ArchLinuxARM-rpi-2-latest.tar.gz"

if [ ! -f ${IMAGE_TAR} ]; then
    wget "${URL}/${IMAGE_TAR}"
fi

mkdir -p arch-rootfs
tar -xzf ${IMAGE_TAR} --strip-components=1 --directory=./arch-rootfs

docker build -f Dockerfile -t "iterait/archlinuxarm:$(date '+%Y-%m-%d')" .
