---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch计划-Day3--GithubPages以及python的一些Issue
tags: [python,github pages,Patch,re,insert]
---

恩,今天主要google了一下Github page的问题以及一些python中的re小应用问题, 不过两个东西都非常费解, 所以google并没有完全解决我的困惑, 但暂时先按照今天所得整理如下, 后续继续补充, 尤其是re,真真博大精深啊...
<ol>
	<li>github page, 是由github提供的一个静态页面托管服务,通过你的github账号, 你可以创建一个属于你的page,里面可以展示你想要展示的内容,同时也可以通过project pages来添加你在github上所有的项目的介绍页面~形如: xxxx.github.io/xxxproject</li>
	<li>管理github的project pages, 因为我是在VPS上操作的,所以主要说的也是在command下的操作. 当你通过git clone将你的project拷贝下来后, 你可以通过git checkout gh-pages来建立分支作为你要展示在该project page里的内容.里面只需要包含一个html文件和它想一个需要用到的所有静态文件即可.
<a title="Git Branch" href="http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging#Basic-Merging" target="_blank">这里有一个介绍branch的post</a>,我觉得说的非常赞!很值得阅读.</li>
	<li>再说Python,今天有同学问我如何想一个文本文件中的指定行插入数据? 我想了一下, 大致可以有两个实现的方式:
A: 通过re,这个是最简单也是最容易想到的, 通过正则来匹配找到要插入的位置, 然后用re.sub()去替换即可,如下为实例:

{% highlight python %}
import re
rawfile='''
abcs
*insert
lastpart
'''
re.sub(r'\*insert','InsertBefore\n*insert',rawfile)

{% endhighlight %}

如此就可以在指定的位置前或者后插入指定的内容, 同时也很容易保留匹配的部分.
B: 通过list的insert函数,如果你知道文件中数据的格式和位置, 那么就可以利用readlines()和insert()函数来实现同样的效果:

{% highlight python %}
import re
rawfile='''
abcs
*insert
lastpart
'''
with open(filename,'r') as fl:
    print "".join(fl.readlines().insert(2,"InsertBefore"))

{% endhighlight %}

如上,也可以将"InsertBefore"插入到*insert之前, 但是这样的话需要对文本内容的了解, 同时对于结构的细微变化都会更加敏感.
</li>
</ol>
