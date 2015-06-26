---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch计划-Day7-CSS的Specificity以及Cascade问题
tags: [Cascade,Specificity,Selector,CSS,Patch]
---

继续说CSS的问题,之前谈到了CSS的Selector的几种情况, 今天补充余下的几个, 顺带说一下Selector之后的这些属性定义是如何生效的. 

- 续Selector:
	- 除了[上篇文章](http://callmet.zzgary.info/2013/11/20/869/)中说到的那些外,还有一种方式为Pseudo-Elements:
					
{% highlight css %}
p:first-line{
  font-weight: bold;
	font-size: 1.2em;
}
{% endhighlight %}

    如上就会匹配到p标签的第一行~像这种first-line的属性其实是默认在浏览器渲染页面的时候自动加入的,就相当于渲染时候自动给第一行加上了<class="first-line">的属性.类似的PseudoElement还有:first-letter,first-word,使用同理.
  - 除了PseudoElement以外, 还有一些Pseudo-Classes的属性:

{% highlight css %}
a:link{color:red;}
a:visited{color:maroon;}
a:hover{color:yellow;}
a:active{color:blue;}
{% endhighlight %}
		这些都属于link的Pseudo-Class,和Elements是一样的, 都是由浏览器渲染预定义的~类似的还有:first-child,lang,first-of-type,nth-child(x),only-of-type,only-child等等~有兴趣的可以自行了解一下~
	- google的时候在tutsplus上看到一篇很详细有demo的文章,推荐阅读~[The 30 CSS Selectors you Must Memorize](http://net.tutsplus.com/tutorials/html-css-techniques/the-30-css-selectors-you-must-memorize)
- 了解了Selector之后, 有一个一直以来都困惑我的问题就是,那么复杂的css文件, 究竟是按照什么样的顺序来渲染呢?如果重复定义了该如何办呢? 于是有了Specificity以及Cascade.
	- Specificity很好理解,感觉就像是每个css定义都有一个计算公式从而得出一个得分,以此来比较决定使用什么~ 计算方式就是根据Selector中元素的属性:偷个懒就直接引用了~
  > Start at 0, add 1000 for style attribute, add 100 for each ID, add 10 for each attribute, class or pseudo-class, add 1 for each element name or pseudo-element.

  直观的了解一下就是:
				
{% highlight css %}
*{color:red;} /* 0,0,0,0 */
li{color:red;} /* 0,0,0,1 */
li:first-line{} /* 0,0,0,2 (1+1)*/
.hi{} /* 0,0,1,0 (10)*/
#hi{} /* 0,1,0,0 (100)*/
body #ss li{} /* 0,1,0,2 (1+100+1)*/
{% endhighlight %}
	如此针对重复定义的元素,就可以通过比较specificity来决定哪个生效了~

- 关于Specificity还有一些特殊的地方~</li>
	- 首先就是,+1000的style attribute是什么意思? 其实这个是属于标签内置的style属性来定义的样式,这种情况下是+1000的~</li>
	- `!important`是可以跳出此排序的~如果你在某个属性的最后面加上!important,那么它会立刻升到排序的最前面~相当于VIP待遇~</li>
	- 全局通配符是0分,inherent的属性是没有得分的, 所以如果是下述情况:
					
{% highlight css %}
* {color:red;}
p{color:black;}
/*
<p>这里是黑色<em>这里是红色</em>又是黑色</p>
*/
{% endhighlight %}
	即em标签会因为通配符得0分而比p的继承无得分分高~0>null</li>
关于Specificity有一篇不错的文章,大家也可以去看看: [CSS Specificity: Things You Should Know](http://coding.smashingmagazine.com/2007/07/27/css-specificity-things-you-should-know/)

那如果得分也一样了呢? 就要靠cascade来区分了~

规则也相对简单,同级得分下,按照先后顺序,越靠后越有优势~
其中!important标记的会跳出此序列~对于author,reader以及user-agent而言,也是一样的:
              
{% highlight css %}

reader important > author important > author normal > reader normal > user agent.

{% endhighlight %}

此外, import获得的css都会排在当前文档的css之前,即认为当前的css权重更高一些~
