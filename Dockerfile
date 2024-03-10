FROM osrf/ros:noetic-desktop-full

# YOU should replace your_os_user with your actual system user
ARG USER=your_current_user
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# Atualiza os pacotes e instala dependências do ROS e outras ferramentas
RUN apt-get update && apt-get install -y \
    git \
    sudo \
    python3-pip \
    cmake \
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
    && rm -rf /var/lib/apt/lists/*

RUN apt-get install build-essential
RUN apt-get install libjpeg-dev libpng-dev libtiff-dev 
RUN apt-get install libavcodec-dev

WORKDIR ~

RUN cd ~
# OPEN CV
RUN git clone https://github.com/opencv/opencv.git
RUN git clone https://github.com/opencv/opencv_contrib.git

RUN cd opencv && git checkout 4.6.0 && cd ..
RUN cd opencv_contrib && git checkout 4.6.0 && cd ..

# RUN ls && sleep 5
RUN pwd && sleep 5
# RUN cd opencv
RUN cd opencv && mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=ON \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..

RUN make -j4
RUN make install

# Configurações finais
WORKDIR /home/${USER}

ENTRYPOINT ["/bin/bash"]
