# Created by Anton Zalutsky
# Email: azalutsky@gmail.com
# https://github.com/azalutsky/MoveIt2Docker

FROM ros:foxy

ENV HOME=/home/blah
ENV ROS2_WORKSPACE=workspace
ARG ROS_DISTRO=galactic

## Basic Packages install
## For any other packages needed- please add to this apt-get installation!
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    curl \
    gnupg \
    lsb-release \
    git \
    apt-utils \
    python3-dev \
    python3-distutils \
    python3-pip \
    unzip \
    sudo \
    wget \
    software-properties-common \
    iputils-ping \
    vim \
    figlet \
    toilet

RUN apt-get update  && \
    apt-get upgrade -y && \
    apt-get install -y \
    vim \
    iputils-ping \
    ros-${ROS_DISTRO}-gazebo-ros-pkgs \
    ros-${ROS_DISTRO}-xacro \
    python3-rosdep \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-vcstool

#Update ROS2
RUN apt update && \
    rosdep init && \
    rosdep update --rosdistro=$ROS_DISTRO && \
    apt dist-upgrade

RUN mkdir -p $HOME/$ROS2_WORKSPACE

# Moveit2
RUN mkdir -p $HOME/$ROS2_WORKSPACE/moveit2 && \
    git clone \
    -b $ROS_DISTRO \
    https://github.com/ros-planning/moveit2.git \
    $HOME/$ROS2_WORKSPACE/moveit2

# Simulation - Joint State Publisher
RUN mkdir -p $HOME/$ROS2_WORKSPACE/joint_state_publisher && \
    git clone \
    -b $ROS_DISTRO \
    https://github.com/ros/joint_state_publisher \
    $HOME/$ROS2_WORKSPACE/joint_state_publisher

RUN mkdir -p $HOME/$ROS2_WORKSPACE/ros2_control && \
    git clone \
    -b $ROS_DISTRO \
    https://github.com/ros-controls/ros2_control.git \
    $HOME/$ROS2_WORKSPACE/ros2_control

RUN cd $HOME/$ROS2_WORKSPACE && \
    mkdir -p $HOME/$ROS2_WORKSPACE/moveit2_tutorials && \
    git clone https://github.com/ros-planning/moveit2_tutorials.git -b foxy --depth 1 $HOME/$ROS2_WORKSPACE/moveit2_tutorials
RUN cd $HOME/$ROS2_WORKSPACE && \
    vcs import < $HOME/$ROS2_WORKSPACE/moveit2_tutorials/moveit2_tutorials.repos && \
    rosdep update && \
    rosdep install -r \
    --ignore-src \
    --rosdistro $ROS_DISTRO \
    --from-paths . -y

# Build by source, override any packages in /opt/ros/, (moveit specifically as motoros requires a different version of control_msgs)
RUN cd $HOME/$ROS2_WORKSPACE && \
    . /opt/ros/$ROS_DISTRO/setup.sh && \
    colcon build

RUN echo "source $HOME/$ROS2_WORKSPACE/install/setup.bash" >> /root/.bashrc
RUN echo "figlet -c -f slant MOVEIT2 TUTORIAL" >> /root/.bashrc
RUN echo "echo 'ROS2 sourced, sail away'" >> /root/.bashrc

CMD [ "/bin/bash","-c" ]
