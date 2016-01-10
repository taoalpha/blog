category: read
description: ''
date: 2013-12-19 3:00:00
title: USING SASS–Chapter 3
tags: [HCIBib,Sass,译系列,Sass for web designers,翻译文章,Mixin]
---

<h3><strong>第三章--使用SASS</strong></h3>
在这一章, 我会分享许多我每天使用的一些sass的特性~ 我特意为此书建了一个虚拟的项目来演示对应的功能~

项目名称是Sasquatch Records--一个简单的关注一种神秘生物-大足野人的超自然音乐风格(?). Sass的功能是非常强大的--它是一个非常强力的工具, 可以让你更加轻松理智的创造复杂的样式文件. 有这么多的可能性,随我们处理, 我喜欢先说一下我认为对网页设计者们最有价值的部分, 同时也是最容易转化为你自己的部分.
<h5><strong>嵌套规则</strong></h5>
利用sass可以在css规则中相互嵌套而不是重复的在不同的声明中使用选择器. 这个嵌套功能反映了一个典型的标记语言的结构特征.

例如, 针对Sasquatch Records的头部主体部分, 其html代码如下:

``` css

<header role="banner">
<div id="logo"><img alt="Sasquatch Records" src="logo.png" /></div>
<h1>Sasquatch Records</h1>
...
</header>

```

当我们写SCSS的时候, 我可以沿用这样的嵌套结构, 让Sass建立一个完整的选择器. 我个人喜欢在嵌套的选择器之前放一个空的行来让同一个嵌套级别的css属性成组出现.

``` css
header[role="banner"] {
	margin: 20px 0 30px 0;
	border-bottom: 4px solid #333;

	#logo {
		float: left;
		margin: 0 20px 0 0;

		img {
			display: block;
			opacity: .95;
		}
	}

	h1 {
		padding: 15px 0;
		font-size: 54px;
		line-height: 1;
		font-family: Jubilat, Georgia, serif;
		font-weight: bold;
	}
}
# 发现这里prettyprint不能很好的识别tab...所以格式上乱了..大家明白是缩进就行~

```

以上的SCSS部分则可以编译为:

``` css
header[role="banner"] {
	margin: 20px 0 30px 0;
	border-bottom: 4px solid #333;
}
header[role="banner"] #logo {
		float: left;
		margin: 0 20px 0 0;
}

header[role="banner"] #logo img {
			display: block;
			opacity: .95;
}

header[role="banner"] h1 {
		padding: 15px 0;
		font-size: 54px;
		line-height: 1;
		font-family: Jubilat, Georgia, serif;
		font-weight: bold;
}
```

不用在每个选择器中重复那些元素, sass可以通过嵌套来让结构变的更加简化. 当然, 嵌套过程中需要谨慎再谨慎.有时候你不需要在选择器上太过啰嗦, 而且无尽的嵌套实际上很有可能影响可读性. 一些不多的层级结构就刚刚好~而且对于模块的声明, 像上面的例子, sass的嵌套是一个非常省时间的事情.
<h5><strong>嵌套过程中的命名属性</strong></h5>
除了嵌套的规则, 你还可以嵌套那些公用同一个命名的属性值:比如,font-family, font-size, font-weight等~就像这样:

``` css
header[role="banner"] h1 {
		padding: 15px 0;
		font: {
			size: 54px;
			family: Jubilat, Georgia, serif;
			weight: bold;
		}
		line-height: 1;
}
```

编译后则是:

``` css
header[role="banner"] h1 {
		padding: 15px 0;
		font-size: 54px;
		line-height: 1;
		font-family: Jubilat, Georgia, serif;
		font-weight: bold;
}
```

类似的, 在text-家族中也有很多属性~ 我们可以用Sass嵌套来省掉很多的重复输入:

``` css
text: {
	transform: uppercase;
	decoration: underline;
	align: center;
}
```

同时background-家族也是一个很好的例子~

``` css
background: {
	color: #ea4c89;
	size: 16px 16px;
	image: url(sasquatch.png);
	repeat: no-repeat;
	position: top left;
}
```

嵌套在Sass中就意味着更少的输入. 用缩进来表示选择器的格式. 这同样是一个很容易就能吸引到任何写css的人的概念~毕竟css可算得上是很废精神的..

<h5><strong>利用&amp;来引用父级别选择器</strong></h5>

和结构的嵌套以及属性的嵌套一起, sass针对引用当前选择器的父级元素也有很好的方式来实现~就是&amp;~

例如, 一个对链接的声明, 我们可以添加一个hover的属性来重写它们的颜色和边框颜色:

``` css

a: {
	font-weight: bold;
	text-decoration: none;
	color: red;
	border-bottom: 2px solid red;
	
	&: hover {
		color: maroon;
		border-color: maroon;
}
```

这个符号代表插入父级选择器, 在这里代表的就是a~ 上例编译后就是:

``` css

a: {
	font-weight: bold;
	text-decoration: none;
	color: red;
	border-bottom: 2px solid red;
	}
a:hover{
	color: maroon;
	border-color: maroon;
}
```

这里有另一个例子是使用&amp;符号引用父元素的, 而不同的类别中就会产生不同的效果:

``` css

li a: {
	color: red;
	border-bottom: 2px solid red;
	&.alert {
		color:blue;
	}
	
	&.success {
		color: green;
	}
}

```

以上就会相应的编译为:

``` css

li a: {
	color: red;
	border-bottom: 2px solid red;
}
li a.alert {
		color:blue;
	}
	
li a.success {
		color: green;
	}

```

&amp;符号在同一个命名下重写规则也非常实用, 比如说我们在一个站点下, 希望在某个特定的页面下有轻微的不同. 我们给body添加一个class, 然后我们就可以用&amp;符号来轻松的重写这条规则了:

``` css

section.main p{
	margin: 0 0 20px 0;

	body.store &{
		font-size: 16px;
		margin: 10px;
	}
}

```

编译结果就是:

``` css

section.main p{
	margin: 0 0 20px 0;
}
body.store section.main p{
		font-size: 16px;
		margin: 10px;
}

```

而在所有的带有store的class的页面,段落的margin就会有所区别,字体也会用16px. 但是相对于重写整个声明, 我们用嵌套的方式, 利用&amp;符号来创建一个独一无二的范例, 从而让sass能够重新调整全部的选择器. 再一次, 非常省时, 同时还把相关的规则放在了一起~

<h5><strong>Sass 中的注释</strong></h5>

为了在样式文件中注释, Sass在原有css的多行注释的基础上, 增加了单行注释的支持.


``` css

/* This is a multi-line comment that will appear in the final .css file. */

```

而为了保证一些注释信息能够出现在极简风格下的css文件中, 就可以用!符号, 将!放在注释的开头即可.

``` css

/*! This is a multi-line comment that will appear in the final .css file. */

```

而单行注释则通过两个//作为前缀实现的. 只要出现在任何一行的开头, 就会生效, 同时单行注释的内容是不会出现在最终的css文件中的. 所以你可以非常安全的使用它们, 通过它们来注释掉你那些非常私人的注释内容.

``` css

// hahah~this is a single-line comment.
// You can not see me in the css file~
// ahahahah

```


除了隐藏你对于音乐的那些令人怀疑的品味外, 单行注释对于团队合作而言是非常有帮助的. 你可以随时随地的使用单行注释而不用担心导致输出的css文件变得臃肿...

<h5><strong>变量</strong></h5>

Sass充满了各种不可思议的有用技能, 这些都可以让你的生活变的更加简单. 但是如果说要选择一个最有用的功能, 我一定会选择---变量.

我们在样式文件中经常性的重复. 颜色, 字体, 背景图片, 宽度等等. 那些一定有所调整就需要一大堆的查找-替换才能搞定的固定模式...变量的引入就是让这些变的更加容易以及简单的维护.

Sass中定义的变量很简单, 只需要在常规的css规则中加入$就可以了~ 如下:

``` css

$color-main: #333;
$color-light: #999;
$color-accent: #ea4c89;

$font-sans: "Proxima Noca","Helvertica Neue", Helvetica, Arial, sans-serif;
$font-serif: Jubilat, Georgia, serif;

```


一旦定以后, 它们就可以在声明中使用:

``` css

body {
	padding: 0 8%;
	font-family: $font-sans;
	font-size: 100%;
	color: $color-main;
	background: #fff url(../img/bg.jpg) repeat-x -80% 0;
}

```

Sass 则会自动替换掉对应的变量值, 输出(略)...

利用Sass的变量, 再去改变那些整个样式中的重复模式, 就只需要很快的调整变量即可~ 再也不用去整个文件中捞了...赞美我主..

<strong>利用变量来做风格指南</strong>
Jina Bolton曾经写过一篇非常棒的文章关于Sass的变量是如何帮助我们根据一个brand palette(品牌调色板?)创建一个风格指南的.Jina是这么说的:


<blockquote>为了保持我们风格指南的相关性, 针对每一个它所描述的应用而言, 一般把它放在admin部分. 我们利用sass的变量一次展示我们调色板中的颜色, 因为我们在同一个应用中使用的是同一个前端, 所以我们就可以使用同样的变量来引用这个调色板, 当我们修改变量的值, 这个调色板就会自动的更新.(说实话..没看懂...囧..)</blockquote>

预期创建一个静态的风格指南, 随时有可能过时以及不相关, 利用Sass变量来定义就意味着任何人都可以帮助更新这个风格指南.

利用风格指南的变量为基础, Jina有谈论了一些关于Sass的颜色属性, 用来创建brand palette的变量. 比如:

如下有一个非常mini的调色板, 是提供给Sasquatch Records使用的, 利用了单行注释来注明每个颜色, 因为对于css文件而言,这些信息无关紧要.

``` css

$color-main: #333; // black
$color-light: #999; // grey
$color-accent: #ea4c89; // pink

```

接下来, 利用sass中darken或者lighten的属性, 我们可以生成基于这个调色板的不同明暗的颜色~

比如说让我们把pink调暗30%:

``` css

section.secondary { 
	background: darken($color-accent, 30%);
}

```

而编译后, Sass就会计算把原来的pink降低30%的亮度后获得的16进制色值为:

``` css

section.secondary { 
	background: #8d1040
}

```

同样的,我们可以用lighten来调高颜色的亮度:

``` css

section.secondary { 
	background: lighten($color-accent, 30%);
}
==>
section.secondary { 
	background: #fad5e3;
}

```


<strong>CSS的变量还有什么?</strong>

Sass有个极好的地方在于它可以作为css的一个实验基地, 为css提供了一个非常棒的测试环境. 换句话说, Sass可以每次都提前一步, 试用一些css中没有的功能, 如果证实可行易用, 那么就有可能放入到标准的css之中去.

变量就是一个典型的例子, 而且可能是css的预处理程序中最有用的功能了. 通过使用Sass以及Less, 大家对于在css中添加变量的呼声越来越大, 目前W3C已经开始起草一个方案,'<a href="http://www.w3.org/TR/css-variables/" target="_blank">CSS 变量模块 1级</a>', 已经开始开发了.而且最新的Webkit nightly 版本已经开始支持变量了. 这也意味着原生支持css变量已经步入正轨了~

不幸的是, 在写作本文的时候, CSS变量语法还是和Sass有所区别, 而且不是那么的优雅以及简单易学...比如说, 下述是为root元素定义一个css变量:

``` css

:root{
	var-color-main: #333;
}

```

那么如何在声明中使用呢?

``` css

#main p{
	color: var(color-main);
}

```

目的是通过var前缀来定义一个变量, 然后通过var(变量名)来引用变量; 这有些复杂而且容易混淆了..但是这算是一个正在进行中的工作, 有很多人都在倡议直接使用Sass那样的语法来定义变量, 使用和定义都用同样的符号~ 仅在这里希望最终能够达成此愿~

最重要的是,只有开发版的浏览器才支持最新的功能, css变量完全不能再正常的产品中使用...这也是坚持使用sass的又一原因.

<strong>混合</strong>

我们接着说我第二喜欢的Sass特性: 混合. 通过变量你可以定义以及在整个样式文件中重复使用一些属性值;而通过混合, 你可以在整个样式中定义以及复用整个模块. 与其一次次的重复的输入相同的代码块, 你完全可以用混合的功能来定义一组规则, 然后再后面的声明中直接使用这一定义~

为了阐述的更加清楚~我们来能创建一个给Sasquatch Records的头部样式使用的mixins~ 因为这些标题会出现在整个页面的多个地方, 而他们的CSS样式又都是一样的, 绝好的机会使用mixins~

首先, 我们需要定义一个mixin, 在sass中可以用@mixin开头来定义, 我命名为title-style, 定义其margin和fonts的规则:

``` css

@mixin title-style {
	margin: 0 0 20px 0;
	font-family: $font-serif;
	font-size: 20px;
	font-weight: bold;
	text-transform: uppercase;
}

```

一旦定义好了, 就可以在任何地方来引用它了~通过@include就可以了~

``` css

section.main h2 {
	@include title-style;
}

```

那么它会编译为:

``` css

section.main h2 {
	margin: 0 0 20px 0;
	font-family: Jubilat, Georgia,serif;
	font-size: 20px;
	font-weight: bold;
	text-transform: uppercase;
}

```

但是我们同时又希望在侧边栏的h3元素也用同样的方式, 那么就可以直接在h3上同样引用这个mixin~ 然后会用同样的方式编译~

``` css

section.secondary h3 {
	@include title-style;
}

```

如此会让我们避免重复的输入同样的代码,或者添加一个共同的class来赋予属性~

mixins引用的同时不影响其他属性的继续使用:

``` css

section.main h2 {
	@include title-style;
	color: red;
}

```

编译的时候也只是多了color的属性而已~

共用的代码完全可以摘出来作为mxins~ 这样你依然保留重写覆盖或者增强这些规则的能力~ 多强大！

<strong>Mixin Arguments</strong>

Sass的mixins同样可以接受在引用的同时传参数. 比如, 让我们在引用title-style的同时指定一个颜色.

如果要给一个mixin传参数, 就需要在定义的时候在mixin后面加上括号以及对应的变量:

``` css

@mixin title-style($color) {
	margin: 0 0 20px 0;
	font-family: $font-serif;
	font-size: 20px;
	font-weight: bold;
	text-transform: uppercase;
	color: $color;
}

```

当我们调用这个mixin的时候, 我们就可以传递一个颜色值给它了~比如:

``` css

section.secondary h3 {
	@include title-style(#c63);
}

```

编译的时候就会自动替换掉相应的颜色变量~

<strong>多个参数</strong>

你可以通过用逗号分隔变量参数来传递多个参数~ 定义和引用方式也都一致,用逗号分隔多个变量即可.
范例(略)
由此你应该开始感受到mixin是多么的灵活了吧~ 通过参数, 在统一的规则之中又可以有些微的区别~

<strong>定义默认变量参数值</strong>
当你使用mixins的参数时, 为了方便经常会定义一个默认的值. 通过这种方式, 你就可以在调用mixin的时候不传递参数了. 这算是正常的状态, 但同时也可以接受参数传递~

``` css

@mixin title-style($color,$background:#eee) {
	margin: 0 0 20px 0;
	font-family: $font-serif;
	font-size: 20px;
	font-weight: bold;
	text-transform: uppercase;
	color: $color;
	background: $background;
}

```

即便我们已经定义了一个淡灰色值作为mixin默认的背景色, 我们依然可以传递不同的值作为参数来调用mixin~

``` css

section.main h2{
	@include title-style(#c63);
}
section.secondary h3{
	@include title-style(#39c,#333);
}

```

编译后(略)
此外, 当我们为一个mixin有多个默认的参数值时, 你可以指定重写某个而不用全部重定义.

比如, 如果我们的mixin定义了color和background两个值:

``` css

@mixin title-style($color:blue,$background: green) {
	margin: 0 0 20px 0;
	font-family: $font-serif;
	font-size: 20px;
	font-weight: bold;
	text-transform: uppercase;
	color: $color;
	background:$background;
}

```

加入我们希望color保持默认,而background则重写为pink,那么可以利用如下的形式指定background重写:

``` css

section.main h2{
	@include title-style($background:pink);
}

```


<strong>CSS3 LOVES MIXINS</strong>

CSS3中支持MIXINS和参数真的是一大亮点, 我们经常会大量的重复verdor-开头的属性来实现一些诸如圆角,阴影,渐变,变形等, 而这些的大体都一样, 只是属性值可能略有区别..所以多数是重复性的, sass则让这一切变的容易起来~ 快用mixin吧~

~~~~~~~~~待续~~~~~~今天先到这里了~~~~第三章剩余的部分就在下一次来继续吧~~~~~回见~~~~~
