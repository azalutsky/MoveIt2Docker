#!/bin/bash

# Please set $DENALI_WS_DIR to your local ebots_ros2_arms workspace
# Example: DENALI_WS_DIR=/home/USER/ws/ebots/ebots_ros2_arms

xhost +local:
export WORK_DIR=/home/ebots
docker run -it --rm \
    --network host \
    --privileged \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix/:/tmp/.X11-unix \
    -v $DENALI_WS_DIR/workspace/motoman_motomini_support:$WORK_DIR/workspace/motoman_motomini_support \
    -w $WORK_DIR \
    moveit2-tutorial \
    /bin/bash -ci "source /root/.bashrc && /bin/bash"
