---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day28-CSS-Tricks(1)
tags: [技巧,CSS,Patch]
---

有几天没用python了...主要是忙于申请和工作的事情,这几天也没有什么需要去折腾了...即便是CustomizeFeeds在基本完成之前预期的递归抓取后就没怎么动了,过两天还是要完善一下的~

这几天又拿起kindle看起了CSS,之前做portfolio也积累了些比较有意思的技巧,分享记录一下~
<ol>
	<li>CSS绘制三角箭头.
因为blog的设计,所以有一个三角箭头来连接左右块,本来计划使用图标的方式,后来碰巧知道了css中border属性的一些特殊用法,就干脆用css写了~其实也很简单:

{% highlight css %}
div {
  width: 0; height: 0;
  border: 100px solid transparent;
  border-top-color: orange;
  border-right-color: purple;
  border-bottom-color: blue;
  border-left-color: yellow; }
/* 核心思想就是整个block的宽高都为0,全部都是border,然后将border的上下左右设置不同的显示;如上机会出现四个三角不同颜色的效果; */
div {
  width: 0; height: 0;
  border: 100px solid transparent;
  border-bottom-color: blue; }
/* 去除其他的只保留一个,就会剩下一个三角~ */
div {
  width: 0; height: 0;
  border-bottom: 100px solid blue;
  border-left: 100px solid transparent;
  border-right: 100px solid transparent; }
/* 而如果通过left和right的属性值,就可以进一步减小无用的空间,如上,就会呈现一个矩形中占据一半空间的三角~ */
/* 当然你完全可以通过调整这两个属性来得到不同的三角 */
{% endhighlight %}

<div style="width: 0; height: 0; border: 100px solid transparent; border-top-color: orange; border-right-color: purple; border-bottom-color: blue; border-left-color: yellow;"></div><p class="wp-caption-text">全彩三角</p>
<div style="width: 0; height: 0; border: 100px solid transparent; border-top-color: orange;"></div><p class="wp-caption-text">下三角(保留上色块)</p>
<div style="width: 0; height: 0; border-bottom: 100px solid blue; border-left: 100px solid transparent; border-right: 100px solid transparent;"></div><p class="wp-caption-text">更省空间的上三角</p>
如上~</li>
	<li>CSS图标集合(CSS Sprites)
CSS Sprites的核心其实就是讲多个图标拼合起来,然后通过background-position等属性来调整显示区域,从而显示对应的图标~如此就可以把把整个网页的图标都做到一个图片中,既便于展示也便于维护~有不少可以用于生成Sprites的网站, 有兴趣的可以去找找看~(不要小看生成这一步~做好了很省事的~可以方便的定位)</li>
</ol>
今天先这些吧~这算是继mysql之后的有一个连载系列哈~
