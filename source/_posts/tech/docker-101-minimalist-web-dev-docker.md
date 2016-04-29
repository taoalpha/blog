title: Docker 101 minimalist web dev docker
date: 2016-04-27 11:51:19-04:00
category: tech
tags: [Docker]
---

## Write ahead

After we knew some basic ideas and commands of Docker (No? see [Docker 101 self-learning tutorial](http://taoalpha.me/blog/2016/03/10/tech-docker-101-self-learning-tutorial/)). We can build our own docker images and customized our dev kit.

Today I will show you how to use Dockerfile build your own images, here I build a minimalist web dev image as example:

## Let's code

### Dockerfile

Dockerfile is a config doc that descripe how you want to assemble an image. And then use `docker build [name-of-image] [path-to-dockerfile]` build the image.

Here are the most common commands you can use in your Dockerfile.

All commands are not case-sensitive, but normally we use all UPPERCASE:

1. **FROM**
  Using `FROM <image>:<tag>` or `FROM <iamge>@<digest>` so you can build your image based on the image you want to set as base image. Since most images build on top of some images, so a `FROM` must be the first non-comment instruction in the Dockerfile.
2. **MAINTAINER**
  Using `MAINTAINER <name>` so you can specify the `Author` field of the image you generated.
3. **RUN**
  This is the most useful and common commands in Dockerfile, you can use it run any commands the image you use support, mostly are shell commands: `RUN <command>` or `RUN ["executable", "param1", "param2"]`.
4. **CMD**
  The main purpose of a CMD is to provide defaults for an executing container: `CMD ["executable","param1","param2"]`, `CMD ["param1","param2"]`, `CMD command param1 param2`. One Dockerfile can only have one CMD instruction, if you have multiple, the latest one will be used.
5. **LABEL**
  Same as **MAINTAINER**, you can use it add some metadata to an image:`LABEL <key>=<value> <key>=<value> <key>=<value> ...`
6. **EXPOSE**
  The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime. EXPOSE does not make the ports of the container accessible to the host. To do that, you must use either the -p flag to publish a range of ports or the -P flag to publish all of the exposed ports. 
  Normally we use -p while creating a container instead of expose while building the image.
7. **ENV**
  Treat this as variable delcaration like `var` in javascript. After you declare a variable, you can use it anytime after by referring the name of the variable: `ENV <key> <value>`, `ENV <key>=<value> ...`
8. **ADD**
  If you want to copy files to the image, you should use ADD: `ADD <src>... <dest>` or `ADD ["<src>",... "<dest>"]`.
  You can also use url as src to download a file from the url, or if you use path , then the path to the src should be relative to the context of build, and if the src is a recognised compression format, it will be unpacked.
9. **COPY**
  Pretty much the same as ADD, but limited version (can not use url and won't unpack the compressions). Actually deprecated after 1.1.2.
10. **ENTRYPOINT**
  An ENTRYPOINT allows you to configure a container that will run as an executable. Like you assign a default command you want it to run after you use this image create any container. `ENTRYPOINT ["executable", "param1", "param2"]` or `ENTRYPOINT command param1 param2`. And all parameters after `docker run <image>` will be added to the ENTRYPOINT.
11. **VOLUME**
  If you want to mount your local files as a volume to the image, you should use this command. `VOLUME ["/data"]`
12. **USER**
  Use to set the user name or UID to use when running the image and also for any RUN / CMD commands.
13. **WORKDIR**
  The entry point for you image (pwd).

All you want to know about Dockerfile can be found [from this link](https://docs.docker.com/engine/reference/builder/).

### Minimalist Web Dev Docker

Now let's build our own Dockerfile to assemble a minimalist web dev image. First, let's give a list of requirements we need for this image:

1. node@latest
2. npm@latest
3. zsh ( I love zsh )
4. vim / git / curl
5. Default settings for zsh and vim: oh-my-zsh, amix/vimrc.

Since we want a minimalist image, we can not use ubuntu or other powerful linux, we should use alpine, the smallest linux I ever seen. And thanks for [@mhart](https://github.com/mhart/alpine-node), he built a base image for node env based on alpine. So we can just use his shoulder :)

```
# always use the latest :)
FROM mhart/alpine-node:latest
MAINTAINER <your_name>

# set your workspace which would be your WORKDIR
ENV WORKSPACE /root

RUN apk --update add \
      vim \
      git \
      zsh \
      curl

# put all your settings for zsh and vim in another shell script and copy to your image
ADD scripts/initialized.sh ${WORKSPACE}/initialized.sh
# Run the script to set your vim and zsh
RUN sh ${WORKSPACE}/initialized.sh

# set the workdir
WORKDIR ${WORKSPACE}
```

And for you `initialized.sh`:

```
#!/bin/bash

# set up conf for vim
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# set up conf for zsh and replace bash with zsh as default
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

##### Below would totally depends on you #####
# set up the vim with customized plugins and configs
git clone https://github.com/mxw/vim-jsx ~/.vim_runtime/sources_non_forked/vim-jsx
git clone git://github.com/tpope/vim-unimpaired.git ~/.vim_runtime/sources_non_forked/vim-unimpaired
git clone https://github.com/mattn/emmet-vim ~/.vim_runtime/sources_non_forked/emmet-vim

# pull the configs
git clone https://gist.github.com/89b072c8d6c34d91047be1421b23d8bc.git /tmp/a
mv /tmp/a/my_configs.vim ~/.vim_runtime/

# clean the temp files
rm -rf /tmp/*
```

Now you have a minimalist image to start your web dev which roughly ~100M .

## Tips

Since we did not install python, g++ and other tools, so if you want to use node-sass and some packages like it that need to be compiled before using, you may have to add these packages by yourself :)
