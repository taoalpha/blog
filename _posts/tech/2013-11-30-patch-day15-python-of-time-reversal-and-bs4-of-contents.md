---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day15-python的time反转以及bs4的contents
tags: [bs4,python,Patch,contents,datetime]
---

今天遇到一个很好玩的东西,因为需要抓取页面的pub_date,但是这个网站的页面发布时间都是用文本形式存储的,没有办法直接插库,尤其是我把数据库的pub_date类型已经设置为date的类型,所以文本形式进入都会置为00:00:00的~于是google了一下~果然找到了一个解决方法~

用datetime的strptime就可以把它反转过来了~

{% highlight python %}

from datetime import datetime
date_object = datetime.strptime('Jun 1, 2005  1:33PM', '%b %d, %Y %I:%M%p')
## 左右的两部分结构顺序必须一致,逗号什么的都需要保持一致~

{% endhighlight %}


关于time使用的格式问题可以参见之前写的<a href="http://callmet.zzgary.info/2013/11/20/patch-program-day6-python-time-and-css-issues/" target="_blank">一篇blog~</a>

除了上述的时间问题,本次写抓取脚本的过程也遇到了一个bs4的问题,因为需要获取的属性隐藏在某个tag的text之中,而这个tag内部又嵌了几个childnode,我要的文本又隐藏在子节点的后边~通过常规的get_text()或者text()都不好获取,至少获得后需要再次处理,而且很麻烦..于是contents的函数这个时候就很有用了~

{% highlight python %}

## 举个例子吧
import bs4
html='''
<div>
abcde
<span>aaa</span>
hahah
<span>bbb</span>
asda
</div>
'''
soup = bs4.BeautifulSoup(html)
target = soup.find("div").contents[2]
>> hahah
target1 = soup.find("div").contents[1]
>> <span>aaa</spam>
target2 = soup.find("div").contents[1].get_text()
>> aaa
## 其实contents会把div标签下的内容按照域划分,文本属于文本域,而子节点的tag则属于该tag的域,于是乎~就可以通过找到我们需要的域的编号来获得相应域的内容了~

{% endhighlight %}


如上~算是今天写抓取脚本的时候主要遇到的几个问题~记录以备忘~
