#! /usr/bin/env bash
# install-tools-ros2-humble-ubuntu.sh

export rosuser=rosuser

if [[ -e $ROS_DISTRO ]]; then
    export ROS_DISTRO=humble
fi

export RUN="sudo -s"

source /etc/os-release

if [[ ! $ID_LIKE == *"debian"* ]]; then
    echo "This script only supports debian and its deriviatives!"
    return 1
fi

if [[ "${USER}" == "" ]]; then
        if [[ ! ${HOME} == "" ]]; then
            export USER=$(basename "$HOME")
        else
            echo "Cannot state which user is running in the terminal"
            return 1
        fi
fi

if [[ ! "${USER}" == "$rosuser" 
    ]]; then
        if [[ "${USER}" == "root" 
                && $ID_LIKE == *"debian"*
            ]]; then
                if ! type "sudo" &> /dev/null; then
                        # Assume first time installation
                        apt update -y
                        apt install -y sudo

                        echo "Adding $rosuser to sudo..."
                        sudo adduser $rosuser
                        if [[ $ID_LIKE == *"debian"* ]]; then
                                sudo usermod -aG sudo $rosuser  # Debian/Ubuntu
                        elif [[ $ID == *"fedora"* ]]; then
                                sudo usermod -aG wheel $rosuser # Fedora
                        fi
                fi
        fi

        groups $rosuser
        echo "Run this script again, when in new user space..."
        echo "Lifting ${USER} to $rosuser space..."
        su $rosuser
        exit 0
else
        echo "Nothing to do: User is already $rosuser"
fi

$RUN << EOF
    # ###########################################################################
    # echo For X11 forwarding
    # ###########################################################################
    # apt-get -y install --no-install-recommends \
    #     xauth

    # ###########################################################################
    # echo For CPP Development and debuging in general
    # ###########################################################################
    # apt-get update && export DEBIAN_FRONTEND=noninteractive \
    # && apt-get -y install \
    #     build-essential cmake cppcheck valgrind clang lldb llvm gdb \
    #     nano less
    
    # Skip if ROS is already installed...
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

        rosdep init
        rosdep update

        # TODO: sudo apt install -y ament_cmake: ?
        sudo apt install -y ros-humble-rmf-cmake-uncrustify
    fi

    if [[ -d /opt/ros ]]; then
        apt install -y ros-${ROS_DISTRO}-desktop
        sudo apt install -y python3-pip
        sudo apt install -y python3-colcon-common-extensions

        #--------------------------------------------------------------------------
        echo Adjusting pip and its tools...
        #--------------------------------------------------------------------------
        pip3 install --upgrade pip
        # TODO:
        # WARNING: The scripts pip, pip3, pip3.10 and pip3.11 are installed in '/home/rosuser/.local/bin' which is not on PATH.
        # Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location:
        export PATH=$PATH:/home/$rosuser/.local/bin
        pip3 install setuptools==58.2.0
    fi
EOF
echo End installation of ROS2 - ${ROS_DISTRO}...

#--------------------------------------------------------------------------
echo Sourcing ROS2 scripts...
#--------------------------------------------------------------------------
source /opt/ros/${ROS_DISTRO}/setup.sh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash

# # @ROS2 Project
# colcon build
# source install/setup.sh
