#!/bin/bash -ex

[ $UID -ne 0 ] && echo "This script should get executed as root. Otherwise file special permissions are not set correctly." >&2
TODAY="$(date '+%Y-%m-%d')"
URL="http://os.archlinuxarm.org/os"

for imagename in archlinuxaarch64 archlinuxarm; do
    
    if [ "${imagename}" = "archlinuxarm" ]; then
        IMAGE_TAR="ArchLinuxARM-rpi-2-latest.tar.gz"
    elif [ "${imagename}" = "archlinuxaarch64" ]; then
        IMAGE_TAR="ArchLinuxARM-aarch64-latest.tar.gz"
    else
        echo "Not suppoorted arm image type."
        exit 1
    fi

    # Download and unpack the base system tarball from archlinuxarm.org.
    rm -rf "${IMAGE_TAR}" arch-rootfs
    wget "${URL}/${IMAGE_TAR}"
    mkdir -p arch-rootfs
    tar -xzf ${IMAGE_TAR} --strip-components=1 --directory=./arch-rootfs

    # Copy libalpm hooks to our future build context 
    cp ../*.hook ./

    # Build the base image.
    docker build -f Dockerfile.${imagename} --rm --no-cache -t "iterait/${imagename}:${TODAY}" -t "iterait/${imagename}:latest" --squash .
    # Build the -dev version without context.
    docker build - --build-arg BASE_IMAGE=${imagename} --rm --no-cache -t "iterait/${imagename}-dev:${TODAY}" -t "iterait/${imagename}-dev:latest" < Dockerfile.dev

    # Push the images to the repository.
    docker push iterait/${imagename}:latest
    docker push iterait/${imagename}:${TODAY}
    docker push iterait/${imagename}-dev:latest
    docker push iterait/${imagename}-dev:${TODAY}
done
