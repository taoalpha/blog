---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day50-几种有趣的日期展现形式和方法
tags: [date,coding,Sprites,CSS,Patch]
---

很多blog中都有显示博文日期的部分, 这两天正好看到了几个不错的展现形式, 实现方法也各有不同, 所以就记录总结一下~
其中两篇blog都是来自css-tricks, 有兴趣的朋友可以通过结尾的links查看原文.

几篇blog都是写在2010年以前~ 可谓是历史悠久... 不过就实现方案来说, 到今天依然适用而且依然很有新意!

<ol>
    <li>
        <strong>Using Rotation to Group date information</strong>
        <p>这是来自<a href="http://snook.ca/archives/html_and_css/css-text-rotation">snook</a>的一个方法, 原文主要是介绍text rotation(文本旋转)的, 但是正好以日期为例, 所以也算是一个比较通用的方法~</p>
        <p>css中有个属性是transform, 利用transform可以实现一些很好的特效, 比如: rotate, 当然ie的低版本下是不支持这一属性的, 需要使用filter来实现, 因为此法很简单, 所以我就直接上代码啦~</p>
        
{% highlight css %}
-webkit-transform: rotate(-90deg);
-moz-transform: rotate(-90deg);
-o-transform: rotate(-90deg);
-ms-transform: rotate(-90deg);
transform: rotate(-90deg);
filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=3);
{% endhighlight %}

如上就可以在不同的浏览器下实现相同的效果了~
引用原文中的图如下:
<img src="http://snook.ca/technical/text-rotation/text-rotation.png" alt="">
</li>
    <li>
        <strong>Using Sprites</strong>
        <p>Sprite是一个非常赞的东西: 简单来说就是一堆图标的集合, 把零散的图标放在一起然后利用background-position来定位不同的图标. 好处就不多说了, 只是以learningjquery为例, 介绍下sprites实现date的效果, 本例中还是实现和上面的例子一样的效果, 当然, 具体想要什么效果你可以用不同的sprites来设计.</p>
        
{% highlight html %}
<div class="postdate">
  <div class="month m-06">Jun</div>
  <div class="day d-30">30</div>
  <div class="year y-2009">2009</div>
</div>
<!-- 根据布局, 把日期分为三部分: 年月日 -->
{% endhighlight %}

        当然, 上面是固定为2009年6月30号了, 如果你要根据对应的时间来进行设定, 就需要用对应的动态模版来设计了, 可以用js, 也可以用php直接体现~
        
{% highlight css %}
.postdate {
  position: relative;
  width: 50px;
  height: 50px;
  float: left;
}
.month, .day, .year {
  position: absolute;
  text-indent: -1000em;
  background-image: url(http://cdn.css-tricks.com/wp-content/themes/ljq/images/dates.png);
  background-repeat: no-repeat;
}
.month { top: 2px; left: 0; width: 32px; height: 24px;}
.day { top: 25px; left: 0; width: 32px; height: 25px;}
.year { bottom: 0; right: 0; width: 17px; height: 48px;}

.m-01 { background-position: 0 4px;}
.m-02 { background-position: 0 -28px;}
.m-03 { background-position: 0 -57px;}
<!-- ... more like this ... -->

.d-01 { background-position: -50px 0;}
.d-02 { background-position: -50px -31px;}
.d-03 { background-position: -50px -62px;}
<!-- ... more like this ... -->

.y-2006 { background-position: -150px 0;}
.y-2007 { background-position: -150px -50px;}
.y-2008 { background-position: -150px -100px;}
<!-- ... more like this ... -->
        
{% endhighlight %}
  只需要针对sprites把对应的年月日设定到对应的位置就行.
  附上learningjquery所用的sprites  ~
  <img src="http://www.learningjquery.com/wp-content/themes/ljq/images/dates.png" alt="">
    </li>
    <li>
        <strong>Using separate icon</strong>
        <p>此法和sprites接近, 或者说本身也是可以结合着使用~ 不同的是, 在不考虑年的情况下, 只需要12个图标组合即可, 日可以通过文本直接显示, 不废话, 直接上代码吧~</p>
        
{% highlight html %}
<p class="date month8">18</p>
<style>
    p.date {
        width: 42px;
        height: 10px;
        padding: 18px 0 14px 0;
        text-align: center;
    }
    .month1 { background: url(images/cal_01.gif) no-repeat 0 0; }
    /* more like this */
</style>
{% endhighlight %}

        <img src="http://css-tricks.com/wp-content/csstricks-uploads/phase1.png" alt="">
        <p>同样的, 如果需要动态的设定class, 自然就需要用到php或者js了~</p>
        <p>原文中还介绍了如何在此基础上加上云状评论图标的方法, 用同样的办法~ 有兴趣的可以点后面的链接查看~</p>
    </li>
</ol>


<strong>Links</strong>
<ol>
    <li><a href="http://snook.ca/archives/html_and_css/css-text-rotation">TEXT ROTATION WITH CSS</a></li>
    <li><a href="http://css-tricks.com/date-display-with-sprites/">Date Display Technique with Sprites</a></li>
    <li><a href="http://css-tricks.com/date-badges-and-comment-bubbles-for-your-blog/">Date Badges and Comment Bubbles for Your Blog</a></li>
</ol>

