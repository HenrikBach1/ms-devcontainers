#! /usr/bin/env bash
# install-tools-ros2-humble-ubuntu.sh
# script -c 'export debug_enable=true; ./install-tools-ros2-humble-ubuntu.sh'

if [[ $debug_enable == true ]]; then
    set -vx
else
    set +vx
fi

export ROS_DISTRO=humble
export RUN="sudo -s"

if [[ "${USER}" == "" ]]; then
        if [[ ! ${HOME} == "" ]]; then
            export USER=$(basename "$HOME")
        else
            echo "Cannot state which user is running in the terminal"
            exit 1
        fi
fi

if [[ "${USER}" == "root" ]]; then
    # Suppose first time installation
    apt update -y

    if ! type "sudo" &> /dev/null; then
        apt install -y sudo
    fi
fi

$RUN << EOF
    ###########################################################################
    echo For X11 forwarding
    ###########################################################################
    apt-get -y install --no-install-recommends \
        xauth

    ###########################################################################
    echo For CPP Development and debuging in general
    ###########################################################################
    apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
        build-essential cmake cppcheck valgrind clang lldb llvm gdb \
        nano less
    
    if [[ ! -d /opt/ros ]]; then
        ###########################################################################
        echo Start installation of ROS2 - ${ROS_DISTRO}...
        #   https://docs.ros.org/en/${ROS_DISTRO}/Installation/Ubuntu-Install-Debians.html
        ###########################################################################

        #--------------------------------------------------------------------------
        echo Enable universe repos
        #--------------------------------------------------------------------------
        apt install -y software-properties-common
        add-apt-repository universe

        #--------------------------------------------------------------------------
        echo Add the ROS2 GPG key
        #--------------------------------------------------------------------------
        apt update -y && sudo apt install -y \
            curl
        curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
                -o /usr/share/keyrings/ros-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

        #--------------------------------------------------------------------------
        echo Install ROS2 packages
        #--------------------------------------------------------------------------
        apt update -y
        apt upgrade -y

        # The package ros-dev-tools contains a number of tools that are useful for developing ROS packages, including 
            # rosbag, ros_readbagfile, rosbash, roscd, rosed, rosclean, roscore, rosdep, roscreate-pkg, roscreate-stack, and rosrun 1.
        # To list all the commands in the package, you can run the following command in your Ubuntu terminal:
        # dpkg -L ros-dev-tools | grep /bin/
        # This will display the complete list of commands that are included in the ros-dev-tools package 2.
        apt install -y ros-dev-tools

        apt install -y ros-${ROS_DISTRO}-ros-base
    fi

    #--------------------------------------------------------------------------
    # TODO: The rest compared with docker container ros:humble-ros-core?: <--
    #--------------------------------------------------------------------------
    apt install -y ros-${ROS_DISTRO}-desktop
    rosdep init
    rosdep update
    sudo apt install -y ament_cmake
    sudo apt install -y python3-pip
    sudo apt install -y python3-colcon-common-extensions
EOF

#--------------------------------------------------------------------------
echo Adjusting pip and its tools...
#--------------------------------------------------------------------------
pip3 install --upgrade pip
pip3 install setuptools==58.2.0
# TODO: The rest compared with docker container ros:humble-ros-core?: -->
echo End installation of ROS2 - ${ROS_DISTRO}...

#--------------------------------------------------------------------------
echo Sourcing ROS2 scripts...
#--------------------------------------------------------------------------
source /opt/ros/${ROS_DISTRO}/setup.sh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash

set +vx

# # @ROS2 Project
# colcon build
# source install/setup.sh
