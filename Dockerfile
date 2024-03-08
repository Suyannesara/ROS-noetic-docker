FROM osrf/ros:noetic-desktop-full

# YOU should replace your_os_user with your actual system user
ARG USER=your_os_user
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# Source ros1 itens
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /opt/ros/noetic/setup.sh" >> ~/.bashrc
RUN source ~/.bashrc

# Install dependencies
RUN apt-get update
RUN apt-get -y install git
RUN apt-get install -y sudo ros-noetic-moveit
RUN apt-get install -y ros-noetic-ros-controllers 
RUN apt-get install -y ros-noetic-gazebo-ros-control 
RUN apt-get install -y ros-noetic-rosserial
RUN apt-get install -y ros-noetic-rosserial-arduino
RUN apt-get install -y ros-noetic-roboticsgroup-upatras-gazebo-plugins
RUN apt-get install -y ros-noetic-actionlib-tools
RUN apt-get install -y python3-pip && rm -rf /var/lib/apt/lists/*

# Export host in case of master not found
RUN export ROS_HOSTNAME=localhost
RUN export ROS_MASTER_URI=http://localhost:11311

# RUN useradd -ms /bin/bash ${USER}
# USER ${USER}
WORKDIR /home/${USER}


ENTRYPOINT ["/bin/bash"]
