category: dandp
description: ''
date: 2013-12-23 3:00:00
title: USING SASS–Chapter 3--续
tags: [HCIBib,extend,译系列,mixins,Sass for web designers,翻译文章,import]
---

续前篇(CSS3 Loves Mixins)
<strong>Border-radius</strong>
在CSS3中,对圆角的处理方式为:

``` css

@mixin rounded($radius){
	-webkit-border-radius:$radius;
	-moz-border-radius:$radius;
	border-radius:$radius;
}

```

通过调用此mixin,就可以实现将任何元素变成圆角~范例略(这里传递的参数是半径长度值:3px).
对应的编译(略)

<strong>Border-shadow</strong>

一下是另一个使用多参数的例子: 一个用来创建下投阴影的CSS3片段,可以让我们传递对应阴影的横向和纵向位置参数,以及模糊的程度以及颜色值:

``` css

@mixin shadow( $x,$y, $blur, $color){
	-webkit-box-shadow: $x $y $blur $color;
	-moz-box-shadow: $x $y $blur $color;
	box-shadow: $x $y $blur $color;
}

```


将此模块添加到某个元素属性中, 就可以产生对应的阴影了~(示例代码和编译后代码都省略)

不需要再重复的写这些凡人的代码段. 你只需要写一次, 就可以在任何地方使用它了.

<strong>CSS3 Gradients</strong>

CSS3的渐变语法是非常恶心的.它还会因为浏览器的不同而不同..难记,而且已经更新了不少地方,不少作者都不得不更新他们的样式来适应最新的版本. 也因为所有这些理由, Sass,尤其是其中的mixin部分, 就让使用css的渐变变成可以接受的了, 同时还能作为未来版本的根基~ 我们只需要修改这个mixin,就可以更新全部了.

比如, 我们给一个激活的tab加一个渐变的样式. 为了确保渐变对多数浏览器是可以工作的, 而如果遇到不能正常渲染的浏览器, 则需要转换为单一色,我们将会需要一个相对复杂的属性:


``` css

header nav[role="navigation"] ul{
	li.active a{
		padding: 4px 8px;
		color: #fff;
		-webkit-border-radius: 4px;
			-moz-border-radius: 4px;
				border-radius: 4px;
		background-color:#d42a78;
	background-image:-moz-linear-gradient(#ff70b1,#d42a78);// for mozilla firefox
	background-image: -o-linear-gradient(#ff70b1,#d42a78); // for opera
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #ff70b1), color-stop(1,#d42a78)); // webkit chrome 10 &amp; safari
	background-image: -webkit-linear-gradient(#ff70b1, #d42a78); // webkit chrome 11+
	background-image: -ms-linear-gradient(#ff70b1, #d42a78); // IE 10
	background-image: linear-gradient(#ff70b1, #d42a78); // W3C
}

```

可以看到所有的用法都是两个颜色值的传递, 来实现从上到下的颜色渐变, 通过使用Sass的mixin,我们可以让这个环节变的简单, 通过把渐变色设计为变量来传递到给mixin. 不然谁能记住这么多的情况...人生如此艰难,我们就自己给自己行些方便吧...

首先, 我们可以创建一个mixin叫linear-gradient, 接受2个16进制的颜色值, 分别为$from,$to.

``` css

@mixin linear-gradient($from,$to){
	background-color:$to;
// 这里把$to的颜色作为不支持渐变色的浏览器中的背景色;
	background-image:-moz-linear-gradient($from,$to);// for mozilla firefox
	background-image: -o-linear-gradient($from,$to); // for opera
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, $from), color-stop(1,$to)); // webkit chrome 10 &amp; safari
	background-image: -webkit-linear-gradient($from,$to); // webkit chrome 11+
	background-image: -ms-linear-gradient($from,$to); // IE 10
	background-image: linear-gradient($from,$to); // W3C
}
header nav[role="navigation"] ul{
	li.active a{
		padding: 4px 8px;
		color: #fff;
		@include linear-gradient(#ff70b1,#d42a78);
}

```

这不只是可重复了~这才应该是CSS应该的用法...就好像是用英语直接描述的那么自然. 而且我还能复用此模式, 只需要按照需要修改传递的颜色值.

就如你所知道的那样, linear gradient只是其中的一个例子,css gradients包含了非常复杂的用法, 比如color stops, radial gradients, multiple directions等等.Sass同样可以应用于那些场景, 把任何重复性的模块都抽取为一个mixin.

<h3><strong>创建一个Mixin的库</strong></h3>
mixins因为它们一次写完多次使用的特型而非常优秀. 但是很多时候这些mixins其实是跨项目的, 可以在多个项目中使用. 你可能会发现自己更乐意为整个CSS3的一些诸如box-shadow,gradients,css transitions以及floats(是否清除clear),box-sizing,表元素等来写mixin. 而不只是为某个项目. 这样难道不是更加有效吗?

<h5><strong>@import</strong></h5>
@import规则是Sass扩展到允许多个SCSS文件的导入的一个功能, 可以把多个scss文件合并成一个css文件编译出来. 这有很多非常实际的原因:
	一个css文件代表了更少的网络连接, 展现方面有好处.
	变量可以定义在一个文件中,然后在需要的时候导入,而不用考虑层级关系或者其他页面样式.
	导入的Scss文件可以包含整个项目可能用到的所有mixins.
一下介绍一下@import是如何使用的.
我这里有一个mixins.scss文件, 它会在我整个项目中重复引用. 在这个文件中,我定义了我在每个项目中可能会重复使用的一些常规模式. 比如:

``` css

@mixin rounded($radius){
	-webkit-border-radius:$radius;
	-moz-border-radius:$radius;
	border-radius:$radius;
}
@mixin linear-gradient($from,$to){
	background-color:$to;
// 这里把$to的颜色作为不支持渐变色的浏览器中的背景色;
	background-image:-moz-linear-gradient($from,$to);// for mozilla firefox
	background-image: -o-linear-gradient($from,$to); // for opera
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, $from), color-stop(1,$to)); // webkit chrome 10 &amp; safari
	background-image: -webkit-linear-gradient($from,$to); // webkit chrome 11+
	background-image: -ms-linear-gradient($from,$to); // IE 10
	background-image: linear-gradient($from,$to); // W3C
}
@mixin shadow( $x,$y, $blur, $color){
	-webkit-box-shadow: $x $y $blur $color;
	-moz-box-shadow: $x $y $blur $color;
	box-shadow: $x $y $blur $color;
}
...

```

在我的主文件中,就是包含所有层级信息等样式的文件中, 我引入此scss文件, 就可以让所有定义好的mixins生效, 同时我还import一个变量规则, 来让所有的变量定义生效. 这就允许我在其他文件中同样适用这些变量, 比如在同一个项目的别的页面或者环节, 就可以不用再重复包含层级信息了(?).


``` css

@import "reset.scss";
@import "variables.scss";
@import "mixins.scss";

// Site-specific styles
.foo{
...
}

```

而当sass编译这一文件时, 它就会包含所有import的文件的内容, 这样你就只需要一个css文件,但是却有多个包含灵活可重复使用的代码块的文件了.

<strong>The Compass Framework(罗盘框架)</strong>
利用mixins,变量文件以及@import规则, 你可以创建你自己的css框架, 从而为你的新项目省下无数的时间.把复杂而又重复的模式都设计好, 只需要一个代码来调用意味着你会有更多的时间来创造,更少的时间折腾代码.

而把这个组织结构上的优势提高到另一个层次的就是Compass, 一个开源的样式框架, 基于Sass, 由Chris Eppstein(一个Sass的核心成员也是一个全面的好人~). Compass提供了非常多预写好的css模式, 而且随着css的更新而逐渐更新. Compass同时还让图标集(sprites)以及印刷系统更加容易处理了.

我总是建议创建属于自己的框架, 因为这更容易理解同时也能让你更好的掌握和使用. 但是作为一个学习经验的方法, 其他的框架可能会让你受益匪浅--他们可以让你了解别人是怎样设计项目以及提升效率的, 对此, compass也不例外.

<strong>The Bourbon Library</strong>
Design/Development shop thoughtbot的一群人合作完成了一个扩展的mixin库, 命名为Bourbon--巧合的是, 我喝过不少这种略苦的东西~一般混合着糖和水果.

通过google你就可以找到很多Sasser分享他们的mixins, 在github或者其他站点. 机会在于, CSS3中那些看起来非常丑陋而且难以维护的代码都已经包含在了一个个mixins中, 所以, 好好利用这个社区吧.

<h5><strong>@extend</strong></h5>
有没有过这样的经历: 在写某一个CSS的时候,发现和另一个有着非常相近的样式...除了几条规则以外...?

如下是一个示例. 你设计了一个提醒信息的样式,包含两个按钮, 位于页面顶部. 一个样式用以处理标准提醒, 第二个则是处理代表积极信息的提醒. 这两个样式几乎完全一样,只有背景色有所区别.

通常来说, 我们可以创建一个基类给常规的提醒,然后在第二种情况中覆盖背景颜色.

``` css

<h2 class="alert alert-positive">This is a positive alert!</h2>
.alert{
	padding: 15px;
	font-size: 1.2em;
	font-weight: normal;
	text-transform: uppercase;
	line-height: 1;
	letter-spacing: 3px;
	color: #fff;
	text-align: center;
	background: $color-accent;
	@include shadow(0,1px,2px,rgba(0,0,0,0.5));
	@include rounded(10px);
}
.alert-positive{
	background: #9c3;
}


```

其实不用在html中多加一个class来处理这种小问题, 我们完全可以使用@extend功能来把公用多数规则的样式连接起来. 此外, 我们可以添加多余的规则重写一些需要的样式, 来形成我们需要的样式.
所以, 如果使用@extend,那么上面的代码可以改写为:

``` css

<h2 class="alert-positive">This is a positive alert!</h2>
// 这里就只需要一个class即可
.alert{
	padding: 15px;
	font-size: 1.2em;
	font-weight: normal;
	text-transform: uppercase;
	line-height: 1;
	letter-spacing: 3px;
	color: #fff;
	text-align: center;
	background: $color-accent;
	@include shadow(0,1px,2px,rgba(0,0,0,0.5));
	@include rounded(10px);
}
.alert-positive{
	@extend .alert;
	background: #9c3;
}


```

sass就会自动将之编译妥当~(略)

当然, 我们也可以一开始就这么写(就是直接合并两个selector的公共部分,然后单独给另一个selector创建一条需要覆盖的股则).但是,sass的@extend让这一过程变得更加省事--更不用说让整个样式之间的关系变得更加清晰了.这比一开始就先要考虑好怎么用如何用要简单多了...

利用@extend同样可以让我们精炼我们的语法结构, 基于实际意义来创建类别名称而不是外观..

<strong>Multiple @extends</strong>
在一个声明中你是可以使用多个@extends的, 这可以把各个样式连接起来.

``` css

<h2 class="alert alert-positive">This is a positive alert!</h2>
.alert{
	padding: 15px;
	font-weight: normal;
	text-transform: uppercase;
	line-height: 1;
	letter-spacing: 3px;
	color: #fff;
	text-align: center;
	background: $color-accent;
	@include shadow(0,1px,2px,rgba(0,0,0,0.5));
	@include rounded(10px);
}
.important {
	font-size:4em;
}
.alert-positive{
	@extend .alert;
	@extend .important;
	background: #9c3;
}


```

编译(略)
Sass会把同样规则的样式归组, 并利用逗号分隔开, 然后为任何例外创建单条声明.

<strong>Using placeholder selectors with @extend</strong>

如果某个类完全使用的都是extend的样式, 即你需要创建一个完全使用别的类的样式的类,又该如何做呢? 利用placeholder selectors, 允许你创建虚类, 不会单独出现在最后的css文件中,然后你可以在其中引用@extend.
比如:

``` css

%button {
	padding: 10px;
	font-weight: bold;
	background: blue;
	border-radius: 6px;
}
//这就是一个虚类, 纯粹是用来定义基础样式的. 以%开头声明;
.buy{
	@extend %button;
}
.submit {
	@extend %button;
	background: green;
}

```

placeholder selectors在创建一些不确定是否会用到的模式的时候会非常有用,比如在框架中,设计指南中或者是初学者模板等, 因为不使用的placeholder的类是不会出现在css文件中的.

<strong>@extend VS @mixin</strong>

mixin会在每一个引用它的声明中创建同样的规则, 而@extend则是为同样的规则增加多个共同的selectors. 使用中一定要记得两者的区别.

比如, 过多的使用mixin可能会导致最终css文件变得臃肿..因为每次调用mixin,就会创建一次mixin的规则...越积越多..如果你发现你在各种地方使用一个mixin,那么考虑一下它是怎么编译的,考虑是否可以把它转化为@extend,让这些重复的样式合并到一起.

<strong>Don't over @extend yourself</strong>
对于共有样式的多个类而言, 使用@extend是一个非常强大的工具, 但是一定要注意. 一旦使用太多的extend, css文件会变的有些危险..不断的重复引用一个extend可能会导致一些不好的声明.当使用sass的时候, 很容易忘记最终编译好的样式文件会长什么样...一定要保留一个tab给你的编译后文件..时刻检查一下~

好了~你如今了解到sass的强大之处了~我们基本上已经覆盖了sass的所有基础信息.如何初始设置, 语法规则,以及它是如何和你现有的代码习惯相互配合的,同时还有如何使用其核心的功能:嵌套,变量,mixins以及@extend.

如果你继续深入的研究的话. 你会发现Sass可以做更多的事情,在下一章节, 我们会讲述sass如何辅助响应式设计以及媒体播放的.
走起~
=========本章完======

