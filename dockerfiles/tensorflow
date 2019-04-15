ARG tag="latest"
FROM iterait/archlinux:"${tag}"
MAINTAINER Iterait a.s. <docker@iterait.com>

ARG tag
RUN if [ "${tag}" = "cuda" ]; then \
        pacman --noconfirm --needed -Syu python-tensorflow-opt-cuda; \
    else \
        pacman --noconfirm --needed -Syu python-tensorflow-opt; \
    fi \
    && pacman --noconfirm --needed -Syu tensorboard python-tensorflow-estimator
