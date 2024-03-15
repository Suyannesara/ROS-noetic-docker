FROM osrf/ros:noetic-desktop-full
# FROM pachyderm/opencv

# YOU should replace your_os_user with your actual system user
RUN useradd -ms /bin/bash suyanne
ARG USER=suyanne
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt-get update --fix-missing

RUN apt-get install -y \
    git \
    sudo \
    python3-pip \
    build-essential \
    cmake \
    pkg-config \
    # Optional OpenCV dependencies
    # libjpeg-dev \
    # libtiff5-dev \
    # libpng-dev \
    make

# ROS Dependencies
RUN apt-get install -y \
    ros-noetic-moveit \
    ros-noetic-ros-controllers \
    ros-noetic-rosserial \
    ros-noetic-roboticsgroup-upatras-gazebo-plugins \
    ros-noetic-actionlib-tools

RUN apt-get install -y \
    ros-noetic-gazebo-ros-control \
    ros-noetic-gazebo-ros-pkgs

RUN apt-get install -y wget python3-catkin-tools ros-noetic-catkin python3-rosinstall-generator


# # INSTALL MAVLINK
# RUN rosinstall_generator --rosdistro noetic mavlink | tee /tmp/mavros.rosinstall
# # INSTALL MAVROS
# RUN rosinstall_generator --upstream mavros | tee -a /tmp/mavros.rosinstall

WORKDIR /home/${USER}/Volumes

# ADD PX4 CODES
RUN git clone https://github.com/PX4/PX4-Autopilot.git \
    && bash ./PX4-Autopilot/Tools/setup/ubuntu.sh

# SOURCE ROS THINGS
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc \
    && source ~/.bashrc


# BASE END CONFIG
ENTRYPOINT ["/bin/bash"]
