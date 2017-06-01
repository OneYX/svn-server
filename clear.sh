#!/bin/bash

# remove all stopped containers
sudo docker rm $(sudo docker ps -a -q)

# remove all untagged images
sudo docker rmi $(sudo docker images | grep "^<none>" | awk '{print $3}')
