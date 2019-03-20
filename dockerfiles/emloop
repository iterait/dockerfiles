ARG tag="latest"
FROM iterait/archlinux:"${tag}"
MAINTAINER Iterait a.s. <docker@iterait.com>

# install additional packages
RUN pacman --noconfirm --needed -Syu \
      python-babel \
      python-click \
      python-matplotlib \
      python-numpy \
      python-requests \
      python-ruamel-yaml \
      python-testfixtures \
      python-tabulate

# install emloop                                          
RUN pip install --no-cache-dir git+https://github.com/iterait/emloop.git
