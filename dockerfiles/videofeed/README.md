# Video Feed
Docker image providing video feed from device on port 5000

## Build Image
```docker build -t videofeed .```

## Run container
Run video feed on port 1234 providing data from camera /dev/video0. Make sure to specify env variable DEVICE to match camera.

```docker run --rm -d --device=/dev/video0 -e DEVICE=/dev/video0 -p 1234:5000 videofeed```
