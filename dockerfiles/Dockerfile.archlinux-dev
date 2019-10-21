FROM iterait/archlinux
MAINTAINER Iterait a.s. <docker@iterait.com>

# install common packages
RUN pacman --noconfirm --needed -Syu \
      base-devel \
      cmake \
      vim \
    && find /usr/lib/guile -name "*.go" | xargs rm

ENV EDITOR vim

CMD ["/bin/bash"]
