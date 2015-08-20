---
layout: post
title: Raspberry Pi Setup
category: tech
description: 今天介绍下如何配置一个树莓派, 主要是一些树莓派的基本配置, 多数大家google以下也是可以找到的, 这里算是汇总了一下.
tags: [Raspberry Pi,node,wifi,python]
series: The Way I learn Pi
author: taoalpha
---

## 概述

今天介绍下如何配置一个树莓派, 主要是一些树莓派的基本配置, 多数大家google以下也是可以找到的, 这里算是汇总了一下.

内容主要包括:

- 树莓派系统安装;
- 初始化配置;
- nodejs环境配置;
- python环境配置;
- wifi环境配置;

## 树莓派的基础设定

### 树莓派系统安装

目前在[树莓派的官网](https://www.raspberrypi.org/downloads/)主要提供了两种安装系统的方式, 一种是直接烧制, 通过将已下载的img文件利用对应的工具烧制到格式化好的SD卡中, 制作出直接可用的启动盘; 另一种则是通过官方发布的[NOOBS](https://www.raspberrypi.org/help/noobs-setup/)来进行启动安装.

- 直接制作法:

  有过制作系统经验的朋友都应该了解这种方法, 不同平台也有不同的工具可以用以制作, 这里就没啥好说的了. mac下可以按照[官网的Guide](https://www.raspberrypi.org/documentation/installation/installing-images/mac.md)逐步操作即可.

- NOOBS法:

  NOOBS法其实并不是直接烧制一个好的系统进去, 而是一个类似winpe, 而且更简易的启动程序. NOOBS法分为2个版本, 一个是包含了十个左右的预装系统, 另一个则是单纯的NOOBS, 需要联网下载选择的系统进行安装; 通常做启动化设定的话, 用离线版的肯定比较省事~

  下载完NOOBS后, 直接将NOOBS压缩包解压到你已经格式化好的SD卡上, 然后插入树莓派启动就能进入下面的就界面了:

  {% image https://camo.githubusercontent.com/07e4a6e82b21e1acefb69b6058af7b4f0dec17e9/687474703a2f2f646f776e6c6f6164732e72617370626572727970692e6f72672f4e4f4f42532f73637265656e73686f74732f6f735f73656c65637465642e706e67 %}

  选择你想要安装的系统, 选择install即可(此处可以选择多系统, 根据你的SD卡等具体情况即可).

那么如何选择呢? 对我而言, 很简单, 第一次安装的时候, 手头没有HDMI线, 那么没有屏幕的话, 用NOOBS的话无法操作, 所以就直接烧的系统, 这样就可以直接启动, 然后通过ssh配置即可; 后来因为玩坏了python, 怎么改都没改好,于是就决定重装, 而手头正好有HDMI线了, 所以这次就试用了下NOOBS, 觉得也很省事, 尤其是可以直接装多系统(我装了标准R和Arch)~

### 初始化配置

一旦你安装好系统后, 就可以开始启动系统了. 插上电源, 插上SD卡即可. 因为无屏的情况居多, 所以下面就以无屏作为基本环境, 目前pi基本都默认开启了SSH, 所以我们可以直接通过ssh登录设定.

- 首先的首先, 你需要一个网线... 可以直接链接你的树莓派和路由器或者你的电脑;
- 首先, 你需要你pi的ip, 如此才能进行ssh登录: 这个很简单, 登录到你的路由器管理页面, 通过客户端列表查看你的树莓派被分配到的ip地址(如果你是直连笔记本的话, 记得设定你的笔记本网络分享,然后通过`arp -a`, windows下, 扫描出你的树莓派的分配ip即可);
- 连接, 找到ip后, 就可以通过ssh登录了, 默认的初始用户名和密码是: pi -> raspberry;
- 基本配置: 通过`raspi-config`命令就可以对树莓派做一些基本的配置, 比如内存分配啊, 超频啊, 修改密码,设定主机名啊等等, 其中超频(overclock)这部分大家要谨慎一些处理, 可以从低到高的逐步超频, 目前亲测B+下超频到turbo 1000的话基本还是毫无压力的, 而如果你不需要图形界面的话, 那么可以把GUI的内存分配到最低: 16;

### nodejs以及python环境配置

因为个人属性, 所以还是比较集中在node和python中, 像java等环境我就基本不管了. 下面介绍下node和Python在pi里面的配置:

- nodejs

  目前RASPBIAN 3.18下node还是不默认支持的, 需要我们手动安装, 主要有下面几个安装方式:

  - 源码编译:

    这种方法最为简单, 而且通常可以直接安装到最新版本, 从[官网](https://nodejs.org/)下载到源码包解压后自己`./configure``make``make install`就是漫长的等待了...至少半天吧... 毫不夸张..

  - 预编译安装:

    主要是因为node的编译时间太长...所以有人发布了编译好的版本可以直接下载使用, 具体可以[参考此文: Download compiled version of Node.js 0.12.0 Stable for Raspberry Pi here](http://conoroneill.net/download-compiled-version-of-nodejs-0120-stable-for-raspberry-pi-here).

  - 包管理安装:

    [node官网](https://nodejs.org)还提供了如何通过包管理的方式来安装node, 详细的区分不同系统的可以看[Installing Node.js via package manager](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager)~ RASPBIAN是基于debian的, 所以我们参考 debian 的话即可;

  - 通过deb包安装:

    此种方法也是个人比较推荐的, 简单易行. 目前[node-arm](http://node-arm.herokuapp.com/)中更新的最新deb包是0.12.1的版本. 基本也够用了~ 下载deb包后直接`dpkg -i 包`即可;

  可能会出现的问题:

  - 版本过低: 默认通过apt-get获取的node版本似乎只到0.6吧, 记不清了, 反正最多不过0.10, 此种情况下, 可以先执行`apt-get update & apt-get upgrade`等或者通过[nodesource](https://github.com/nodesource/distributions)更新以下源;
  - `illegal instruction`: 有时候你安装了node之后, 可能会发现输入`node`命令都会提示`illegal instruction`, 此种问题主要是因为树莓派的cpu所致, 而且是V8的问题, 并非nodejs的问题, 具体的细节大家可以google了解下, 具体的解决办法呢, 我也不确定, 只知道我`apt-get upgrade`了以下后重启了下就ok了...

- python

  RASPBIAN 目前的python版本是多版本的, 包含了2.7.3和3.2, 而因为我通常的开发环境是2.7.6, 所以这里介绍下如何替换python的方法.

  - 源码编译:

    python相比nodejs而言要省时很多... 不过也很慢... 不推荐;

  - pythonbrew:

    这里介绍一个很赞的办法: pythonbrew. 这是一个python管理工具, 它可以帮助你在多版本python下进行转换. 安装方法很简单: [pythonbrew Github](https://github.com/utahta/pythonbrew).

    其中可能出现环境配置问题导致找不到`bin/pythonbrew`文件, 你可以通过手动将`/usr/local/pythonbrew`拷贝一份到`~/.pythonbrew`中即可解决;

    安装后的使用非常便捷, 只需要利用`pythonbrew install 版本号`以及`pythonbrew switch 版本号`就能切换python版本了~

  > Tip: 除非迫不得已, 不要乱动系统的python版本;

  结合virtualenv和pythonbrew, 你就可以实现独立的版本环境了~哈哈

### wifi环境配置

树莓派本身是没有无线网卡的, 所以如果想要让其支持无线上网的话, 你需要自己购买一个无线网卡接入, 并且安装对应的驱动.本人用的是realtek的无线网卡, 插入后通过`lsusb`查看到已经检测到设备后, 就可以通过`apt-get install firmware-realtek`安装配套的驱动.

当你通过`ifconfig`查看到`wlan0`的时候, 就证明你的无线网络支持已经可以了, 接下来就需要配置对应的无线属性了:

打开`/etc/network/interfaces`, 如果你喜欢`vim`, 可以通过`apt-get install vim`安装vim, 打开根据你的需要修改对应的属性: 比如`wlan`的ip分配是`manual`or`dhcp`或者是`static`. 然后在对应wpa-conf的设定文件中添加对应的network即可:

{% highlight shell %}
network={
    ssid="SCHOOLS NETWORK NAME"
    psk="SCHOOLS PASSWORD"
    id_str="school"
}

network={
    ssid="HOME NETWORK NAME"
    psk="HOME PASSWORD"
    id_str="home"
}
{% endhighlight %}

如果你有多个无线网需要支持的话, 可以在其中添加多个network块即可;

### 开启root

在上述命令中你会发现很多都需要`sodu`执行, 这是因为你默认使用的是pi账户, 而非root. 默认情况下root账户是关闭的, 需要你重新开启:

很简单, 给root设定一个密码即可:`sudo passwd root`, 同时如果你需要用root登录ssh的话, 请确保`/etc/ssh/sshd_config`中的`PermitRootLogin yes`.


## 总结

树莓派可谓是极佳的学习硬件的工具, 其开放性极强, 扩展性极强, 它能做什么完全由你决定. 这里分享国内外几个不错的社区给大家:

- [极客范儿](http://www.geekfan.net/)
- [PiWeekly](http://piweekly.net/)
- [RasPi Tv](http://raspi.tv/)
- [Raspberry Pi Beginner - Youtube Channel](https://www.youtube.com/user/RaspberryPiBeginners)

## 参考资料

- [树莓派的官网](https://www.raspberrypi.org/downloads/)
- [NOOBS GUIDE](https://www.raspberrypi.org/help/noobs-setup/)
- [Installing Node.js via package manager](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager)
- [Download compiled version of Node.js 0.12.0 Stable for Raspberry Pi here](http://conoroneill.net/download-compiled-version-of-nodejs-0120-stable-for-raspberry-pi-here)
- [node-arm](http://node-arm.herokuapp.com/)
- [pythonbrew Github](https://github.com/utahta/pythonbrew)
- [Automatically connect a Raspberry Pi to a Wifi network](http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/)
- [SETTING WIFI UP VIA THE COMMAND LINE](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md)
