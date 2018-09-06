# dockerfiles
[![Development Status](https://img.shields.io/badge/status-CX%20Regular-brightgreen.svg?style=flat)]()
[![Master Developer](https://img.shields.io/badge/master-Petr%20Bělohlávek-lightgrey.svg?style=flat)]()

This is a repository contaning the open-source docker images provided by Iterait a.s.

We use nvidia-docker instead of regular docker in order to enhance GPU support.
However, regular docker might be used as well.

## DockerHub
All built images are stored in [Iterait DockerHub](https://hub.docker.com/r/iterait/).

| CPU-only image                             | GPU enabled image                        | Description                                                                |
| ------------------------------------------ | ---------------------------------------- | -------------------------------------------------------------------------- |
| `iterait/archlinux:latest`                 | `iterait/archlinux:cuda`                 | Base ArchLinux setup with `trizen` and other frequently required packages. |
| `iterait/cxflow:latest`                    | `iterait/cxflow:cuda`                    | cxflow environment with standard plugins.                                  |
| `iterait/cxflow-tensorflow:latest`         | `iterait/cxflow-tensorflow:cuda`         | TensorFlow backend for cxflow.                                             |
| `iterait/cxflow-cntk:latest`               | `iterait/cxflow-cntk:cuda`               | CNTK backend for cxflow (experimental).                                    |
| `iterait/cxflow-tensorflow-cxtream:latest` | `iterait/cxflow-tensorflow-cxtream:cuda` | cxflow + cxflow-tensorflow + cxtream.                                      |

## Build
All images may be built by regular docker build process.

```bash
$ docker build -t <image-name> -f <dockerfile> .
```

If you require NVIDIA CUDA support, build the image with `tag=cuda` build argument.
```bash
$ docker build --build-arg tag=cuda -t <image-name>:cuda -f <dockerfile> .
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
