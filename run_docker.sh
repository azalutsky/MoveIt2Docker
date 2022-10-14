#!/bin/bash

xhost +local:
export WORK_DIR=/home/blah
docker run -it --rm \
    --network host \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix/:/tmp/.X11-unix \
    -w $WORK_DIR \
    moveit2-tutorial \
    /bin/bash -ci "source /root/.bashrc && /bin/bash"
