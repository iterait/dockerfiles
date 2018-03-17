# dockerfiles
[![Development Status](https://img.shields.io/badge/status-CX%20Experimental-brightgreen.svg?style=flat)]()
[![Master Developer](https://img.shields.io/badge/master-Petr%20Bělohlávek-lightgrey.svg?style=flat)]()

This is a repository contaning the open-source docker images provided by Cognexa Solutions s.r.o.

We use nvidia-docker instead of regular docker in order to enhance GPU support.
However, regular docker might be used as well.

## DockerHub
All built images are stored in [Cognexa DockerHub](https://hub.docker.com/r/cognexa/).

| CPU-only image                             | GPU enabled image                        | Description                                                                |
| ------------------------------------------ | ---------------------------------------- | -------------------------------------------------------------------------- |
| `cognexa/archlinux:latest`                 | `cognexa/archlinux:cuda`                 | Base ArchLinux setup with `trizen` and other frequently required packages. |
| `cognexa/cxflow:latest`                    | `cognexa/cxflow:cuda`                    | cxflow environment with standard plugins.                                  |
| `cognexa/cxflow-tensorflow:latest`         | `cognexa/cxflow-tensorflow:cuda`         | TensorFlow backend for cxflow.                                             |
| `cognexa/cxflow-cntk:latest`               | `cognexa/cxflow-cntk:cuda`               | CNTK backend for cxflow (experimental).                                    |
| `cognexa/cxflow-tensorflow-cxtream:latest` | `cognexa/cxflow-tensorflow-cxtream:cuda` | cxflow + cxflow-tensorflow + cxtream.                                      |

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
$ docker run -i -t <image-name> /bin/bash
```

To run the container with GPU support, we recommend using `nvidia-docker`.
The following example demonstrates the employment of two GPUs and executing `bash`.

```bash
$ nvidia-docker run -i -t \
    --device /dev/nvidia0:/dev/nvidia0 \
    --device /dev/nvidia1:/dev/nvidia1 \
    --device /dev/nvidiactl:/dev/nvidiactl \
    --device /dev/nvidia-uvm:/dev/nvidia-uvm \
    --entrypoint /bin/bash \
    <image-name>:cuda
```
