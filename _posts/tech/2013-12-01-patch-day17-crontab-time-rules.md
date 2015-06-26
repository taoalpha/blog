---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day17-crontab的时间规则
tags: [crontab,Patch]
---

这几天为了积攒数据,一致把脚本定时启动,建了一个每个2小时跑一次的crontab,于是乘此机会总结一下整个crontab的时间规则~


{% highlight python %}

shell>> * * * * * /command path
##前五个＊号都是代表时间的，后面的则是需要执行的命令

{% endhighlight %}

上述是标准的crontab记录,通过crontab -e建立新的crontab任务,最重要的就是如何设置启动时间?

今天主要是下前面这五个＊号的问题：

{% highlight python %}

* 			* 			* 			* 			*
分钟(0-59)  小时(1-23)	日期(1-31)   月份(1-12)	 星期(0-6)
====
其中星期中0代表的是周日;
====
特殊符号:
*==表示任何时刻;
,==表示分割;
-==表示一段时间;
/n==表示每隔n个时间段;

{% endhighlight %}

如上,说的很清楚,通过指定五个时间段就可以决定crontab的运行规律和周期了~
比如,我们需要每隔两个小时跑一次某个脚本:

{% highlight python %}

shell>> * */2 * * * /command path

{% endhighlight %}

如此即可~
