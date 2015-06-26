---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day26-python下载文件的几种方法
tags: [python,文件下载,Patch]
---

在很多情况下我们需要用python来下载网络上的文件,今天就总结下python下载文件的几种方法~

<ol>
	<li>引入wget库,利用wget直接下载.

{% highlight python %}

import wget
url = "http://dasdasd.com/asdas/sadasd.mp3"
wget.download(url)
# 前提是需要预装wget库,这个直接用pip或者下载后setup即可;
# 同时wget.download()会返回文件名

{% endhighlight %}

根据wget的<a href="https://pypi.python.org/pypi/wget" target="_blank">官方介绍</a>,wget最早是通过url来获取文件名的,后来可以通过检测headers来获取文件名, 同时还默认会显示进度条~

不过wget的缺点也是毋庸置疑的,首先是功能非常简单,没有更多的扩展功能,另外,wget并不支持自定义名称,即下载文件时不能按照自己的方式定义名称,只能获取后来重新命名, 且默认会重命名重复文件,而没有提供直接覆盖的备选...
</li>
	<li> 利用urllib的urlretrieve(url, filepath)来获取.
 这也是一种很简单的方法, 只需要把下载的url和下载后保存的路径填进去调用就行了

{% highlight python %}

import urllib
url = "http://dasdasd.com/asdas/sadasd.mp3"
urllib.urlretrieve(url, filepath)
# 如此即可,但因为urllib.urlretrieve()函数不会自动处理断网的情况...于是一般需要设定全局的socket超时,这样不至于以往内断网而导致程序锁死...
import socket
socket.setdefaulttimeout(30)

{% endhighlight %}
</li>

	<li>  其实urllib或者urllib2还有一种方法可以下载文件,尤其是urllib2,因为没有urlrieval这个函数~

{% highlight python %}

import urllib2
url = "http://dasdasd.com/asdas/sadasd.mp3"
mp3file = urllib2.urlopen(url)
output = open("sss.mp3","wb")
output.write(mp3file.read())
output.close()
# 其中"wb"是表示以2进制的方式来写入,所以无论什么格式的文件都可以写~

{% endhighlight %}
</li>

  
	<li>  requests也可以用来下载文件~需要用get()~不过这个库也不是预装的,需要先pip一下~

{% highlight python %}

import requests
url = "http://dasdasd.com/asdas/sadasd.mp3"
r = requests.get(url)
# requests库相比wget而言要强大不少!

{% endhighlight %}

  这里有<a href="http://docs.python-requests.org/en/latest/index.html" target="_blank">详细的介绍文档</a>~有兴趣的可以研究下~哈</li>

</ol>

针对上述的方法,其实不存在特别明显的优劣, 主要还是看你的目的了~各位可以根据需要来决定用哪个~

