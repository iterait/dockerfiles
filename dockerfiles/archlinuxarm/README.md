ArchLinux ARM Docker Image
==========================

Based on [archimg/archlinux](https://github.com/archimg/archlinux).

Prerequisites (Arch Linux)
===
```
sudo pacman -S qemu-headless qemu-headless-arch-extra docker
```

Build
=====

Build the image from scratch:
```
sudo -H ./build.sh
```

Note: The created image is automatically tagged according to today date (e.g. `iterait/archlinuxarm:2018-11-26`).

Run the image:
```
docker run --rm -it "iterait/archlinuxarm:$(date '+%Y-%m-%d')" .
```
