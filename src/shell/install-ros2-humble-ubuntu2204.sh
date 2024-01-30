#! /usr/bin/env bash
# source ./install-ros2-humble-ubuntu2204.sh
# clear; script -c 'set -vx; source ./install-ros2-humble-ubuntu2204.sh --distro humble --force-install; set +vx'; set +vx

export rosuser=rosuser

pause() {
    read -p "Press Enter to continue..."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
        echo "This script must be source'd!"
        pause
        exit 1
fi

if [[ "$1" == "--help" ]]; then
echo "\
* --distro humble
  --force-install:  Force installation of ROS, even if it is already installed
  --set-distro:     Skip after setting distro
"
return 0
fi

# Parse arguments
while [[ ! "$1" == "" ]]; do
    if [[ "$1" == "--force-install" ]]; then
        force_install=true
        echo "Enforcing new installation..."
        shift
    elif [[ "$1" == "--distro" \
                && -v $2
        ]]; then
        export ROS_DISTRO=$2
        shift
        shift
    elif [[ "$1" == "--set-distro" ]]; then
        set_distro=true
        echo "Skip after setting distro..."
        shift
    fi
done

if [[ ! -v $ROS_DISTRO ]]; then
    export ROS_DISTRO=humble
fi
echo "Installing ROS2 $ROS_DISTRO..."

if [[ "${set_distro}" == "true" ]]; then
    return 0
fi

export RUN="sudo -s"
noop=true

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

                echo "$USER: groups $rosuser..."
                groups $rosuser
                echo "Run this script again, when in new user space..."
                echo "Lifting ${USER} to $rosuser space..."
                su $rosuser
                exit 0
            fi
        fi
else
        echo "Nothing to do: User $USER is already $rosuser"
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

    # Set Locale
    if env | grep -q "^LANG=en_US.UTF-8$"; then
        $noop
    else
        sudo apt update && sudo apt install locales
        sudo locale-gen en_US en_US.UTF-8
        sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
        export LANG=en_US.UTF-8

        locale  # verify settings    
    fi

    # Skip if ROS is already installed...
    if [[ ! -d /opt/ros 
            || "${force_install}" == "true"
        ]]; then
        ###########################################################################
        echo "Start installation of ROS2 ${ROS_DISTRO}..."
        #   https://docs.ros.org/en/${ROS_DISTRO}/Installation/Ubuntu-Install-Debians.html
        ###########################################################################

        # Setup Sources
        #--------------------------------------------------------------------------
        echo Enable universe repos
        #--------------------------------------------------------------------------
        apt install -y software-properties-common
        add-apt-repository universe

        if [[ ! "${force_install}" == "true" ]]; then
            #--------------------------------------------------------------------------
            echo Add the ROS2 GPG key
            #--------------------------------------------------------------------------
            apt update -y && sudo apt install -y \
                curl
            curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
                    -o /usr/share/keyrings/ros-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
                    # http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
        fi

        #--------------------------------------------------------------------------
        echo Install ROS2 packages
        #--------------------------------------------------------------------------
        apt update -y
        apt upgrade -y

        apt install -y ros-${ROS_DISTRO}-ros-base
    fi
EOF

#--------------------------------------------------------------------------
echo Updating extisting installation...
#--------------------------------------------------------------------------
if [[ -d /opt/ros ]]; then
    echo "Installing Desktop for ROS2 distro..."
    sudo apt install -y ros-${ROS_DISTRO}-desktop

    # The package ros-dev-tools contains a number of tools that are useful for developing ROS packages, including 
        # rosbag, ros_readbagfile, rosbash, roscd, rosed, rosclean, roscore, rosdep, roscreate-pkg, roscreate-stack, and rosrun 1.
    # To list all the commands in the package, you can run the following command in your Ubuntu terminal:
    # dpkg -L ros-dev-tools | grep /bin/
    # This will display the complete list of commands that are included in the ros-dev-tools package 2.
    sudo apt install -y ros-dev-tools
    sudo rosdep fix-permissions
    sudo rm -f /etc/ros/rosdep/sources.list.d/20-default.list
    sudo rosdep init
    rosdep update

    #--------------------------------------------------------------------------
    echo Adjusting tools...
    #--------------------------------------------------------------------------
    # TODO: sudo apt install -y ament_cmake: ?
    sudo apt install -y ros-${ROS_DISTRO}-rmf-cmake-uncrustify
    sudo apt install -y python3-colcon-common-extensions
    source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash

    sudo apt install -y python3-pip
    #--------------------------------------------------------------------------
    echo Adjusting pip...
    #--------------------------------------------------------------------------
    pip3 install --upgrade pip
    # TODO:
    # WARNING: The scripts pip, pip3, pip3.10 and pip3.11 are installed in '/home/rosuser/.local/bin' which is not on PATH.
    # Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location:
    export PATH=$PATH:/home/$rosuser/.local/bin
    pip3 install setuptools==58.2.0
fi
echo "End installation of ROS2 ${ROS_DISTRO}..."

#--------------------------------------------------------------------------
# Environment setup
echo "Sourcing ROS2 (and related) scripts..."
#--------------------------------------------------------------------------
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
source /opt/ros/${ROS_DISTRO}/setup.sh
return 0

# @ROS2 Project:
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
colcon build
source install/setup.sh
source /opt/ros/${ROS_DISTRO}/setup.sh
