#!/bin/bash -ex

TODAY="$(date '+%Y-%m-%d')"
for imgname in archlinux archlinux-dev tensorflow; do
    sudo docker build -f Dockerfile.${imgname} --rm --no-cache -t "iterait/${imgname}:${TODAY}" -t "iterait/${imgname}:latest" --squash .
    sudo docker build -f Dockerfile.${imgname} --rm --no-cache --build-arg tag="cuda" -t "iterait/${imgname}:cuda_${TODAY}" -t "iterait/${imgname}:cuda" --squash .
    if [ "${CIRCLE_BRANCH}" == "master" ]; then
        sudo docker push iterait/${imgname}:latest
        sudo docker push iterait/${imgname}:"${TODAY}"
        sudo docker push iterait/${imgname}:cuda
        sudo docker push iterait/${imgname}:"cuda_${TODAY}"
    fi
done
