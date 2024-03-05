FROM osrf/ros:noetic-desktop-full
ARG USER=your_os_user
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y sudo ros-noetic-moveit ros-noetic-ros-controllers ros-noetic-gazebo-ros-control ros-noetic-rosserial ros-noetic-rosserial-arduino ros-noetic-roboticsgroup-upatras-gazebo-plugins ros-noetic-actionlib-tools terminator python3-pip && rm -rf /var/lib/apt/lists/*
RUN pip install flask flask-ask-sdk ask-sdk empy
WORKDIR /home/${USER}