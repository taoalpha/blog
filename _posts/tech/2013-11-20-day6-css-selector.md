---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch计划-Day6-CSS的Selector(续)
tags: [CSS Selector,选择器,Patch]
---

本来觉得CSS中可以对标签的属性进行筛选指定就已经很了不起了...没想到随着阅读后面的内容, 竟然带给我这么多惊喜..列举一下:

续前文:
<ul>selector可以有多种方式:</ul>
<ol>
	<li>第一种,也是html中最简单的一种,根据p,div,table等等标签来选择,其中*是作为通配符存在的,即可以用*代指所有的标签,通常是省略的~;</li>
	<li>第二种,根据class属性或者ID属性,区别在于class可以多个tag一个class,而id则只能是1V1的关系, 当然, 实际上browser是不会判断这个的, 你完全可以写多个..只不过这样对之后的js等需要通过id来进行的一些交互或者操作就没办法实现了;</li>
	<li>第三种,就是我新知道的一个,可以通过属性值来筛选,就是比如a标签的href来筛选,a[href]的方式,当然可以结合着key和value一起控制命中范围, 如此在定义样式的时候就会有更大的选择空间了~

{% highlight python %}
a[href="imgstore2.hahah.com"]{
    color:yellow;
/* 必须精确匹配"imgstore2.hahah.com",且只有这个而不是包含的多个属性值"imgstore2.hahah.com  baidu" */
}
{% endhighlight %}

就会把所有href中为"imgstore2.hahah.com"的a标签的颜色设置为黄色~当然,这个=的形式有很多种,比如"~="代表了对多个属性的值中命中一个即可,再比如"^="代表以后面的值作为开头的属性值~"$="代表了以后面值为结尾的~"*="则代表了包含后面值的属性~
说一下"*="和"~="的区别:

{% highlight python %}
a[href="aa bb"]{
color:red;
}
/* 代表了必须是href="aa bb"的a标签颜色标红,同时aa bb的顺序也不能改变.. */
a[href~="aa"]{
color:red;
}
/* 代表href中包含aa这么一个独立属性的a标签标红, 这里的独立代表了aa不能作为某个属性的局部存在...比如href="aass bb"就不会被赋予颜色值*/
a[href*="aa"]{
color:red;
}
/*则表示只要属性值中包含了aa这么个字段就可以了, 比如上例中的href="aass bb"就可以被选择赋予红色了 */
{% endhighlight %}

</li>
</ol>
---------------------------------------此处为前后分界线------------------------------------------------
<ol>
	<li>第四种的selector则是可以根据tag的继承关系来选择,比如:

{% highlight python %}
div p strong a{
backgroung: red;
}
{% endhighlight %}

就代表针对div下的p标签下的strong标签中的a标签的背景色设定为红色, 每个继承关系之间都用空格来表示,一个或者多个都可以;</li>
	<li>selector第五种(是的..我是第一次知道原来selector可以有这么多种...)算是第四种的一种变种或者扩展,因为第四种的继承关系是不限制嵌套深度的,也就是说,只要后者是前者的继承或者子标签, 那么这种定义就是有效的,那如何定义第一继承呢? 就是相当于第一继承人(或者群体)如何指定呢?就可以通过&gt;的符号来帮忙了~
      
{% highlight python %}

div>li{
color:red;
}

{% endhighlight %}

就是指div的第一继承人集团,可以是一个, 也可以是并列的多个~但必须是第一继承的关系,或者说是直属关系才可以.既然有&gt;的符号,那么还有木有更多的符号呢? "+"就是另一个可用在selector的符号了, 而且逻辑相对拗口..指代的是平级标签中,紧挨着指定标签的标签, 比如:h1+p,就是说紧接着h1的p标签,是一个非常精确的选择;
  
{% highlight python %}

h1+p{
color:red;
}

{% endhighlight %}

      此外, 还有一个"~"的符号, 和"+"很接近, 但是匹配更粗一些，　只要follow就可以,不要求紧接着~

{% highlight python %}

h1~p{
color:red;
}

{% endhighlight %}

      就会匹配所有在h1后面的p标签~
</li>
</ol>
