ARG tag="latest"
FROM iterait/emloop:"${tag}"
MAINTAINER Iterait a.s. <docker@iterait.com>

ARG tag
RUN if [ "${tag}" = "cuda" ]; then \
        pacman --noconfirm --needed -Syu python-tensorflow-opt-cuda; \
    else \
        pacman --noconfirm --needed -Syu python-tensorflow-opt; \
    fi \
    && pacman --noconfirm --needed -Syu tensorboard python-tensorflow-estimator

# install emloop-tensorflow
RUN pip install --no-cache-dir git+https://github.com/iterait/emloop-tensorflow.git
