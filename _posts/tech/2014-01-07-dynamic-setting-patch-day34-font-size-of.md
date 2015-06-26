---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day34-font-size的动态设定
tags: [vw,字体,CSS,Patch]
---

这两天因为一直在尝试做一个响应式的作品集, 其中如果不想在每个节点都去设置font-size的话, 就需要对font-size进行动态的设定~ 可能有人之前看过前一篇patch: <a href="callmet.zzgary.info/2014/01/03/patch-day33-css-dynamic-width-and-height/" target="_blank">CSS中动态宽高的布局</a> 说到了用percentage来实现动态长度值的设置, 而字体也是支持百分比的值的~ 所以完全也可以用白分比来设定~ 但是字体还有一个非常好的相对值, 就是vw, viewport width~ 视窗大小, 这可以让你针对当前元素的视窗来决定其字体的大小~ 更加灵活~

值得说的一点就是vw是在css3引入的~ 所以css3之前是没有这个属性的~~

以下部分主要摘译自css-tricks的这一篇文章:<a href="http://css-tricks.com/viewport-sized-typography/" target="_blank">Viewport Sized Typography</a>

<strong>首先需要说明一点, vw,vh,vmin等属性都是长度属性值, 不局限于font属性~ 不要被本文标题误导...</strong>

至于为什么用vw,vh,vmin等, 就不用多说了...

怎么用?

1vw = 1% of viewport width
1vh = 1% of viewport height
1vmin = 1vw or 1vh, whichever is smaller
1vmax = 1vw or 1vh, whichever is larger

viewport通常是指当前窗口的尺寸~ 除非做一些特别的指定~

特殊点:

用过vw和vh等属性的人, 就会知道当我们伸缩窗口的时候设定这类属性的值并不会发生变化~ 而只有刷新才会发生相应的变化, 这是因为vw等属性都是基于viewport的, 所以只会在页面载入的时候绘制, 如何解决?

有一个非常取巧的方法, 就是利用z-index属性的设置会导致重新绘制布局:

{% highlight css %}

causeRepaintsOn = $("h1, h2, h3, p");

$(window).resize(function() {
  causeRepaintsOn.css("z-index", 1);
});

{% endhighlight %}

如此就会导致你每次resize窗口的时候也vw等属性都会自动重新计算~ 当然前提是你需要把赋予了vw等属性的元素都包含在causeRepaintsOn的变量之中去~
