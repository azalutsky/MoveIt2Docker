# Created by Ebots, Anton Zalutsky (azalutsky@ebots.com)
# This should install the following:
# Ubuntu 20.04
# Nvidia drivers
# ROS2 (Foxy)
# ROS2 - MicroRos (Foxy)
# ROS2 - Industrial_msgs (Foxy)
# ROS2 - Control_msgs (Galactic)

FROM nvidia/cuda:11.6.2-cudnn8-runtime-ubuntu20.04

# UTF-8 included in nvidia's image but not activated. Needed for a lot of things.
ENV LANG="C.UTF-8" LC_ALL="C.UTF-8"
ENV HOME=/home/ebots
ENV ROS2_WORKSPACE=workspace
ARG ROS_DISTRO=foxy

# Copy current workspace (motoros, motoman_motomini_support, ...) into Docker
RUN mkdir -p $HOME/$ROS2_WORKSPACE

# Apparently needed in order to successfully add a repository
RUN echo 'Etc/UTC' > /etc/timezone && \
	  ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime
# Basic Packages install
# For any other packages needed- please add to this apt-get installation!
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

# Install ROS2 Below
RUN add-apt-repository universe
# Curl key & authorize ros DIR/$ROS2_WORKSPACE/micro_ros_setup
# Dev notes suggest werepository
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
  	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && \
    echo $UBUNTU_CODENAME) main" > /etc/apt/sources.list.d/ros2.list

# Opted for ROS2 Foxy as we are stuck on Ubuntu 20.04 till Nvidia updates their images
# It has the latest EOL & better ecosystem support as Humble is still too new

ENV ROS_DISTRO=$ROS_DISTRO
RUN apt-get update  && \
    apt-get upgrade -y && \
	  apt-get install -y \
    vim \
    iputils-ping \
	  ros-${ROS_DISTRO}-desktop \
	  ros-${ROS_DISTRO}-gazebo-ros-pkgs \
    ros-foxy-xacro \
	  python3-rosdep \
	  python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-vcstool && \
	  rm -rf /var/lib/apt/lists/* && \
	  rm -rf log/

RUN colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update default
# Set default version of python to be the one ROS2 Foxy uses
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 10
# Update ROS2
RUN apt update && \
    rosdep init && \
  	rosdep update --rosdistro=$ROS_DISTRO && \
    apt dist-upgrade
# Ensure rqt icons show up
RUN mkdir -p $HOME/.icons && ln -s /usr/share/icons/Tango $HOME/.icons/hicolor
# Auto-activate ROS whenever shell is opened
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> $HOME/.bashrc
# ROS2 Qt comes with good debugging tools, is also framework for adding your own visualizations or control panel.
RUN apt-get install -y ~nros-${ROS_DISTRO}-rqt*

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

RUN  mkdir -p $HOME/$ROS2_WORKSPACE/moveit2_tutorials && \
    git clone https://github.com/ros-planning/moveit2_tutorials.git -b foxy --depth 1 $HOME/$ROS2_WORKSPACE/moveit2_tutorials && \
    vcs import < $HOME/$ROS2_WORKSPACE/moveit2_tutorials/moveit2_tutorials.repos

# Install dependencies of all packages
RUN cd $HOME/$ROS2_WORKSPACE && \
    rosdep install -r \
    --rosdistro $ROS_DISTRO \
    --from-paths . -y

# Build by source, override any packages in /opt/ros/, (moveit specifically as motoros requires a different version of control_msgs)
RUN cd $HOME/$ROS2_WORKSPACE && \
    . /opt/ros/$ROS_DISTRO/setup.sh && \
    colcon build --mixin release

RUN echo "source $HOME/$ROS2_WORKSPACE/install/setup.bash" >> /root/.bashrc
RUN echo "figlet -c -f slant MOVEIT2 TUTORIAL" >> /root/.bashrc
RUN echo "echo 'ROS2 sourced, sail away'" >> /root/.bashrc

CMD [ "/bin/bash","-c" ]