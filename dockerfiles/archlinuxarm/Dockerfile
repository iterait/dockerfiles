FROM scratch
LABEL thanksto "archimg/archlinux"
LABEL maintainer "Iterait a.s. <docker@iterait.com>"

# add image content
ADD arch-rootfs/ /

# add keyring 
RUN pacman-key --init && \
    pacman-key --populate archlinuxarm

# install base & remove useless stuff
RUN pacman --noconfirm -Syu --needed base && \
    pacman --noconfirm -Rs \
        dhcpcd \
        iproute2 \
        jfsutils \
        lvm2 \
        man-db \
        man-pages \
        mdadm \
        nano \
        netctl \
        openresolv \
        pciutils \
        reiserfsprogs \
        s-nail \
        systemd-sysvcompat \
        usbutils \
        vi \
        xfsprogs \
    && rm -rf \
        /usr/share/man/* \
        /var/cache/pacman/pkg/* \
        /var/lib/pacman/sync/* \
        /README \
        /etc/pacman.d/mirrorlist.pacnew

# set UTF-8 locale
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8

# install `trizen`
RUN git clone https://aur.archlinux.org/trizen.git \
    && chown -R aur:aur /trizen \
    && cd /trizen \
    && sudo -u aur makepkg -si --needed --noconfirm \
    && cd / \
    && rm -rf /trizen

CMD ["/bin/bash"]
