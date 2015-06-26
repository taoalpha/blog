---
layout: post
category: dandp
description: ''
title: SASS SYNTAX
tags: [HCIBib,译系列,Sass for web designers,Sass,翻译文章]
---

本文继续 "SASS for web designers" 这本书~ 这是续 <a href="http://callmet.zzgary.info/2013/12/16/translation-why-sass/" target="_blank">Why Sass?</a> 这一章的遗漏,全书共分为四章,我会尽量都过一遍~哈

============正文=============

在Sass中实际上是有两种不同的语法的.比较新的一种是之前提到的SCSS语法,SCSS文件会以.scss结尾.这也是我比较倾向的一种语法,理由如下:

<blockquote>
  <ul>
    <li>因为SCSS是基于CSS,是CSS的一个父集, 所以我可以依然按照过去十年写CSS那样写SCSS,而不用担心它不能识别;</li>
	<li>它可以允许你一步步的将现有的css样式转换为sass的结构;</li>
	<li>它不会导致一个很突兀的代码风格转变;</li>
</ul>
</blockquote>

<h5><strong>一个简单的SCSS例子</strong></h5>

如下是一个展示SCSS语法是如何工作的范例, 它定义了一个变量并且在之后的css中使用了这个变量.


{% highlight css %}

$pink: #ea4c89;
p{
font-size: 12px;
color: $pink;
}
p strong{
text-transform: uppercase;
}

{% endhighlight %}

翻译成css则是:

{% highlight css %}

p{
font-size: 12px;
color: #ea4c89;
}
p strong{
text-transform: uppercase;
}

{% endhighlight %}

除了那个$pink变量之外,是不是看起来很熟悉. 本书的后部分我们会详细说说这个变量~

SCSS围绕CSS,而CSS本身你已经非常熟悉了. 也因此, 我非常喜欢SCSS~

<strong>sass原始语法</strong>

sass自身的语法, 从某方面来说, 和SCSS以及css都是完全不一样的. 一些人比较喜欢它直来直去的风格, 没有任何的花括号,分号等, 完全由缩进控制结构的语法.如果你也习惯这种类似ruby或者python的语法形式, 那么SASS的语法你会觉得比较熟悉, 而且你会更加舒适自然.

如果把之前的片段用这种语法表示出来, 就会出现如下的形式:


{% highlight css %}

$pink: #ea4c89
p
	font-size: 12px
	color: $pink

p strong
	text-transform: uppercase

{% endhighlight %}

没有了括号和分号,只剩下一堆的空格和缩进来表示声明和定义. 很明显这更加干净而且简单, 你们中的部分人可能会非常钟情于此. 它可以提升代码的速度, 同时去除那些乱七八糟的东西. 但是对我而言, 我依然更喜欢SCSS, 应为它和正常的css更像, 就如同我之前提到的原因一样.

本书后续的章节里也都会用SCSS语法来做演示. 如果你更喜欢那个干净的Sass语法, 也很容易转换. 而我们所有提到的Sass功能对两者都是适用的. 只是偏好的问题罢了. 

<strong>Sass的误解传言</strong>

我在之前已经提到过这个我最初不愿意尝试sass的原因. 部分归咎于那些大量的传言....(此处同<a href="http://callmet.zzgary.info/2013/12/16/translation-why-sass/" target="_blank">Why Sass?</a> 中的传言部分.)
