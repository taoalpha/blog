---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch计划-Day6-Python-Time以及CSS的问题
tags: [python,Time,CSS,Patch]
---

这几天在看CSS:The Definitive Guide,虽然只看了开头, 不过确实有一些新东西值得记录分享下~
不过还是先说一下python中time的问题:(主要参考<a href="http://www.cyberciti.biz/faq/howto-get-current-date-time-in-python/" target="_blank">此篇文章</a>)如何获得当前时间?
<ol>
	<li>

{% highlight css %}
time.strftime(format)
## 24 hour format ##
time.strftime("%H:%M:%S")
## 12 hour format ##
time.strftime("%I:%M:%S")
{% endhighlight %}

所有的format格式都可以自定义, 如果想要显示年月日,也可以用"%d/%m/%Y"来表示, 如此只需要改变format就可以调整你要输出的结果了~像分隔符呀, 顺序呀都可以调整的~
有没有更简单的方式呢?有:

{% highlight css %}
now = time.strftime("%c")
## date and time representation
&gt;&gt; Sat Oct  5 00:04:59 2013
now = time.strftime("%x")
## Only date representation
&gt;&gt; 11/20/13
now = time.strftime("%X")
## Only time representation
&gt;&gt; 13:04:59
{% endhighlight %}

关于这个format的格式和各种符号的代称都可以在原文或者google上查到~大家有兴趣的可以看看, 不过直到以上的基本也就够用了.</li>
	<li>除了time,还有什么可以用来获得时间呢? datetime,这是一个更为复杂而且更加强大的时间函数库, 里面有更多的功能和更丰富的函数~但也相对更加复杂,比如:

{% highlight css %}
now = datetime.datetime.now()
now.hour
now.mintue
now.year
now.day
now.month
{% endhighlight %}

通过上述方式, 你可以把时间拆分到各个单元, 我在做<a href="http://zzgary.info/funstuff/deathclock/" target="_blank">deathclock</a>的时候就用的js中的此类方式处理的时间~当然,作为一个比time更加强大的库, 它也有类似time的方式来获取定义格式的时间:

{% highlight css %}
date.strftime(format)
## 这里的format和time基本是一模一样的
{% endhighlight %}

</li>
	<li>接下来说一下CSS的部分: 第一章的内容很简单, 是将css的结构和selector(选择器)和grouping(组合)的, 本来只是为练练英语而看下去, 结果发现了不少自己并不知晓的新东西~特此分享:
<ul>selector可以有多种方式:
	<li>html的tag算是最简单的一种p,div,table等等,其中*是作为通配符存在的,即可以用*代指所有的标签,通常是省略的~;</li>
	<li>class属性或者ID属性,区别在于class可以多个tag一个class,而id则只能是1V1的关系, 当然, 实际上browser是不会判断这个的, 你完全可以写多个..只不过这样对之后的js等需要通过id来进行的一些交互或者操作就没办法实现了;</li>
	<li>除此之外, 第三种就是我新知道的一个,可以通过属性值来筛选,就是比如a标签的href来筛选,a[href]的方式,当然可以结合着key和value一起控制命中范围, 如此在定义样式的时候就会有更大的选择空间了~</li>
</ul>
</li>
</ol>
