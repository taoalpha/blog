category: read
description: ''
date: 2014-08-05 1:00:00
title: jQuery的5个小细节-5 Little Known Details About jQuery Methods
tags: [jquery,翻译文章,译系列,coding]
---

其实CS真的是一个非常博大精深的课程啊... 不说其他.. 单纯说前端的这些技巧... 感觉穷其一生都难以学通学懂... 很难想象计算机的发明还不到70年... 人类的进步果然是无法想象的...

====正题=====jQuery的5个小技巧============================
Author: <a href="http://www.sitepoint.com/author/aderosa/">Aurelio De Rosa</a>
Published: 4 Aug, 2014
Source: <a href="http://www.sitepoint.com/5-little-known-details-jquery-methods//">SitePoint</a>

jQuery作为世界上使用最广泛的js库已经广为人知了. 虽然近来出现了很多批评的声音, 但是它依然吸引着众多的开发者. 无论你是一个jQuery的入门者还是已然晋升专家级别(Dave Methvin和其他的jQuery团队成员就除外了...), 你可能都对一些jQuery的特殊属性比较陌生. 本文将会讨论其中五个小的特性.

<h3>Returing <i>false</i> in Event Binders</h3>

如我们所知, jQuery的首要目的是统一各个浏览器的行为. 从而可能会对一些浏览器的属性有所增强, 整合一些本来浏览器可能不支持的功能. 想想那些多亏了jQuery你才能在IE6,7上使用的选择器,比如:not, :last-child等等.

但是, 虽然很少见, jQuery还是会出现一些异常表现的. 一个简单的例子就是在jQuery的事件处理中, 比如一个on()事件, 返回false的表现和如下的调用效果是完全一样的:

``` javascript

	event.stopPropagation();
	event.preventDefault();

```

这一问题从jQuery的源代码中可以得到验证的:

``` javascript

if ( ret !== undefined ) {
   if ( (event.result = ret) === false ) {
      event.preventDefault();
      event.stopPropagation();
   }
}

```

<h3>Pseudo-selectors Do More Than You Think</h3>
在jQuery对很多伪类的文档描述中, 你可以看到如下的备注(下例是:checkbox的):
<blockquote>
$( “:checkbox” ) is equivalent to $( “[type=checkbox]” ). As with other pseudo-class selectors (those that begin with a “:”) it is recommended to precede it with a tag name or some other selectors; otherwise, the universal selector (“*”) is implied. In other words, the bare $(‘:checkbox’) is equivalent to $( “*:checkbox” ), so $( “input:checkbox” ) should be used instead.	
</blockquote>
我们看下真实的代码部分:

``` javascript

function createInputPseudo( type ) {
    return function( elem ) {
        var name = elem.nodeName.toLowerCase();
        return name === "input" && elem.type === type;
    };
}

```

如你所见, 备注中有些表述错误: $(':checkbox')实际上应该等同于$('input[type="checkbox"]'). 因为它搜寻的是input标签(name==="input"), 不过它依然会测试所有符合你制定要求的元素(比如你制定了一个上级div内的:checkbox,或者一个class等).

因此, 你可能很希望以后使用:checkbox的时候都不用在前面加上对应的元素名了... 都用下面这种..

``` javascript

	var $checkboxes = $(':checkbox');

```

实际上, 就单纯从性能来说, 更明确的之处元素所在会更好的帮助jQuery定位到元素的. 所以, 最好还是写成如下形式:

``` javascript

	var $checkboxes = $('input:checkbox');

```

<h3>jQuery.type()</h3>
哈哈, 看名称似乎就已经很陌生了吧~ 你注意到jQuery有一个方法可以判断一个对象的类型吗?

即便你已经知道这个方法, 但你依然有可能忽略了它和js本身typeof函数的区别. 实际上, jQuery.type()返回的是一个更加准确的类型. 比如:

``` javascript

// typeof examples:
// prints objects
console.log(typeof null);
 
// prints objects
console.log(typeof [1, 2, 3]);
 
// prints objects
console.log(typeof new Number(3));

```


``` javascript

// $.type() examples:
// prints null
console.log($.type(null));
 
// prints array
console.log($.type([1, 2, 3]));
 
// prints number
console.log($.type(new Number(3)));

```

所以说, 如果你要开发jQuery插件, 你可能需要用到$.type()来获得更准确的数据类型.

<h3>attr() can removeAttr()</h3>
有些糊涂? 哈, 首先, 对于不了解attr()函数的童鞋, 这是一个获取或者赋予第一个匹配的目标元素的属性的函数.
实际上, attr()不仅可以支持传入数字或者字符串, 同时也可以支持传入null来充当第二个参数(第一个参数是要赋予或者获取的属性名称, 比如src等--译者注). 一旦传入null, 那么其实就实现了removeAttr()的功能, 从而会去除这一属性. 
不信? 看看源代码~

``` javascript

attr: function( elem, name, value ) {
    ...
    if ( value !== undefined ) {
 
        if ( value === null ) {
            jQuery.removeAttr( elem, name );
    ...
}	

```

如上, attr()调用后会先判断传入的value是不是undefined(如果是undefined, 就会转入获取环节--译者注),不是的话, 会先判断是不是null, 如果是的话, 会自动调用removeAttr()的.

这一技巧在你要对某个属性进行条件性赋值的时候最为方便, 比如:

``` javascript

$(selector).attr(anAttr, condition ? value : null);	

```

就不用写成这样了:

``` javascript

condition ? $(selector).attr(anAttr, value) : $(selector).removeAttr(anAttr);

```

你应不应该使用这一技巧呢? 这就得由你来判断了.. 如果我是你的话, 为了代码的清晰,我可能不会使用它. 目前来说, 这一部分还没有在文档中出现, 而且这里还有一个<a href="https://github.com/jquery/api.jquery.com/issues/523">相关的讨论</a>, 有兴趣的话, 可以点开看看哈.

<h3>Turning Array-like Objects Into Arrays</h3>
js包含了很多数据类型, 比如nodeList, 或者函数接受的arguments变量,都是类似于array的类型, 但是都不是array. 这意味着我们可以用类似array的方法来操作其中的元素,比如arguments[0], 但是却无法使用一些array的函数, 比如:forEach(),join()等.
假如我们有一个Dom的nodeList:

``` javascript

var list = document.getElementsByClassName('book');

```

如果我们想要对一个类似array的数据使用forEach()函数, 我们不能直接调用forEach()函数的, 会报错'Uncaught TypeError: undefined is not a function'. 为了避免这类错误, 最常用的方法是利用prototype属性和call()函数:

``` javascript

Array.prototype.forEach.call(list, function() {...});

```

或者你可以写成:

``` javascript

[].forEach.call(list, function() {...});

```

无论你使用哪种, 都不是很优雅(...靠..译者注). 幸运的是, jQuery提供了一个解决方法~ 那就是jQuery.makeArray()函数:

``` javascript

$.makeArray(list).forEach(function() {...});

```

好很多了有木有!!!

<h3>Conclusions</h3>
从本文你可以学到什么? 除了上述这5个小技巧之外, 我们希望告诉你, 即便如jQuery这样牛X而且坚实的项目也不是10分完美的. 它依然有一些bug和文档问题, 而只有源码才是可以让你信任的信息来源. 当然, 源码有时候也能够因为不同开发者的目的而有所区别... 这是另一个话题了..

还有一点就是你应该对自己所学习和使用的框架和库保持好奇心, 阅读它们的源代码, 并尝试从中学到新的知识和技巧.

作为最后一个建议, 如果你热爱jQuery, 如我这般, 请作出你的贡献吧~ 即使只是报告一个bug或者修正一个小小的文档问题也能够帮助到数以百万计的开发者们.

为了以防你问我我是如何注意到这些细节问题的, 秘密就在于我写过好基本关于jQuery的书籍... 而且 欧文十一个jQuery问题跟进者!


