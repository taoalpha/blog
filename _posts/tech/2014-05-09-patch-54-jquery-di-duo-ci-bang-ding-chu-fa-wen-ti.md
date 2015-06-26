---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-54-jQuery的多次绑定/触发问题
tags: [jquery,多次触发,coding,Patch]
---

最近写wordsdiary, 碰到了这个问题, 想来以前应该遇到过, 但是没那么仔细的研究过~

自从上次发现页面加载后插入的html代码, 不能绑定click事件后, 我就习惯用on()来绑定click事件, 于是这次在给click加上了slideDown和slideUp的动作后, 发现在连续添加两个事件元素后, 我一次click的点击竟然产生了2个slideDown和一个slideUp, 顿觉神奇... 于是通过debug发现, 这种情况下我的click竟然触发了三次...(因为是toggle的, 所以会有down/up的循环).

于是通过万能的google, 我终于了解到这种多次触发的问题是很普遍的... 原因在于jQuery的click事件是push而不是重新绑定, 所以就存在了多次绑定的可能, 也就存在了多次触发的可能, 如下图， 节选自jQuery源代码:


{% highlight javascript %}

// Add to the element's handler list, delegates in front
if ( selector ) {
	handlers.splice( handlers.delegateCount++, 0, handleObj );
} else {
	handlers.push( handleObj );
}
// Keep track of which events have ever been used, for event optimization
jQuery.event.global[ type ] = true;

{% endhighlight %}


如此一来, 当我页面上只有一个绑定了click事件的元素时, 我新增一个同样的元素, 就会引发on事件在原有基础上再次对页面上的该元素绑定事件(因为on), 然后就会在原有一个click的情况下再补上2个click(多了一个元素--2个元素). 这样就变成了3次click, 所以一次click操作就会重复出发3次click事件了~~

如何解决呢? jQuery显然考虑了这一点, 因为它给予这些事件的绑定操作都是成对的, 比如: bind(),unbind(), on(), off()~ 这样一来, 就可以比较轻松的绑定事件以及结绑定事件了.

同样用最开始的例子来说明的话, 就是: 我依然因为on事件还是在原有的一次click事件上绑定了2次click事件, 但是因为每次事件绑定的时候都会off一次, 那么就会清楚掉之前的绑定, 将click事件消为0, 这样其实每个元素都只绑定了一个click事件!

哈哈~ 又学到一招啊~~~ 类似的很多事件绑定都有同样的问题, 因为对于jQuery而言, 事件出发都是用的add()函数, 区别只是传递的type不同而已, type就是事件类型~~

Good Night!
