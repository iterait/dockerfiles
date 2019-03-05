ARG tag="latest"
FROM iterait/emloop-tensorflow:"${tag}"
MAINTAINER Iterait a.s. <docker@iterait.com>

# install extra packages
RUN pacman --noconfirm --needed -Syu \
      base-devel \
      boost \
      cmake \
      clang \
      git \
      openmp \
      openssh \
      yaml-cpp

# install hipipe
RUN git clone --recursive https://github.com/iterait/hipipe.git \
  && mkdir -p hipipe/build && cd hipipe/build \
  && cmake -DHIPIPE_BUILD_TEST=OFF .. \
  && make -j4 && make install && ldconfig \
  && cd ../../ && rm -r hipipe
