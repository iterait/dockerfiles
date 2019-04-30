FROM scratch
LABEL thanksto "archimg/archlinux"
LABEL maintainer "Iterait a.s. <docker@iterait.com>"

# add image content
ADD arch-rootfs/ /

# add keyring 
RUN pacman-key --init && \
    pacman-key --populate archlinuxarm

# install base & remove useless stuff
RUN pacman --noconfirm -Syu --needed \
        base \
        sudo \
        vim \
    && pacman --noconfirm -Rs \
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

ENV EDITOR vim

# set UTF-8 locale
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8

# setup user `aur`
RUN useradd -m -s /bin/bash aur \
    && passwd -d aur \
    && echo 'aur ALL=(ALL) ALL' > /etc/sudoers.d/aur \
    && echo 'Defaults env_keep += "EDITOR"' >> /etc/sudoers.d/aur

# install `trizen`
RUN git clone https://aur.archlinux.org/trizen.git \
    && chown -R aur:aur /trizen \
    && cd /trizen \
    && sudo -u aur makepkg -si --needed --noconfirm \
    && cd / \
    && rm -rf /trizen

CMD ["/bin/bash"]
