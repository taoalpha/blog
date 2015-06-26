---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-64-jQuery如何延迟each循环
tags: [jquery,coding,Patch]
---

jQuery的each函数一直是我最喜欢的函数之一~ 只要有需要递归的地方都会用到它~ 不过一直以来都有遇到过一些问题, 比如each中调用一个复杂的函数, 那么很有可能就会出现一些因为each执行顺序过快而出现的问题, 比如下例:

{% highlight javascript %}

	var aSend = [1,2,3,4,5,6];
	var jReceive = {};
	$.each(aSend,function(i,v){
		SavetoJson(v);
	})
	function SavetoJson(v){
		// do something need more time....
		var i = Object.keys(jReceive).length;
		jReceive[i]=v;
	}

{% endhighlight %}

如果SavetoJson函数中有一些比较耗时间的调用, 就会出现于each不同步的情况发生, 从而导致每次执行的时候获取的jReceive的长度都是0, 最终所得结果就有可能是:
jReceive = {0:6} 这么一种情况.

如何破? 延时each即可, setTimeout? 没错~

{% highlight javascript %}

	var aSend = [1,2,3,4,5,6];
	var jReceive = {};
	$.each(aSend,function(i,v){
		setTimeout(function(){
			SavetoJson(v);
		},200);
	})
	function SavetoJson(v){
		// do something need more time....
		var i = Object.keys(jReceive).length;
		jReceive[i]=v;
	}

{% endhighlight %}


没起作用? why?!! 哈,简单, 因为each本身递归速度不考虑的情况下, 这个setTimeout产生的效果就是所有的item都被延迟了200ms而已, 那和不延迟有啥区别呢? 没有... 

正确的做法是:


{% highlight javascript %}

	var aSend = [1,2,3,4,5,6];
	var jReceive = {};
	$.each(aSend,function(i,v){
		setTimeout(function(){
			SavetoJson(v);
		},200*i);
	})

{% endhighlight %}


通过each同时产生的index, 来让item逐次加时! 上述就可以产生每个item相隔200ms执行的效果了~ 第一个item因为index是0, 自然就不延迟执行了~ 后续则会以200ms递加延时~

哈哈~ 赞!
