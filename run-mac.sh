#!/bin/bash

# Assumes running on MacOS.
# Must have XQuartz installed and configured to allow network connections

if ! ps -ef | grep -E '[X]Quartz.app' ; then
  defaults write org.macosforge.xquartz.X11 app_to_run true
  open -a xquartz
fi

XDISPLAY=$(ps -e | grep 'bin/Xquartz' | awk '$6=="-listen" { print $5 }' | tr -d ':')
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $IP
docker run --rm -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$IP:$XDISPLAY rajsahae/fxruby:latest