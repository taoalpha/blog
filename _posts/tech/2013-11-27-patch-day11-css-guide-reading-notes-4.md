---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day11-CSS Guide读书笔记(4)
tags: [字体,CSS,Patch]
---

今天说font-family的问题,本来觉得没啥可讲的,细看了下才知道自己理解的一直都是错的...于是乎...囧了..

首先是语法(Syntax):

{% highlight css %}
Formal syntax: [ <family-name> | <generic-family> ]# 

{% endhighlight %}

其中family-name指的是值得是一个font的名字,比如Times,Helvetica就代表了一种字体,如果名字中包含空格,则需要加上引号;
而generic-name则相对而言是一种应急机制,是当所有指定的字体都不存在时,generic-name就会启用了,且如果中间有空格也不加引号~所以一般generic-name都是放在font-family的属性最后的;


{% highlight css %}

font-family: "Gill Sans Extrabold", Helvetica, sans-serif;
font-family: "Goudy Bookletter 1911", sans-serif;

{% endhighlight %}

如上,其中sans-serif就是个典型的generic-name,其内可能包含很多字体,共同组成了一个字体系列,而目前字体的系别而言,常用的总共有五个generic-name:
<ul>
	<li>serif: 衬线字体族,特点是:末端加粗,扩展或者尖细末端,或以实际的衬线结尾的一类字体;一般情况下,当字体小的时候,serif的辨认性还是可以保证的;</li>

	<li>sans-serif: 无衬线字体族,特点是:字体比较圆滑,线条粗线均匀,适合做艺术字,标题等,与serif相比,当字体较小的时候就会比较难以辨认了;</li>

	<li>monospace: 等宽字体族,因为英文字母不等宽,所以不能像中文一样来排版,但是如果用这个字体的话,就可以像中文一样布局了, 但是也更容易出现语义饱和的现象,就是Semantic satiation,看一个汉字看久了就越来越陌生了的现象;</li>

	<li>cursive: 手写字体族,特点是:和手写的一样~</li>

	<li>fantasy: 梦幻字体族,主要用于图片之中,看起来比较艺术~很少用在网页中的~</li>
</ul>

以前一直把sans-serif也当成一种字体来理解了,才知道原来这是一类的概念~具体针对五类字系常见的字体,大家可以自行google了解~
