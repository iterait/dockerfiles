# dockerfiles
[![Development Status](https://img.shields.io/badge/status-Regular-brightgreen.svg?style=flat)]()
[![Master Developer](https://img.shields.io/badge/master-Petr%20Bělohlávek-lightgrey.svg?style=flat)]()

This is a repository contaning the open-source docker images provided by Iterait a.s.

We use nvidia-docker instead of regular docker in order to enhance GPU support.
However, regular docker might be used as well.

## DockerHub
All built images are stored in [Iterait DockerHub](https://hub.docker.com/r/iterait/).

| CPU-only image                  | GPU enabled image               | Description                         |
| ------------------------------- | ------------------------------- | ----------------------------------- |
| `iterait/archlinux:latest`      | `iterait/archlinux:cuda`        | Base ArchLinux setup with `yay`.    |
| `iterait/archlinux-dev:latest`  | `iterait/archlinux-dev:cuda`    | `iterait/archlinux` + `base-devel`. |
| `iterait/tensorflow:latest`     | `iterait/tensorflow:cuda`       | `iterait/archlinux` + `tensorflow`. |

## Build
Build all the images by running:
```
./build.sh
```

## Run
Running the container without GPU support is straightforward.
```bash
$ docker run -it <image-name> /bin/bash
```

To run the container with GPU support, we recommend using `nvidia-docker`.
The following example demonstrates the employment of two GPUs and executing `bash`.

```bash
$ docker run --runtime=nvidia \
    -e NVIDIA_VISIBLE_DEVICES=0,1 \
    -it <image-name>:cuda /bin/bash
```
