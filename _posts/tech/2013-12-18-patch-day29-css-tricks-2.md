---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day29-CSS-Tricks(2)
tags: [clear,float,CSS,Patch]
---

这一次主要说float和clear~ 主要结合<a href="http://css-tricks.com/all-about-floats/" title="all-about-floats" target="_blank">这篇文章</a>来说~

float属性是一个很神奇的属性,基本上网站的布局正是有了它才变得更灵活,才有了现在这些多样的形式和布局.

但是float也很难用, 什么时候改用, 什么时候又要消除float的影响, 都是float比较烦人的地方~ 这一次结合这篇文章, 就简单用示例的形式说一下float~

需要注明的是, 因为wordpress本身会默认margin,padding为0, 所以为了达到同样的效果, 我只能调整了margin的属性, 但是本身clear的功能还是可以演示的~大家忽略div中margin的部分就行~

正常网页的布局一般是如下的形式:
<div style="border:1px solid;width:90%;height:100px">
  <div style="border:1px solid;height:20px;margin: 10px 10px 0 10px;"> <p style="">Header</p>
  </div>
    <div style="border:1px solid;width:13%;height:25px;float:left;margin: 10px 0 0 10px;"> <p style="">SideBar</p>
  </div>
    <div style="border:1px solid;width:80%;height:25px;float:right;margin: 10px 10px 0 10px;"> <p style="">Main Content</p>
  </div>
    <div style="border:1px solid;height:20px;margin: 40px 10px 0 10px;"> <p style="">Footer</p>
  </div>
</div>

其中siderbar和Main content两部分就分别利用float属性而呈现左右布局.

float的属性会保证在float区域大小调整后剩余区域自动重新布局,如此就比单纯的margin或者padding更加方便可维护了.

那clear又是什么东西呢? 顾名思义,就是清除, 清除某个方向的float. 什么意思呢? 在具体上示例之前, 先简单解释下:

当某个元素使用float属性后,其本身就已经脱离文档结构了, 所以在上述例子中, 如果没有给footer一个40px的margin-top,它一定会紧挨着header而不是siderbar和maincontent,这是因为sidebar和main content部分已经脱离了文档的布局, 从而使得footer在计算margin时直接和上一个文档元素---header--来计算了, 所以需要更多的margin-top才能让footer有一个合适的位置~

那么不用clear是如何做的呢? clear的存在会让其制定方向的float元素再次成为文档的一部分.

<div style="border:1px solid;width:90%;height:100px">
  <div style="border:1px solid;height:20px;margin: 10px 10px 0 10px;"> <p style="">Header</p>
  </div>
    <div style="border:1px solid;width:13%;height:25px;float:left;margin: 10px 0 0 10px;"> <p style="">SideBar</p>
  </div>
    <div style="border:1px solid;width:80%;height:25px;float:right;margin: 10px 10px 0 10px;"> <p style="">Main Content</p>
  </div>
    <div style="border:1px solid;height:20px;clear: both;margin-left: 10px;margin-right: 10px;"> <p style="">Footer--without(margin-top)</p>
  </div>
</div>
看起来似乎没啥区别,其实这一次完全没有用任何margin-top属性来调整footer的布局了~对比一下就知道了~下面是没用clear的情况, 会发现footer的框上移到header的下方, 和siderbar都重叠了~(至于文字没有变化,是因为文字单独用p标签,所以没有和div的行为一致):
<div style="border:1px solid;width:90%;height:100px">
  <div style="border:1px solid;height:20px;margin: 10px 10px 0 10px;"> <p style="">Header</p>
  </div>
    <div style="border:1px solid;width:13%;height:25px;float:left;margin: 10px 0 0 10px;"> <p style="">SideBar</p>
  </div>
    <div style="border:1px solid;width:80%;height:25px;float:right;margin: 10px 10px 0 10px;"> <p style="">Main Content</p>
  </div>
<div style="border:1px solid red;height:20px;margin-left: 10px;margin-right: 10px;"> <p style="">Footer--without clear</p>
  </div>
</div>
还有一个例子是:
<div style="border:1px solid;width:48%;height:120px">
  <div style="border:20px solid red;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
  <div style="border:20px solid red;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid red;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid red;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px;">  </div>
    <div style="border:20px solid blue;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid blue;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid blue;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid blue;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>  
  <div style="border:20px solid yellow;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid yellow;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px;">  </div>
    <div style="border:20px solid yellow;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>  
  <div style="border:20px solid yellow;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
</div>
如果想要把上述的色块按照颜色归组,每个颜色一排,就可以在每一个色块其实的时候加上clear:both;或者clear:left;如下(这里调整了最外围的div的高度来保证包含全部色块):
<div style="border:1px solid;width:48%;height:160px">
  <div style="border:20px solid red;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
  <div style="border:20px solid red;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid red;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid red;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px;">  </div>
    <div style="border:20px solid blue;clear:both;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid blue;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid blue;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid blue;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>  
  <div style="border:20px solid yellow;clear:left;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
    <div style="border:20px solid yellow;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px;">  </div>
    <div style="border:20px solid yellow;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>  
  <div style="border:20px solid yellow;width:0px;height:0px;float:left;margin-left:10px;margin-top:10px">  </div>
</div>

clear接受共计五个不同的属性值,分别是both,left,right,None(default),Inherit;其中both是监管了left和right,而left和right则是分别和float的属性值对应~清除的时候也是对应清除即可,比如上述就用left而不是right~

其实clear和float还有一些别的用法和技巧,但我觉得其实掌握这个就足够了~基本遇到类似的问题都可以解决了~
