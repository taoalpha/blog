date: 2015-08-20 6:00:00
title: 用 Raspberry Pi 做 NAS 和 采集器
category: tech
description: 本篇为树莓派折腾系列的第二篇, 主要介绍下如何用树莓派制作一个简单的采集器, 也就是自用的网络小爬虫; 另外也顺带介绍下如何把树莓派建立成一个简易的 NAS.
tags: [Raspberry Pi,NAS,Crawler]
series: The Way I learn Pi
author: taoalpha
---

## 引子

在之前
<a href="{% post_path tech-raspberry-pi-setup %}">Raspberry Pi Setup</a>一文中介绍了树莓派的初始配置. 这几天乘着还没开学, 就赶紧把树莓派重新跑起来, 虽然悲催的因为网络设定导致我的树莓派无法联网只能强制重刷了... 好在之前在家里就一直用 samba 把重要的脚本都存在了外置盘上, 而已抓取的数据也有早起的备份, 丢失的数据就没办法了..

所以正好相当于重新设定了一遍 NAS 和 diango , 本文做简单介绍, 方便后续查看.

## NAS

NAS 全称是: Network-attached Storage. 简单说就是在一个网络组中用来存储数据的地方, 而在这个网路组的所有用户都可以在相应的权限下查看, 编辑.

通常一个低配的 NAS 也要差不多100多刀左右, 当然其读写速度, 性能都是很棒的, 买来即用~ 不过作为穷屌丝一枚, 手头又有几个闲置的移动硬盘和 U 盘. 于是就参考网上的教程用树莓派做个简易的 NAS , 供个人和室友使用还是绰绰有余了~

### Samba

想要实现自用的 NAS, 主要依赖的就是 Samba 这个服务了. Samba 是基于 SMB 协议的一个服务. 利用它多平台的特性可以方便的在多平台上进行数据交换. 而自建 NAS 的核心即是: 以树莓派为搭载平台, 将链接其上的闲置硬盘作为共用存储器.

Samba 的安装和配置都很简单:

``` shell
apt-get install samba samba-common-bin
# 修改 /etc/samba/smb.conf 开启安全权限, 取消 `security = user`的注释即可
# 这里主要是确保samba 的用户必须是系统的用户之一

# 然后添加下面内容到 /etc/samba/smb.conf 中
#[public]
#此处把公共盘的名字设定为了 public, 可以修改
#  comment = Public Storage
#  备注名
#  path = /nas
#  path 选择自己挂载硬盘的位置, 初始应该是/dev/sdan 这种格式的, 可以通过 `mount /dev/sdan /newpath`来修改;
#  valid users = pi nas
#  分配用户权限, 这里给予了 pi 和 nas 两个用户的访问权限
#  read only = no
#  create mask = 0777
#  public = yes
#  writable = yes
#  directory mask = 0777
#  guest ok = yes
#  browseable = yes
```

其中, 如果希望每次开机自动挂载硬盘到自定义位置, 可以通过修改`/etc/fstab`文件来实现:
``` shell
#在原有基础上添加(修改 `/sda1` 为你的硬盘初始挂载位置):
/dev/sda1       /nas            ext4    defaults          0       0
```
在完成设定后, 就需要重启 samba 服务并添加对应用户了. 因为我们开启了`security = user`, 所以这里需要给 samba 添加系统用户, 比如默认的 pi 用户, 或者 root. 当然你可以通过`useradd`来给系统创建新用户.

创建用户后, 就可以给 samba 添加用户了.

`smbpasswd -a username` 即可添加用户, `smbpasswd -e nas` 则启用此用户.

设定好对应用户的 samba 密码后即可通过你的电脑访问你的共享盘了, 你可以通过 connect 到 `smb://192.168.x.x`(你的 pi 地址), 然后输入对应的用户名密码即可~

PS. 如果你是用的 NTFS 的硬盘, 那么还需要安装`ntfs-3g`来实现对硬盘的读写功能, 如果你用的是 mac 的盘, 那么还需要安装`hfsplus`和`hfsutils`来实现同样的目的~ 上述都可以通过`apt-get`直接安装.

到此, 你的简易 nas 就算是完成了~ 可以享受喽~

## 采集器

玩 python, 怎么能不写爬虫呢? 哈哈 因为树莓派低功耗, 全天候运行的特性, 作为爬虫可谓是绝佳的好平台 ^_^

### 支持库安装

首先为了跟随时代潮流, 我选择3.4作为 python 主版本~ 2.7.6作为辅助. 这里可以通过[Pythonbrew](https://github.com/utahta/pythonbrew)来实现轻松管理 python 版本的目的. (注: pythonbrew 安装3.4的时候要使用3.4.0这种具体到小版本号的名称安装, 不然会找不到 package 的)

3.4已经自带了pip, 所以就可以不用自己安装了~ 接下来利用 pip 来安装支持库.

``` shell
pip install django
# 我比较习惯django 的框架了, 如果你喜欢 flask 也可以根据自己的喜好调整
pip install beautifulsoup4
# html 解析库, 当然, 你也可以利用 xpath 来硬解~
pip install mysqlclient
# 这个是 MySQLdb的一个 fork, 但是提供了 python3的支持, 用来修复支持 p3 下 django 使用 mysql .
# 如果上述报mysql 的错误或者mysql_config not found, 请确保你已经安装了 mysql 以及 libmysqlclient-dev
pip install pymysql
# 习惯用这个做抓去插入了... 可以用 MySQLdb 的~
pip install git+ssh://git@github.com/Supervisor/supervisor.git
# 因为 supervisor 在 pip 的版本不支持 p3, 所以需要自己直接利用 pip 安装 git 上的版本.
# 需要先添加 sshkey 到 github 上, 不然无法 clone 的~ 相关请查看 github 官方介绍.
```

到此, 基本库就算是差不多全了.

### django

``` shell
django-admin startproject PROJECT_NAME
# 创建新项目
django-admin startapp APP_NAME
# 创建新 app
```

修改 project 里的 `settings.py`, 替换 database 的配置(根据你是用的 db 库修改), 添加 APP_NAME 到 INSTALLED_APPS 里.

### 采集APP

根据自己的情况修改 APP 的 `models.py` 创建表结构.

同步数据库:

``` shell
python manage.py migrate
# 同步 django 的数据库
python manage.py makemigrations APP_NAME
# APP 表结构迁移
python manage.py sqlmigrate crawlers 000x
# APP SQL 迁移(可以预览下 SQL). 这里的000x 是根据上一步 makemigrations 得到的 version 编码, 一致即可
python manage.py migrate
# 同步数据库, 正式生效
```

此外, 记得创建一个 admin user 并且把 admin 的静态文件转移过来~ (需要在 project 的 settings.py 中设定`STATIC_ROOT`路径)

`python manage.py createsuperuser`

`python manage.py collectstatic`

通过这个就可以登录 django 的 admin 后台了~

### 采集脚本

接下来就是数据库的填充了~ 这里就得根据自己的情况来写爬虫喽~

### supervisor 自启动

supervisor 是很好的系统任务管理工具. 利用它可以更方便的管理我们的 django 以及其他的项目, 如果有的话.

上面安装支持库中已经成功的为 python 3 安装了 supervisor, 所以这里我们就可以直接进入到配置环节了:

``` conf
[supervisord]
[program:pragram_name]
directory=path_to_django_project
command=python manage.py runserver
autorestart=true
autostart=true
```

DONE! 保存这一配置文件到你的任意目录中, 只要记得启动`supervisord`的时候利用`-c`指定到这一配置文件即可.

### nginx 映射

为了让我们能够在局域网的其他机器上直接访问我们的 django, 我们需要把 nginx 映射到我们的 django 去~

最简单的方法就是, 利用`proxy_pass http://127.0.0.1:8000;`将80端口直接导向我们的 django server 所在.

``` nginx
server {
    listen   80;
    server_name localhost;
    access_log  /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log debug;
    rewrite_log on;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_redirect  off;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    location /static/ {
        root path_to_project;
    }
}
```

 如此, 通过 `supervisord -c path_to_supervisor_conf` 就可以启动你的 django 了~ 稍等片刻, 你就可以通过访问你的树莓派 ip 看到成功搭建的 django 欢迎页面了~

PS. 如果不喜欢手动加载 supervisor 配置, 也可以把配置文件放到 supervisor 的系统配置目录中, 然后就可以通过`supervisord  start supervisor_program_name`来启动了~

恩, 就到这里了~ 下一步就是在我的树莓派上搭建一个每天任务跟踪的服务了~ 这个还需要好好想想~ ^_^

## 参考

- [django Getting started](https://docs.djangoproject.com/en/1.8/intro/)
- [MySQL database connector for Python (with Python 3 support)](https://github.com/PyMySQL/mysqlclient-python)
- [pip install from git repo](http://stackoverflow.com/questions/4830856/is-it-possible-to-use-pip-to-install-a-package-from-a-private-github-repository)
- [mysql_config not found when installing mysqldb python interface](http://stackoverflow.com/questions/7475223/mysql-config-not-found-when-installing-mysqldb-python-interface)
