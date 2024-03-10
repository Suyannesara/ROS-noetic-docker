FROM osrf/ros:noetic-desktop-full

# YOU should replace your_os_user with your actual system user
ARG USER=suyanne
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt-get update

# BASE DEPENDENCIES
RUN apt-get install -y \
    git \
    sudo \
    python3-pip \
    cmake \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# ROS-NOETIC DEPENDENCIES
RUN apt-get install -y \
    ros-noetic-moveit \
    ros-noetic-ros-controllers \
    ros-noetic-gazebo-ros-control \
    ros-noetic-rosserial \
    ros-noetic-rosserial-arduino \
    ros-noetic-roboticsgroup-upatras-gazebo-plugins \
    ros-noetic-actionlib-tools

OPENCV - DEPENDENCIES INSTALLATION
RUN apt-get install -y \
    unzip \
    ffmpeg \
    pkg-config \
    libv4l-dev \
    libx264-dev \
    gfortran \
    libxvidcore-dev \
    libatlas-base-dev \
    libgtk-3-dev \
    libavformat-dev \
    libswscale-dev \
    libjpeg-dev \ 
    libpng-dev \ 
    libtiff-dev \ 
    libavcodec-dev \

# OPENCV C++ INSTALLATION
WORKDIR ~

RUN cd ~ \
  && git clone https://github.com/opencv/opencv.git \
  && git clone https://github.com/opencv/opencv_contrib.git \
  && cd opencv \
  && git checkout 4.6.0 \
  && cd .. \
  && cd opencv_contrib \
  && git checkout 4.6.0 \
  && cd .. \
  && cd opencv \
  && mkdir build \
  && cd build \
  && cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D INSTALL_C_EXAMPLES=ON \
        -D OPENCV_ENABLE_NONFREE=ON \
        -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON .. \
    && make -j4 \
    && make install

# Configurações finais
WORKDIR /home/${USER}

ENTRYPOINT ["/bin/bash"]
