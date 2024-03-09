FROM osrf/ros:noetic-desktop-full

# YOU should replace your_os_user with your actual system user
ARG USER=your_os_user
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# Atualiza os pacotes e instala dependências do ROS e outras ferramentas
RUN apt-get update && apt-get install -y \
    git \
    sudo \
    ros-noetic-moveit \
    ros-noetic-ros-controllers \
    ros-noetic-gazebo-ros-control \
    ros-noetic-rosserial \
    ros-noetic-rosserial-arduino \
    ros-noetic-roboticsgroup-upatras-gazebo-plugins \
    ros-noetic-actionlib-tools \
    python3-pip \
    build-essential \
    cmake \
    pkg-config \
    libjpeg-dev \
    libtiff5-dev \
    libpng-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libgtk-3-dev \
    libatlas-base-dev \
    gfortran \
    libeigen3-dev \
    && rm -rf /var/lib/apt/lists/*


# Baixa e compila o OpenCV
WORKDIR /tmp
RUN git clone https://github.com/opencv/opencv.git
RUN git clone https://github.com/opencv/opencv_contrib.git
WORKDIR /tmp/opencv
RUN git checkout 4.5.1
WORKDIR /tmp/opencv_contrib
RUN git checkout 4.5.1
WORKDIR /tmp/opencv/build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..
RUN make -j$(nproc)
RUN make install
RUN ldconfig

# Limpa os arquivos de instalação do OpenCV para economizar espaço
WORKDIR /
RUN rm -rf /tmp/opencv /tmp/opencv_contrib

# Configurações finais
WORKDIR /home/${USER}
ENTRYPOINT ["/bin/bash"]
