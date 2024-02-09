#!/bin/bash

if ! command -v glxinfo &> /dev/null
then
    echo "glxinfo command  not found! Execute \'sudo apt install mesa-utils\' to install it."
    exit
fi

vendor=`glxinfo | grep vendor | grep OpenGL | awk '{ print $4 }'`


if [ $vendor == "NVIDIA" ]; then
    docker run -it --rm \
        --name mainframe \
        --hostname MAINFRAME \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        -v `pwd`/../Commands/bin:/home/user/bin \
        -v `pwd`/../Modules/workspace_src:/home/user/Modules/workspace/src \
        -v `pwd`/../Notebooks:/home/user/Notebooks \
        -env="XAUTHORITY=$XAUTH" \
        --gpus all \
        --publish-all=true \
        -p 7777:7777 \
        mainframe:latest \
        bash
else
    docker run --privileged -it --rm \
        --name mainframe \
        --hostname MAINFRAME \
        --volume=/tmp/.X11-unix:/tmp/.X11-unix \
        -v `pwd`/../Commands/bin:/home/user/bin \
        -v `pwd`/../Modules/workspace_src:/home/user/Modules/workspace/src \
        -v `pwd`/../Notebooks:/home/user/Notebooks \
        --device=/dev/dri:/dev/dri \
        --env="DISPLAY=$DISPLAY" \
        -e "TERM=xterm-256color" \
        --cap-add SYS_ADMIN --device /dev/fuse \
        -p 7777:7777 \
        mainframe:latest \
        bash
fi
