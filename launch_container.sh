#!/bin/bash

apt-get update

apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get -y install docker-ce docker-ce-cli containerd.io

mkdir -p videos

docker stop intbox
docker rm intbox

docker run -d -it \
--name=intbox \
--privileged \
-p 80:26080 \
-v /dev/shm=/dev/shm \
-v $(pwd)/videos:/videos \
-e SCREEN_WIDTH=1440 \
-e SCREEN_HEIGHT=900 \
-e NOVNC=true \
-e VIDEO=true \
billsun/coding-interview:1.0