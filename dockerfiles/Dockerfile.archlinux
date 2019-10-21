FROM scratch
MAINTAINER Iterait a.s. <docker@iterait.com>

COPY --from=archlinux/base / /
# add cleanup hook
ADD 99-cleanup.hook /usr/share/libalpm/hooks/

# install common packages
RUN pacman --noconfirm --needed -Syu \
        binutils \
        fakeroot \
        git \
        sudo

ENV EDITOR vim

# set UTF-8 locale
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && locale-gen
RUN echo 'LANG=en_US.UTF-8' > /etc/locale.conf
ENV LANG en_US.UTF-8

# setup user `aur`
RUN useradd -m -s /bin/bash aur \
    && passwd -d aur \
    && echo 'aur ALL=(ALL) ALL' > /etc/sudoers.d/aur \
    && echo 'Defaults env_keep += "EDITOR"' >> /etc/sudoers.d/aur

# install `yay`
RUN git clone https://aur.archlinux.org/yay-bin.git \
    && chown -R aur:aur /yay-bin \
    && cd /yay-bin \
    && sudo -u aur makepkg -si --needed --noconfirm \
    && cd / \
    && rm -rf /yay-bin

# configure `yay` to remove build cache and make dependencies
RUN sudo -u aur yay --cleanafter --removemake --save

# install GPU related stuff if build argument `tag` is set to `cuda`
# After the installation of cuda, we remove its libraries to avoid conflict
# with cuda provided by nvidia-docker.
ARG tag="latest"
RUN if [ "${tag}" = "cuda" ]; then \
        pacman --noconfirm --needed -Syu \
          cuda \
          cudnn \
          nccl \
        && rm -vf /usr/bin/nvidia* \
        && rm -vf /usr/lib/libnvidia* \
        && rm -vf /usr/lib/libcuda*; \
    fi

# set NVIDIA-Docker specific variables
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.0"
