---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day22-jQuery的自动跟随
tags: [jquery,跟随滚动,Patch]
---

今天算是把dailyinfo彻底完善了一下, 调整了editbox的位置和状态,主要的放大缩小功能突出,编辑功能则弱化隐藏了~而为了更好的让放大缩小服务阅读者,最好是希望能够跟随页面滚动,于是就用了如下的代码:


{% highlight javascript %}

$(window).scroll(function(){
if($(window).scrollTop()>$('#editbox').offset().top){
$('#editbox').stop().animate({
marginTop:$(window).scrollTop()-$('#editbox').offset().top + 150});}
else {
$('#editbox').stop().animate({marginTop:0});
}
});

{% endhighlight %}

其实很简单,主要是用到了scroll的函数,确保在屏幕滚动的情况下来动态计算偏移量,如此就可以保证你要指定的模块始终都是跟随窗口的了~
