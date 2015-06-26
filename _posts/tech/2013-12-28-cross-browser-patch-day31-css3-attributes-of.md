---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day31-CSS3的跨浏览器属性
tags: [CSS3,跨浏览器,vendor-prefixes,Patch]
---

今天主要说下跨浏览器的问题~ 当然因为我自己其实也只知道个皮毛, 所以也谈不上介绍, 只是把我google到的一些东西整理了一下列在这里~

<ol>
	<li><strong>Q1. CSS中时如何支持跨浏览器属性的?</strong>
A1. 在CSS中可以通过一些前缀符来针对特定浏览器类型进行属性的设置, 对应关系如下:

{% highlight python %}

-webkit-: Chrome,Safari以及以webkit作为内核的浏览器;
-ms-: IE,主要针对IE6-IE9, 很多属性在IE10以及以上的时候都开始支持不加前缀的定义了;
-o-: Opera~
-moz-: 针对Mozilla的firefox;

{% endhighlight %}
</li>


	<li><strong>Q2. 如何定义这些属性?</strong>
A2. 举个简单例子就可以了:

{% highlight python %}

     background: linear-gradient(to bottom, rgba(41, 49, 88, 1)    
 0%, rgba(45, 46, 48, 1) 100%); /* 正常的; */
     background: -webkit-linear-gradient(top, rgba(41, 49, 88, 1)  
 0%, rgba(45, 46, 48, 1) 100%); /* webkit的 */
     background: -moz-linear-gradient(top, rgba(41, 49, 88, 1) 0%,
 rgba(45, 46, 48, 1) 100%); /* mozilla */
     background: -o-linear-gradient(top, rgba(41, 49, 88, 1) 0%,
 rgba(45, 46, 48, 1) 100%); /* opera */
     background: -ms-linear-gradient(top, rgba(41, 49, 88, 1) 0%,
 rgba(45, 46, 48, 1) 100%); /* IE */
     filter: progid:DXImageTransform.Microsoft.    
 gradient(GradientType=0,startColorstr='#293158',    
 endColorstr='#2D2E30'); /* For IE6 &amp; IE7 */
	zoom:1; /* 有时候IE需要设定zoom或者height才能展现渐变效果; */
/* 这里的filter是针对IE的一个滤镜~也是针对渐变起作用的, 必须有...

{% endhighlight %}

</li>

	<li><strong>Q3. 每次都需要输入这么多吗?</strong>
A3. 是的...不过有几种方法可以简化此过程:
      <ul>
      	<li><a href="http://prefixr.com/index.php" target="_blank">prefixr</a>
          一个非常简洁的在线补充prefix的工具, 你只需要把你所写的正常的普通代码贴入其中, 然后prefixize一下, 就能生成对应加好前缀的属性了~ 算是最方便最懒散的一种行为了.</li>
        <li>Sass的mixin(或者less等也可以)
        通过定义一个mixin或者用现成的framework(比如compass)中的mixin, 就可以让你省掉无数的工作量(有兴趣了解sass的可以看之前翻译的一本<a href="http://callmet.zzgary.info/tag/sass-for-web-designers/" title="sass-for-web-designers" target="_blank">介绍sass的小书</a>);</li>
        <li><a href="http://leaverou.github.com/prefixfree/" target="_blank">-prefix-free</a>
        这是一个非常有用的小工具, 是一段js代码, 可以帮助你自动添加合适的前缀, 而你完全不需要去关心它是如何实现的~ 而且最为强大的就是它是在服务器载入的时候用js生成的css代码, 所以你的css代码完全可以变的更小了(没了那么多重复的代码块)~</li>
        <li>jQuery
        因为jQuery的.css()函数也会自动的帮你添加跨浏览属性, 所以你只需要在其中定义正常的属性, 也算是省了很多事情, 不过这样一来就需要你在js中去添加css代码, 也是比较恶心的...而且不利于维护css样式本身;</li>
        <li>手写...
        这算是最为困难的一个选择, 毕竟这个确实挺恶心的...但是对于真正掌握跨浏览器的css属性而言是一个比较好的方式, 当然你完全可以结合着sass来操作, 既可以掌握又可以节省时间, 还能为形成你自己的framework做出贡献~ 何乐而不为呢~ 另分享一个学习体验css3中跨浏览器属性的站点: <a href="http://css3please.com/" target="_blank">CSS3Please</a></li>
        </ul>
	</li>
</ol>

如上, 基本上针对跨浏览器的设置而言, 没有什么特别新的东西, 都是旧有css知识的另一种展现形式, 但是在webkit或者ff统一世界之前, 这又是非常必要的...至于ie....还是回家找你妈吧...
