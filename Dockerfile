FROM osrf/ros:noetic-desktop-full

# YOU should replace your_os_user with your actual system user
ARG USER=suyanne
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# BASE DEPENDENCIES
RUN apt-get update && apt-get install -y \
    git \
    sudo \
    python3-pip \
    cmake \
    build-essential \
    pkg-config \
    make \
    zbar-tools \
    && rm -rf /var/lib/apt/lists/*

# ROS-NOETIC DEPENDENCIES
RUN apt-get update && apt-get install -y \
    ros-noetic-moveit \
    ros-noetic-ros-controllers \
    ros-noetic-gazebo-ros-control \
    ros-noetic-rosserial \
    ros-noetic-rosserial-arduino \
    ros-noetic-roboticsgroup-upatras-gazebo-plugins \
    ros-noetic-actionlib-tools

# OPENCV - DEPENDENCIES INSTALLATION
RUN apt-get update

FROM pachyderm/opencv

# Configurações finais
WORKDIR /home/${USER}

ENTRYPOINT ["/bin/bash"]
