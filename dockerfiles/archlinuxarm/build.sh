#!/bin/bash -ex

[ $UID -ne 0 ] && echo "This script should get executed as root. Otherwise file special permissions are not set correctly." >&2

URL="http://os.archlinuxarm.org/os"
IMAGE_TAR="ArchLinuxARM-rpi-2-latest.tar.gz"
TODAY="$(date '+%Y-%m-%d')"

# Download and unpack the base system tarball from archlinuxarm.org.
rm -rf "${IMAGE_TAR}" arch-rootfs
wget "${URL}/${IMAGE_TAR}"
mkdir -p arch-rootfs
tar -xzf ${IMAGE_TAR} --strip-components=1 --directory=./arch-rootfs

# Copy libalpm hooks to our future build context 
cp ../*.hook ./

# Build the base image.
docker build -f Dockerfile.archlinuxarm --rm --no-cache -t "iterait/archlinuxarm:${TODAY}" -t "iterait/archlinuxarm:latest" --squash .
# Build the -dev version without context.
docker build - --rm --no-cache -t "iterait/archlinuxarm-dev:${TODAY}" -t "iterait/archlinuxarm-dev:latest" < Dockerfile.archlinuxarm-dev

# Push the images to the repository.
docker push iterait/archlinuxarm:latest
docker push iterait/archlinuxarm:${TODAY}
docker push iterait/archlinuxarm-dev:latest
docker push iterait/archlinuxarm-dev:${TODAY}
