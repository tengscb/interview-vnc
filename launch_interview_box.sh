#!/bin/bash

if [ "$EUID" -ne 0 ]
  then
    echo "Please run with sudo"
    echo "USAGE: sudo ./launch_interview_box.sh <intellij|intellij-dark|eclipse>"
    exit 2
fi

if [ -z "$1" ]
  then
    echo "USAGE: sudo ./launch_interview_box.sh <intellij|intellij-dark|eclipse>"
    exit 1
fi

TAG=$1

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

CONTAINER=intbox

docker stop $CONTAINER
docker rm $CONTAINER

docker run -d -it \
--name=${CONTAINER} \
--privileged \
-p 80:26080 \
-v /dev/shm:/dev/shm \
-v $(pwd)/videos:/videos \
-e SCREEN_WIDTH=1440 \
-e SCREEN_HEIGHT=900 \
-e NOVNC=true \
-e VIDEO=true \
-e VIDEO_FILE_NAME=interview_recording \
billsun/coding-interview:$TAG

apt-get install git

git clone https://github.com/tengscb/coding-question.git

docker cp coding-question $CONTAINER:/home/seluser/coding-question