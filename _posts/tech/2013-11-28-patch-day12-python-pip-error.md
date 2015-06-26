---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day12-python-pip错误
tags: [python,coding,Patch]
---

之前发现每次pip list都会报错,但是也没有影响到任何使用,于是就一直没有管过~今天研究django,顺带就一起fix了~
其实很简单,google了一下就发现在pip的github页面已经有了这个issue~<a href="https://github.com/pypa/pip/issues/1093" target="_blank">here</a>

看错误描述的话,应该是版本问题所致,一个命令就可以修复了~

It happens when you install distribute using http://python-distribute.org/distribute_setup.py script. 


{% highlight python %}

pip install -U distribute

{% endhighlight %}

fixes the problem. The bug reproduces only in pip==1.4. 

谨以记录 ,谨防下次再现!
