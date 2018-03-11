date: 2015-05-26 0:00:00
title: 利用TM进行系统二进制文件恢复
description: 介绍在遭遇误删或者因故丢失系统二进制文件时, 如何利用time machine来进行恢复, 尤其是对一些有特殊权限的二进制文件的恢复.
category: blog
tags: [Time Machine,Mac]
author: taoalpha
---

对于很多喜欢折腾电脑而又刚接触命令行的人而言, 经常会犯的的一个错误就是误删重要文件... 比如类似`/usr/bin/`啊,'/usr/local/bin'之类的, 一不小心, 一激动, 就sudo rm -rf了... 

在mac下, 通常用户级别的二进制文件, 也就是那些你在命令行下输入的各类指令的源文件, 都是存在于系统环境变量之中的`$PATH = /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin`(冒号分割路径).

那么一旦删除这些文件夹, 那么对应的常用指令就会失效, 比如你要是误删了`/bin`路径, 那么你在bash下输入`ls`等命令时就会提示你 `ls: command not found`了. 当然, 出现这一错误的另一种可能就是你无意中修改了$PATH变量, 导致系统没有进入到正确的路径中. 这种情况一般还是比较好解决的, 只需要重新设定以下环境变量, 通常设置为上述的即可.

那么, 如果你真是不幸误删了(或者像我一样莫名其妙的就丢失了...), 那么你可以有以下三种选择:

- 重装系统恢复;
- 从友军同版本电脑中copy;
- 从time machine中尝试恢复;

这里主要介绍第三种方法, 比较适用于有经常性备份习惯的人, 或者是丢失操作发生在不久之前的(根据TM的自动备份设定时间间隔而定).

- 一旦找到丢失的路径后, 那么就可以进入到相应的丢失路径下(一直打开到最近路径), 比如我丢失的`/usr/bin`, 我就进入到`/usr`路径下;
- 唤出TM, 回滚到未丢失前的时间节点(或者希望恢复的节点), 比如我确定自己上午时还是正常的, 所以就直接恢复到早上的一个时间节点;
- 恢复即可;

通过上述操作, 基本上绝大多数时候问题都能够得到解决. 但是对于有一些有特殊权限的文件而言, 上述操作也会遇到新的问题. 还是以`/usr/bin`为例: 其中的`sudo`二进制文件就是一个有着特殊读写权限的文件, 以我目前admin的用户权限也是无法还原这一文件的. 这个时候就需要更换root账户来解决问题了:

- 首先通过系统设定中的users & groups -> login options -> join -> disk utility -> 开启root账户 -> 设定账户密码;
- 开启root账户后, 就可以通过切换账户, 登录到root账户之中, 重新上述恢复的操作了, 这一次, 就不会提示你有权限问题了;

详细的开启root账户的方法可以参考stackExchange的一个回答:

    From the Apple menu choose System Preferences....
    From the View menu choose Users & Groups.
    Click the lock and authenticate as an administrator account.
    Click Login Options....
    Click the "Edit..." or "Join..." button at the bottom right.
    Click the "Open Directory Utility..." button.
    Click the lock in the Directory Utility window.
    Enter an administrator account name and password, then click OK.
    Choose Enable Root User from the Edit menu.
    Enter the root password you wish to use in both the Password and Verify fields, then click OK.
    
    Or from Terminal when logged in as an admin user -
    dsenableroot to enable,
    dsenableroot -d to disable

虽然问题已经解决, 不过到现在我都不知道我是如何把`/usr/bin`路径搞丢的... 我记忆中丢失前的操作如下:

- 删除了iphoto等一些应用;
- 利用gem装了guard和guard-jekyll-plus来实现jekyll和livereload的链接;
- 试了几次jekyll import模块来试图导入wordpress的数据, 以及rss的导入;

但感觉都和`/usr/bin`八杆子打不着啊... 奇怪... 如有人知晓求务必告知! 提前拜谢!

[TaoAlpha]:    http://zzgary.info "TaoAlpha"
