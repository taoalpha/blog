---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day47-js中的时区问题
tags: [Patch]
---

刚刚发现了一个allfeed的一个bug...就是插件中的notification失效了...查了一下就发现是因为时区的原因...因为我的server是放在美国的...所以和中国这边有几个小时的时差...也就导致了我判断是否为更新章节的条件始终都是false的...


{% highlight python %}

var date = new Date('2014-03-25 09:35:31 UTC'); // server time

// Tue Mar 25 2014 17:35:31 GMT+0800 (中国标准时间)


{% endhighlight %}

加上utc后再用date就可以自动把server time转换为本地时间了, 如此就可以和本地时间进行比较了~

bug虽然很小, 但却是体现出了一个很大的问题, 就是随着网络的发展, 世界变的越来越小, 很多以前不需要考虑的问题, 都开始成为bug的来源了, 在此非常矫情的来一句...

时光如梭啊...互联网万岁!
