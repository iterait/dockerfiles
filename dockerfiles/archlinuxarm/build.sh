#!/bin/bash -ex

[ $UID -ne 0 ] && echo "This script should get executed as root. Otherwise file special permissions are not set correctly." >&2

URL="http://os.archlinuxarm.org/os"
IMAGE_TAR="ArchLinuxARM-rpi-2-latest.tar.gz"

rm -rf "${IMAGE_TAR}" arch-rootfs
wget "${URL}/${IMAGE_TAR}"
mkdir -p arch-rootfs
tar -xzf ${IMAGE_TAR} --strip-components=1 --directory=./arch-rootfs

today="$(date '+%Y-%m-%d')"
docker build -f archlinuxarm -t "iterait/archlinuxarm:${today}" -t "iterait/archlinuxarm:latest" --squash .
docker build -f archlinuxarm-dev -t "iterait/archlinuxarm-dev:${today}" -t "iterait/archlinuxarm-dev:latest" .
docker push archlinuxiterait/archlinuxarm:latest
docker push archlinuxiterait/archlinuxarm:${today}
docker push archlinuxiterait/archlinuxarm-dev:latest
docker push archlinuxiterait/archlinuxarm-dev:${today}
