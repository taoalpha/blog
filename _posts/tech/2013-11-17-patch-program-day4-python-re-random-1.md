---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch计划-Day4–Python re&Random(1)
tags: [re,正则匹配,random,随机数,Patch]
---

接着今天模拟renren登陆以及回访率的实验, 我又根据好友统计了一下自己的人脉关系,由于renren用户的隐私设置, 所以非好友关系下不能看到对方的好友(设置了隐私的用户), 所以,主要计算到了二度人脉~按照规则, 主要列举一下今天遇到的问题以及找到的方案~

<ol>
	<li>re部分, 由于要获取好友页数,以及好友的id等, 都需要从url中抽取, 正则这个时候就在此凸显了它的威力, 可以精确的匹配到需要抽取的字段, 用法也非常简单易操作:

{% highlight python %}

import re
ss = "http://www.renren.com/profile?id=12818211&p=2"
p = re.compile('id=(\d+)')
p.findall(ss)
>> ['12818211']

{% endhighlight %}

其中"\d"代表的就是数字, 后面的+则表示一次或者多次的重复前面的字符,本例中即代表:一个或者多个的数字.
</li>
	<li>random,是今天主要用到的第二个python库, 主要是因为最开始遍历的时候发现依次遍历遇到的有效活跃用户非常的少,可参见<a href="http://callmet.zzgary.info/2013/11/17/about-renren-recency-experiments/" target="_blank">回访率研究(1)</a>. 于是尝试改变遍历的方式, 由依次遍历改为随机遍历, 于是用到了random.sample(list,n)的函数,含义就是从list中抽取n个随机的值作为一个新的list返回:

{% highlight python %}

import random
list1 = [1,2,3,4,5,6,6,7]
random.sample(list1,2)
>>[1,4]

{% endhighlight %}


针对没有预先定义的顺序式list而言,可以利用range的方式嵌套进去,比如:random.sample(range(100),2)就是从0-99中随机抽取2个数.在此过程中,发现range是有一个范围的, 超过一定范围后会报MemoryError的错误,这个上限主要会根据32位还是64位有所区别,而如果你要超过上限的使用, 可以使用xrange()函数来替代.
</li>
</ol>
以上.
See You~
