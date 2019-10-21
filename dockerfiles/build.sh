#!/bin/bash -ex

TODAY="$(date '+%Y-%m-%d')"
for imgname in archlinux archlinux-dev tensorflow; do
    sudo docker build -f Dockerfile.${imgname} -t "iterait/${imgname}:${TODAY}" -t "iterait/${imgname}:latest" --squash .
    if [ "${CIRCLE_BRANCH}" == "master" ]; then
        sudo docker push iterait/${imgname}:latest
        sudo docker push iterait/${imgname}:"${TODAY}"
    fi
done
