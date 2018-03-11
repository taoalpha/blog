date: 2016-03-10 7:00:00
title: Docker 101 self-learning tutorial
category: tech
description: docker 101
tags: [docker]
series: The way I learn Docker
author: taoalpha
---

## What Docker does ?
Docker is a software that help you implement the concept of Linux container which is pretty similar with virtual machine but more light-weight.

Docker has a really great system or workflow that make build, ship and deploy your product really easy to do. You can find a lot of posts about docker on the interneet since it becomes so popular recently.

Here I will try to explain what docker does based on what I know about docker.

Consider docker as a minimal linux boot tool with all the same parts (like the common kernel etc) in all linux systems, and it can load the system image and create a container based on the image, and inside the container running the system or execute some basic linux commands.

## Important Concepts in Docker
There are some very important concepts used in docker:

### docker daemon
Docker daemon provides the connections between you and the inside of the docker. So before you actually start using docker, you have to start docker daemon first.

### Image
Image is like the package that you want to use repeately, since you will use image to create a container.

### Container
Container is like a temporary OS you create based on the image, maybe a whole OS like ubuntu with some packages installed creating the image, or a simple OS env(like the naked kernel) that executes the pre-defined commands in the image.

If you make some changes in one container and you want to use the new container as the base image next time you create containers, you can commit and package the container into an image.

### Registry
Consider registry as a factory contains a lot of images created and uploaded by other people. You can pull some images you need or upload some images you create.

## Docker commands
Docker has several very common commands you will use everyday. If you want to try docker, this should be a really good start:

- ps
list current active containers for you. If you want to check recently used containers, you can use docker ps -n number
- images
list images you have.
- pull
pull <image name> , pull an image from the docker hub or some private registry
- run
run <optional parameters> <image> <commands>, run an image which will create a container for you.
- diff
diff <container>, show the difference (changes you made) of a container.
- log
log <container>, show the log of a container.
- commit
commit <container id> <image name>, pack the container to a new image, use -m record the comments, -a to specify an author.
- attach
attach <container id>, get into the running container.
- tag
set tags on an image.
- build
build an image from Dockerfile.
- push
push <image name>,push the image to hub.
- rm / rmi
rm / rmi <container id / image name>, remove the container / image
- inspect
inspect <container id>, get some detail information like the network of a container
- network
network <command> <...>, create your own brighe network

## How to use docker
Now you can start playing with docker :) But don’t know what to do ? Maybe you can try to start with creating your own work env.

Docker encourage one component each container, like you should have a database container separated with your web server container.

If no idea what to start, just go to docker hub and get inspired :)

