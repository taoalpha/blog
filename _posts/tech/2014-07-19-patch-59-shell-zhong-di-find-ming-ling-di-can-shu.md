---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-59-shell中的find命令的参数
tags: [prune,shell,coding,find,Patch]
---

好久不写shell脚本了... 今天偶然又拾起shell的find命令~ 简单研究了下, 记录如下:

<ul>
<li>
逻辑运算符系列:
  <ol>
  	<li>或关系: "-o", 代表的是or, 或逻辑;</li>
	<li>与关系: "-a", 代表的是and, 与逻辑;</li>
</ol>

</li>
	<li>执行参数系列:
      <ol>
   		<li>名字匹配: "-name", 表示按照文件名匹配, 支持简单正则匹配, 加i=iname, 可以<strong>忽略</strong>大小写敏感度;</li>
	<li>路径匹配: "-path", 表示进一步匹配的路径, 默认是当前目录的, 一般省略;</li>
	<li>忽略路径匹配: "-prune", 表示忽略此路径, 比如:
      
{% highlight python %}

		find ./*
        >> ./2.html
        >> ./kk
        >> ./mm
        >> ./mm/1.html
		find ./* -prune
		>> ./2.html
        >> ./kk
        >> ./mm
		// 即加了prune之后就忽略了子文件夹了~
	
{% endhighlight %}

      </li>
        </ol>


</li>
</ul>

如上, 其实find有很多参数, 不过这里主要介绍下常用的几个, 尤其是prune, 很少见但是很常用哦~

晚安
      
