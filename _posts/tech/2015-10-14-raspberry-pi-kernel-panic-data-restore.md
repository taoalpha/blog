---
layout: post
title: Restore your database in Raspberry Pi from kernel panic error
category: tech
description: I haven't figured out what's wrong with my Raspberry Pi... But I finally restored all important data in my little Pi and re-created it with a new system.
tags: [Raspberry Pi, Restore, Database]
language: en
author: taoalpha
---

## Background

My Raspberry Pi suddenly stopped running(connection lost when I was connecting with my pi through ssh) when I was doing something really normal(like modifying a file...) And then I tried to connect my pi with a screen and it showed the mysterious Kernel Panic error...

## Possible Solutions

### From the community

I did some search on google and found some people already met this problem before. And there was some answers mentioned about using `fsck` to repaire the boot partition.

You need run the fsck in a linux environment which means you need another linux system and load your Pi system sd-card as an external USB and run the command as follow:

{% highlight shell %}
# first you need find the right partition - you can use
# sudo fdisk -l
sudo fsck.ext4 -v /dev/xxx
# replace the xxx with the name of your Pi partition
{% endhighlight %}

Unfortunately, this method didn't work on my situation... ಥ_ಥ

### From the StackOverFlow

There is a similar method like the one above with more details on [Kernel panic, unable to mount root fs on unknown-block after restart](http://raspberrypi.stackexchange.com/questions/4331/kernel-panic-unable-to-mount-root-fs-on-unknown-block-after-restart).

Apparently.. it didn't work either...

### From you?


## Data Restore

Finally I gave up recovering my pi... but I hoped I can get my data back at least since I have near 6~7 million data in my database... And I definitely don't want to re-crawl them again...

I found it was pretty easy.

### Mount the Pi in your another linux system

First, like before, you need another linux system to mount the system partition of your Pi and copy paste your important data.

{% highlight shell %}
sudo mkdir any_path_you_want
# this is your mount point
sudo mount /dev/xxx path-to-your-mount-point
# now you can access the files in your old pi system
{% endhighlight %}

### Permission

Remember to run every command as root since you need the permission to do that.

Normally, you just need to copy paste all data you want to save. If the files are too many and large, you may need to use `tar -zcvf tar_ball_name path_to_files_or_folders` to compress them.

### Database

Since I use mysql as my primary database, and mysql always saves all data under `/var/lib/mysql`, I just need to compress the entire folder and move it to another backup hard drive.

You will find there is a really big file, ibdata1, which saves all your data and indexes... Don't delete it!!!

### Restore Database

After you backup all you need, you can format your sd card now and re-install a system for your pi. After you install the mysql-server, you will find the `/var/lib/mysql` like before. Now just decompress the tar file you compressed before.

Before you jump into mysql and see whether your data has restored or not, you need change the owner and permission for your 'new files' under the mysql folder.

{% highlight shell %}
sudo chown -R mysql:mysql /var/lib/mysql
sudo find /var/lib/mysql/ -type d -exec chmod 700 {} \;
sudo find /var/lib/mysql/ -type f -exec chmod 660 {} \;
sudo chmod 644 /var/lib/mysql/debian-5.5.flag
{% endhighlight %}

All these are to give your current mysql the right permission to all the files.

Now you are all set. Go and enjoy your data back in one piece!


### ibdata1

> The file ibdata1 is the system tablespace for the InnoDB infrastructure.
> It contains several classes for information vital for InnoDB

>  - Table Data Pages
>  - Table Index Pages
>  - Data Dictionary
>  - MVCC Control Data
>  - Undo Space
>  - Rollback Segments
>  - Double Write Buffer (Pages Written in the Background to avoid OS caching)
>  - Insert Buffer (Changes to Secondary Indexes)

> [Click to check more details : What is the ibdata1 file in my /var/lib/mysql directory?](http://serverfault.com/questions/487159/what-is-the-ibdata1-file-in-my-var-lib-mysql-directory)

There is a wonderful answer on StackOverFlow about reducing the size of ibdata1 : [What is the best way to reduce the size of ibdata in mysql?](http://dba.stackexchange.com/questions/8982/what-is-the-best-way-to-reduce-the-size-of-ibdata-in-mysql).

If you have some unicode characters in your database and you find them become "question marks" after you restore your database, don't panic ^_^. Just change the default character set for your database:

{% highlight conf %}
# /etc/mysql/my.cnf
[client]
# ...
default-character-set=utf8

[mysqld]
# ...
character-set-server=utf8
collation-server=utf8_general_ci
{% endhighlight %}
