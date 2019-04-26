FROM ubuntu
MAINTAINER Iterait a.s. <docker@iterait.com>

# Expose the API port
EXPOSE 5000
WORKDIR /app

# Install OpenCV
RUN apt-get update \
 && apt-get install -y --no-install-recommends python3-opencv python3-pip \
 && rm -rf /var/lib/apt/lists/*

# Install python requirements
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Copy and run the app
COPY video_feed.py video_feed.py
CMD python3 video_feed.py
