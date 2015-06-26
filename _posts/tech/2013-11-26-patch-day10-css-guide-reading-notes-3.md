---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day10-CSS Guide读书笔记(3)
tags: [颜色,Color,Patch,Lengths,尺寸,CSS]
---

今天记录下CSS下颜色和尺度的几种表示方式~
<ol>
	<li>首先是颜色部分,总共有三种表示方式:Name,RGB,16进制数.
<ul>
	<li>Name:这是最通用的一种, 也是相对而言最友好,最容易记忆和使用的一种,但适用范围也相对最为狭窄...因为standard colors总共是17个,只是多数浏览器识别支持到了140(or147)种, 想要了解的童鞋可以看看这两个网站~都非常棒~<a title="147Colors" href="http://www.colors.commutercreative.com/grid/" target="_blank">147 Colors</a> ||<a title="CSS Colors" href="http://www.crockford.com/wrrrld/color.html" target="_blank"> CSS Colors</a></li>
	<li>RGB:这是最接近理论的一种,因为电子屏幕的显色原理就是三原色的混合,所以通过控制RGB三种颜色的成分比例就可以得到几乎所有想要的颜色了,每个色值都可以用两种形式表示:百分数or0-255的数值;这种方式覆盖到的颜色范围远超name,但是也相对很难记忆和使用,真实的设计师也只会记忆一些相对常见的颜色值,再对其进行微调~百分数和数字是可以互转的~含义一致;</li>
	<li>16进制数:这和RGB其实是一样的,只是把0-255换成了16进制表示而已,用法是#000000就是白色,其中#后的6个数字分为三组,每组两位,从00-ff代表了0-255~和RGB的两种表示方式可以相互转换~此外,16进制的方法支持简化表达, 比如#888就代表的是#888888,即可以用3位数去表达,但是这三位相当于是6位,只不过每一个色值都是重复的数字而已~</li>
</ul>
</li>
	<li>和颜色不同,尺度上的表达就复杂很多了...现分为Absolute和Relative两种,每一种又包含很多不同的方式...以下主要针对常用的几部分做简单的总结:</li>
<ul>
	<li>Absolute:顾名思义,这种表示方法是基于国际惯例或者常规的物理尺寸的,不会因为展示介质的变化而变化, 比如:inch,美国多用,cm(centermeters),mm(millimeter),pt(points),pc(picas)前三个都比较常见,后面两个则是继承自印刷业的尺度,其中1inch=72points,1pc=12points;知道这些也就够了~</li>

	<li>Relative:与Absolute相对,Relative的衡量就会和介质以及其他因素相关了,比如em,意思是当前字体的尺寸,比如:

{% highlight css %}

<p style="margin-left: 1em; font-size: 19px;">ssss</p>

{% endhighlight %}

就会让p的文本和左侧边界距离1em,而针对19px的字体,那么1em此刻就等同于19px;如果此刻换一个字体大小,那么1em也会相应变化,甚至不同元素的同样的1em,也会因为字体大小的不同而有所变化;此外还有ex,则是代表了当前字体小写的x的高度,通常约等于0.5em,不过目前很多浏览器开始计算ex而不是直接将ex和0.5em划等号~最而最常见的Relative表示就是px了,而这个主要和当前显示器的分辨率有关,不同的显示器px的含义也就不同~值得一提的是针对印刷或者一些其他屏幕,那么就会有一个默认的分辨率设定,即认为是96ppi的情况下计算px~(<a href="http://reference.sitepoint.com/css/lengthunits" target="_blank">进一步阅读</a>)</li>
</ul>
</ol>
