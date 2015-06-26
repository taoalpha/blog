---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day33-CSS中的动态宽高
tags: [动态变化,响应式,CSS,Patch]
---

今天主要说一下通过CSS设置动态宽高的问题, 其实说白了就是个百分比的东西~

对于CSS中长度值的属性而言, 比如width,height,margin,padding, 以及left/top/right/bottom等, 它们的值都支持一种表达形式: percentage(百分比). 顾名思义, 百分比作为一个典型的相对值, 可以说是css动态化的根本所在.

<strong>首先</strong>需要明确的就是百分比这个相对值是相对谁而言的呢? 

==> 母元素, 或者说是其父节点的元素的对应属性; 但同时, 它也遵循position的相应规定, 即如果设定了position的值, 那么对于一个absolute定位的元素, 其参照对象一定是母元素中包含position不等于static的情况, 以此逐层向上, 直到找到position不等于的static的父级节点~而fixed就不管这个了, 只会参照当前屏幕. (<a href="http://callmet.zzgary.info/2013/12/30/patch-day32-css-in-position/" target="_blank">关于CSS的Position</a>)

<strong>其次</strong>, 那如何设置百分比来实现动态变化呢?

==> 既然知道了百分比是相对于母元素而言的, 那么就可以设定对应的长度属性为是和的百分比就可以实现动态变化了~
<div style="position:relative;border:1px solid;width:300px;height:400px;">
  母框: 300px*400px固定;
  <div style="border:1px solid;width:60%;height:50%;margin:10px;">
  子框一: 60%的宽*50%的高;
    <div style="border:1px solid;width:80%;height:60%;margin:10px;">
      子框的子框: 80%的宽,60%的高;以宽为例:相当于最开始母框的300px*60%*80%;
      </div>
  </div>
  <div style="border:1px solid;width:30%;height:20%;margin:10px;">
  子框二: 30%的宽*20%的高;
  </div>
</div>	

{% highlight css %}

<div style="position:relative;border:1px solid;width:300px;height:400px;">
  母框: 300px*400px固定;
  <div style="border:1px solid;width:60%;height:50%;margin:10px;">
  子框一: 60%的宽*50%的高;
    <div style="border:1px solid;width:80%;height:60%;margin:10px;">
      子框的子框: 80%的宽,60%的高;以宽为例:相当于最开始母框的300px*60%*80%;
      </div>
  </div>
  <div style="border:1px solid;width:30%;height:20%;margin:10px;">
  子框二: 30%的宽*20%的高;
  </div>
</div>	

{% endhighlight %}


如上, 这算是最基础的动态, 因为在母框改变的情况子框就会发生对应的改变~ 但是也算不上完全的动态, 因为我们把母框定义的固定了, 如果母框也是百分比会如何呢? 只要定义母框随整个页面级的窗体变化, 那么就可以做到整体的动态变化了, 即简单的响应式了, 如下(调整浏览器窗口就可以看到了效果了~):

<div style="position:relative;border:1px solid;width:50%;height:50%;">
  母框: 300px*400px固定;
  <div style="border:1px solid;width:60%;height:50%;margin:10px;">
  子框一: 60%的宽*50%的高;
    <div style="border:1px solid;width:80%;height:60%;margin:10px;">
      子框的子框: 80%的宽,60%的高;以宽为例:相当于最开始母框的300px*60%*80%;
      </div>
  </div>
  <div style="border:1px solid;width:30%;height:20%;margin:10px;">
  子框二: 30%的宽*20%的高;
  </div>
</div>	


{% highlight css %}

<div style="position:relative;border:1px solid;width:50%;height:50%;">
  母框: 300px*400px固定;
  <div style="border:1px solid;width:60%;height:50%;margin:10px;">
  子框一: 60%的宽*50%的高;
    <div style="border:1px solid;width:80%;height:60%;margin:10px;">
      子框的子框: 80%的宽,60%的高;以宽为例:相当于最开始母框的300px*60%*80%;
      </div>
  </div>
  <div style="border:1px solid;width:30%;height:20%;margin:10px;">
  子框二: 30%的宽*20%的高;
  </div>
</div>		

{% endhighlight %}


<strong>tricks</strong>: 

<ul>
	<li>如何让height跟随宽度而变呢?
  ==> 有童鞋可能注意到, width以及height的百分比相对值都是对应的width和height, 那么对于母元素是body的这种根元素, 如果我不修改浏览器的高度, height的百分比设定就会成为定值~ 那如果你又需要让高度随着浏览器的宽度减小也相应减小的话, 肿么办呢? 

{% highlight css %}

// 用js~ 这是比较容易就能想到的一个方法~
// 不过这一次我们只用css来实现, 该如何做呢?
<div style="position:relative;border:1px solid;width:50%;height:50%;">
  母框: 300px*400px固定;
  <div style="border:1px solid;width:60%;padding-bottom:50%;margin:10px;">
  </div>
  <div style="border:1px solid;width:30%;height:20%;margin:10px;">
  设定height的时候,变化浏览器窗口-高度不变
  </div>
</div>	
还是用这个示意:(如果你去除padding就会发现它变成一条线了)

{% endhighlight %}

<div style="position:relative;border:1px solid;width:50%;height:50%;">
  母框: 300px*400px固定;
  <div style="border:1px solid;width:60%;padding-bottom:50%;margin:10px;">
  </div>
  <div style="border:1px solid;width:30%;height:20%;margin:10px;">
 	设定height的时候,变化浏览器窗口-高度不变
  </div>
</div>	
   其实原理非常简单, 了解box-model后就会发现很顺理成章了~ padding-border-margin, 所以padding会被计算在border内~
  </li>
</ul>



