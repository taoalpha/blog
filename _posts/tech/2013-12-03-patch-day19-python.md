---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day19-Linux-命令之cat,head,tail
tags: [head,Patch,tail,Linux命令,Cat]
---

今天还纠结了下也不知道该写啥...CSS的部分进入到一个非常细碎的地方--各种(align)下的各个参数的含义...想了下觉得自己一下子也写不清楚,于是就没有继续这个部分;再说python,这两天完全是在完善抓取脚本,可以说和之前几天的工作比较重复,顶多是根据不同的站点有不同的处理方法,有些简单,有些麻烦,但也着实没什么特别新的东西..于是想了想,就单独开个新话题,简单说下linux的常用命令~

这个话题的开端其实是因为这几天跑python产生了大量的log日志...而在巨大的日志中找到想要的东西..如果用vim搜索或者txt打开的方法都不会很舒服,即便用sublime也会有些痛苦...而linux下有一些很棒的命令可以让你快速的定位和统计你需要了解的信息~

首先是cat,很简单,cat + 文件名即可,就会直接在当前shell中print出来该文件的所有内容,没什么了不起? 加以grep的辅助:
<!--more-->

{% highlight python %}

>> cat ll.log | grep xxxx
# 如此可以方便的打印出所有包含了xxxx关键字的文本,而且会高亮显示xxxx,更容易定位~
>> cat ll.log -n | grep xxxx
# 加上-n可以把行号一起打出来~更容易定位~
>> cat ll.log | more
# 通过more命令让大文件可以一页一页显示~less也可以用同样的方法~
>> cat laya.log | grep 1064 |wc -l
# 通过两个管道来利用wc命令查看包含1064的行数有多少~

{% endhighlight %}

可以看到cat命令本身很简单, 但通过和其他命令的结合就会显得非常强大!~如有机会~会详细列一列什么样的组合最为强劲给力~

cat在查看文件时确实很方便,但当你不知道文件内容,或者就是想看下文件的头部或者尾部时,cat命令反而不如head和tail两个命令了~首先,head命令是专门用来查看文件头部的,这一点在大文件中最为常用,因为cat命令对于大文件而言会因为print的速度过快而无法完全展示~这时,就可以用head来查看了~tail则刚好相反,用来查看尾部~

{% highlight python %}

>> head -100 dd.log
# 查看dd.log文件的前100行;
>> tail -100 dd.log
# 查看dd.log文件的后100行;

{% endhighlight %}

如上~很方便吧~当然,head和tail也是可以接着管道符和其他命令连用哈~

{% highlight python %}

>> head -100 dd.log | grep 10
# 查看dd.log文件的前100行,print出其中包含10的行;
>> tail -100 dd.log | grep 10
# 查看dd.log文件的后100行,print出其中包含10的行;

{% endhighlight %}

~~~今天就到此啦~祝好~
