#!/bin/bash -ex

TODAY="$(date '+%Y-%m-%d')"
for tag in archlinux archlinux-dev tensorflow; do
    sudo docker build -f Dockerfile.${tag} -t "iterait/${tag}:${TODAY}" -t "iterait/${tag}:latest" --squash .
    if [ "${CIRCLE_BRANCH}" == "master" ]; then
        sudo docker push iterait/${tag}:latest
        sudo docker push iterait/${tag}:"${TODAY}"
    fi
done
