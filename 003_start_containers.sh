#!/bin/bash

#ssh-keygen -f "/home/$USER/.ssh/known_hosts" -R "[localhost]:22222"

# Stop and remove running containers
docker container stop mainframe
docker container rm mainframe


# Create volumes
docker volume create mainframe-datanode-volume

# Start the ecosystem
docker-compose up -d
