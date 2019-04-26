import os

import cv2
from flask import Flask, Response


class VideoCamera:
    def __init__(self):
        self._device = os.environ.get('DEVICE', None)
        if self._device is None:
            raise ValueError(f'Required env. variable `DEVICE` not set.')
        self._video = cv2.VideoCapture(self._device)

    def __del__(self):
        self._video.release()
    
    def get_frame(self):
        success, image = self._video.read()
        assert success, 'Cannot capture image'
        ret, jpeg = cv2.imencode('.jpg', image)
        return jpeg.tobytes()


app = Flask(__name__)


def gen(camera):
    while True:
        frame = camera.get_frame()
        yield (b'--frame\r\nContent-Type: image/jpeg\r\n\r\n' + frame + b'\r\n\r\n')


@app.route('/')
def video_feed():
    return Response(gen(VideoCamera()), mimetype='multipart/x-mixed-replace; boundary=frame')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
