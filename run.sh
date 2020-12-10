#!/bin/sh

docker run --rm --privileged -p 6080:80 -p 5900:5900 -e RESOLUTION=1800x900 -v ${HOME}/:/media/host --device=/dev/sr0 lightscribe
