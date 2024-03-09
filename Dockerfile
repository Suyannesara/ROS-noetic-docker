# This is an auto generated Dockerfile for ros:ros-base
# generated from docker_images/create_ros_image.Dockerfile.em
FROM ros:noetic-ros-core-focal

ARG USER=suyanne
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# Source ros1 itens
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /opt/ros/noetic/setup.sh" >> ~/.bashrc
RUN source ~/.bashrc

# install bootstrap tools
RUN apt-get update 
RUN apt-get install --no-install-recommends -y \
    build-essential \
    python3-rosdep \
    python3-rosinstall \
    python3-vcstools \
    && rm -rf /var/lib/apt/lists/* \
    sudo ros-noetic-moveit \
    ros-noetic-ros-controllers \
    ros-noetic-turtlesim 

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro noetic

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-ros-base=1.5.0-1* \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/${USER}

ENTRYPOINT ["/bin/bash"]