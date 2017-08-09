# dockerfiles
[![Development Status](https://img.shields.io/badge/status-CX%20Experimental-brightgreen.svg?style=flat)]()
[![Master Developer](https://img.shields.io/badge/master-Petr%20Bělohlávek-lightgrey.svg?style=flat)]()

This is a repository contaning the open-source docker images provided by Cognexa Solutions s.r.o.

We use nvidia-docker instead of regular docker in order to enhance GPU support.
However, regular docker might be used as well.

## DockerHub
All built images are stored in [Cognexa DockerHub](https://hub.docker.com/r/cognexa/).

## Build
All images might be build by regular docker build process.

```bash
$ nvidia-docker build -t <image-name> -f <dockerfile> .
```
## Run
Running the container is straightforward.
THe following example demonstrated the employment of two GPUs and executing `bash`.

```bash
$ nvidia-docker run -i -t \
    --device /dev/nvidia0:/dev/nvidia0 \
    --device /dev/nvidia1:/dev/nvidia1 \
    --device /dev/nvidiactl:/dev/nvidiactl \
    --device /dev/nvidia-uvm:/dev/nvidia-uvm \
    --entrypoint /bin/bash \
    <image-name>
```

## Images
The following images are provided.

- Cognexa/archlinux: base ArchLinux setup with GPU support, `pacaur` and other frequently required packages.
- Cognexa/cxflow: cxflow environment with standard plugins.
- Cognexa/cxflow-tensorflow: TensorFlow backend fro cxflow
- Cognexa/cxflow-cntk: CNTK backend fro cxflow (experimental)
