
### 🚢 Running Your First ROS Node Through a Docker Container
This guide outlines the steps to run your first ROS node through a Docker container. The Docker container is pre-configured with Ubuntu 20.04 and ROS Noetic.
*Based on: [Docker container with pre-installed Ubuntu20.04 and ROS Noetic](https://medium.com/@sepideh.92sh/how-docker-revolutionizes-application-development-a-comprehensive-guide-for-beginners-fc2d3e53eb31)*

### Docker Container Information
- **Base Image**: Ubuntu 20.04
- **ROS Distribution**: Noetic

### Prerequisites
- Docker installed on your system. You can check if Docker is installed by running `docker --version` in your terminal.

### Steps

#### 1. Clone the Repository
Clone the repository containing the Dockerfile:

```bash
git clone git@github.com:Suyannesara/ROS-noetic-docker.git
cd ROS-noetic-docker
```

#### 2. Build the Docker Image

The Dockerfile provided in this project defines an image with ROS Noetic installed.

**Modify the Dockerfile to use your system user:**

```Dockerfile
ARG USER=your_os_user
```

Make sure you are inside this project root folder to run the next commands.

Then, build the image pasting the following command on your terminal:
```bash
docker build -t ros-noetic-image .
```
🛑 **Disclaimer**: If you are facing problems to run docker this way, try adding sudo to the beginning of commands:

```bash
sudo docker build -t ros-noetic-image .
```
It is normal if it takes long to build for the first time.

⚠️ **Warning**: Ensure to replace `your_os_user` with your actual system username.

#### 3. Run the Container

Run the container based on the defined image using the following command:

```bash
docker run -it --rm --name ros-noetic-container --user=$(id -u $USER):$(id -g $USER) --env="DISPLAY" --volume="/etc/group:/etc/group:ro" --volume="/etc/passwd:/etc/passwd:ro" --volume="/etc/shadow:/etc/shadow:ro" --volume="/etc/sudoers.d:/etc/sudoers.d:ro" --net host -v /home:/home -v ~/Volumes:/home/usr/ ros-noetic-image
```

#### 4. Run Your First ROS Node

##### 4.1 Start the Terminator Application
Inside the container, start the Terminator application for better terminal window management:

```bash
terminator -u
```

##### 4.2 Run `roscore`
In a Terminator window, run the following command to start `roscore`:

```bash
roscore
```

🛑 **Disclaimer**: If you encounter the error "Error: unable to communicate with master!", follow these steps:
1. Exit the container terminal.
2. Open the `~/.bashrc` file.
3. Add the following lines to the file:
   ```bash
   export ROS_HOSTNAME=localhost
   export ROS_MASTER_URI=http://localhost:11311
   ```
4. Save and exit the file.
5. Source the `.bashrc` file:
   ```bash
   source ~/.bashrc
   ```

##### 4.3 Run the Turtlesim Node
In another Terminator tab (do not close the one with `roscore` running), run the following command to start the Turtlesim node:

```bash
rosrun turtlesim turtlesim_node
```

This should open a window displaying the Turtlesim environment like this:

![Turtlesim window](./turtlesimWindow.png)

##### 4.4 Control the Turtle
In another Terminator tab, run the following command to control the turtle using keyboard inputs:

```bash
rosrun turtlesim turtle_teleop_key
```

🎉 **All done**: Now, you can use the arrow keys on your keyboard to control the movement of the turtle in the Turtlesim environment.