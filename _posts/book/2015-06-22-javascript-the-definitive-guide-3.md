---
layout: post
title: JavaScript the Definitive Guide (3)
category: book
description: 今天翻了下新版(第六版)的definitive guide, 发现有不少改动, 所幸之前也只是看了1/5, 所以就重头开始再翻一遍第六版, 本文算是对这一版的前4个chapter的一次查漏补缺.
tags: [js,reading notes]
series: Basic Guide for JavaScript
author: taoalpha
---

## 概述

先说点不相关的... 为了更好的阅读, 所以以后`读书笔记`相关的博文都会分拆成4个部分:

- **概述:** 算是阅读总结摘要以及类似这段话之类的声明介绍等等;
- **阅读笔记:** 这部分主要以阅读过程中的记录为主, 会比较杂, 基本算是逐点记录, 评判相对主观;
- **心得:** 这部分则主要为笔记的延伸, 算是对笔记的一种补充或者说自己的阅读理解消化所得, 有时候也会覆盖到一些使用架桥等等;
- **谜题:** 这里主要记录一些没有完全理解的部分, 会加上自己的猜测解答, 当弄懂后会更新**正解**;

DONE.

本篇是博主重新翻阅了"JavaScript the Definitive Guide(第六版)"的前4章内容(之前 [阅读笔记-1]({{ site.baseurl }}{% post_url book/2015-06-17-reading-javascript-the-definitive-guide-1 %}),[阅读笔记-2]({{ site.baseurl }}{% post_url book/2015-06-18-javascript-the-definitive-guide-2 %}) 均是第五版的)后的读书笔记以及心得体会. 内容主要覆盖js的基本用法, 考虑到重复, 这里主要是在上两篇的基础上查漏补缺.

## 阅读笔记

### Chapter 2 - 基础知识

#### JS能识别的`whitespaces`:

- 常规空格: `\u0020` # 即url中常见的`%20`
- Tab(制表符): `\u0009` # js中常见的`\t`
- Vertical Tab: `\u000B` # `\v`
- Form Feed(翻页/页码分隔符): `\u000C` # `\f`
- Nonbreaking Space(不间断空格): `\u00A0`  # 通常在html中用来阻止默认连续多空格自动归一的性质(auto collapsing)而使用`&nbsp;`, 同时因为软件处理的需要, 使用`&nbsp;`能够防止相应的处理器将普通空格转为行分隔;
- Byte order mark: `\uFEFF`
- any character in Unicode category Zs

#### JS能识别的`line terminators`:

- line feed: `\u000A` # `\n`
- carriage return: `\u000D` # `\r`
- line separator: `\u2028`
- paragraph separator: `\u2029`

**值得一说的是, js是支持unicode作为`indentifier`的合法字符的, 但是上述这些则不在其中.**


#### JS的"Unicode Escape Sequences"

类似"\u00E9"这种结构的字符在js都代表一种特殊的字符:"unicode". 如果你在js中使用这些字符, js会自动将其编译为对应的字符(如果是在js的注释中, 则不会编译, 而是以ascii对待), 比如: 示例就会编译为"é". 而在js中, 这种对等关系是支持的, 即 `"\u00E9" === "é"`是为真的.

但是一定要慎用... 因为unicode变化过多, 有时候输出看起来一样的字符, 其本质不一定一样: `"e\u0301"`的输出也是"é", 但是它相当于是`"e"+"\u0301"`组成的.

#### JS中的`";"`

在JS中, `";"`作为语句结尾并不是必须的, 只有当多语句同行的时候, `";"`才是必须的. 当你没有`";"`的时候, js会自动为你添加合适的`";"`. 通常它会自动将它没有`";"`无法解析代码时候遇到的换行处加以`";"`(除了类似return,break, ++, --等, 它会自动将其后的行分隔符作为`";"`对待.):

{% highlight javascript %}
var a
a
=
3
console.log(a)
// output: 3
// js在第一个换行处识别了其语句分割的意义, 但是在 a = 3 的两个分割处都因为它可以识别合并后的语句所以没有作为`";"`处理.
{% endhighlight %}

但是上述的成功不意味着js的智能, 更多时候如果我们不合适的使用`";"`, 会造成很多奇怪的问题的, 比如以`(, [, /, +, -`为起始的语句很可能会被误认为是前一语句的延续. 所以通常来说, js的编码还是比较鼓励使用`";"`作为语句结尾的.

### Chapter 3 - 数据类型

#### Number:

- **Global viriables:** `Infinity`,`NaN`
- **Global Objects:** `Math`,`Number`

Tips:

- `NaN` 具有唯一性, 其不等于任意值, 包括它自己, `0/0`会产生'NaN', 但是`0/0 != NaN`, 如果需要判断一个变量是不是NaN, 需要使用`isNaN()`这个内置的函数;
- `Infinity <==> Number.POSITIVE_INFINITY <==> 1/0`
- `-Infinity <==> Number.NEGATIVE_INFINITY <==> -1/0`
- `Binary Floating-Point`会导致小数级错误, 比如`0.3-0.2 != 0.2-0.1`, 这个属于计算机本身因为二进制编码的原因所致, 所以在比较数字大小的时候要格外小心;

### String:

- **immutable ordered sequence of 16-bit values**

Tips:

- string的长度都是按照16-bit来计算的, 所以当如果一个字符超过了16-bit, 则会按照多的计算. 比如: `e - \ud835\udc52`, 就需要按照两个16bit计算, 即其长度应为:"2"
- 从ECMAScript 5之后就允许string跨行定义了, 只需要在换行的地方加上一个反斜杠`\`, 即可.
- 转义字符`\`如果加在普通字符前, 不会产生任何效果;
- `typeof null => Object` , `typeof undefined => undefined`;
- `null == undefined`, `null!==undefined` => True

### 类型转换

javascript是一个很宽松的语言, 我们不需要预先定义变量类型, 而在运算以及执行过程中, js也会自动的帮助我们进行类型转换, 当然为了更好的借助这一特点, 了解下图中的js转换类型的规则还是非常有必要的.

{% image 2015-06-22/javascript-type-convertion.jpg alt="JavaScript Type Convertions" title="JavaScript Type Convertions" [no-autosize] %}

其中object转换 primitive datatype 的话, 一般会按照如下步骤进行:

- 首先会默认调用`toString()`函数, 你可以自行定义这一函数, 如果`toString()`返回结果正常, 则转换结束;
- 如果`toString()`未定义, 或者返回结果非`primitive datatype`的话, 会自动调用`valueOf()`函数, 同上一步;
- 而如果两个都没找到, 那么js将会抛出`TypeError`;

而根据要转换的是`string`还是`number`而交换1,2两步( `string` 的话先调用`toString()`, 且返回值必然会转为string; 如果是`number`的话, 则先找`valueOf()`, 返回结果为number). 当然至于boolean的话, 所有的object转换到boolean都是true.

Array转换`string`的时候默认的`toString()`就是一个`join()`调用~ Function的话, 则也可以自己定义`toString()`函数.

Tips:

- x + "" // Same as String(x)
- +x // Same as Number(x). You may also see x-0
- !!x // Same as Boolean(x). Note double !
- 在ECMAScript 5的strict模式下, 所有变量君需要声明才能赋值, 否则会报错;

### Chapter 4: Expressions and Operators

{% image 2015-06-22/javascript-operators.jpg alt="JavaScript Operators" title="JavaScript Operators" [no-autosize] %}

上图为按照优先级顺序排列下来的操作符(横线分隔的同一组块之间的级别相同).

Tips:

- 运算顺序不影响赋值顺序, 赋值顺序始终都是严格从左到右的, 比如:`h = x+y+z`, 那么赋值顺序始终都是`h->x->y->z`; 通常情况下, 这一赋值顺序不会影响之后的计算顺序, 对结果基本没什么影响, 除了一种情况:

  如果前变量的赋值会影响到后面变量的值的话, 比如共用同一个变量, 那么这种情况下, 赋值顺序就**可能**会对结果产生一定的影响了. 最简单的例子就是`z = 2;y = function(){z = 3;return 1};`, 因为y是一个函数, 而它的执行会改变z的值, 所以`y()+z`和`z+y()`的结果就是不相同的.

- "+"运算符中的类型转换:
  - string优先, 只要有两个操作数中有一个是string或者是有`toString()`的object, 那么其都会按照string来进行链接运算;
  - 除非两个都是非string, 才会进行加法运算;
  - 当"+"作为单操作数时, 则意味着将操作数向number类型转换;

- `&&`运算符如果第一个为false, 则不执行第二条判断, 所以可以用这个方法来代替if: `(a==b) && alert("a equals b")`就相当于`if(a==b) alert("a equals b")`.
- `!(p && q) === !p || !q`
- `!(p || q) === !p && !q`
- `a op= b` 和 `a = a op b`通常是等价的, 除非a本身的重复赋值会有副作用, 比如 `a[i++] += 1`和`a[i++] = a[i++] +1`就不一样, 因为后者前后两个`i`不同了.
- `eval()`函数会继承当前的scope, 除非eval()被赋予某个新的reference, 那样的话只会使用global的scope;
- `void`操作数很少用到, 它是个单操作数的操作符, 其用法就是丢弃操作数的返回结果, 然后返回 undefined...

## 心得

### whitespaces 和 line terminators

通常在js里面我们使用`\s`来统一代表所有其可以识别的`whitespace`, `line terminators`. 如下例:


{% highlight javascript %}
var k = 'asd \t asdasd \na asd \f asda dad\rasd\u2028asd\u2029\u00A0'
k
// output: "asd 	 asdasda asd  asda dadasd asd  " 里面有两个换行的符号, 我这里为了演示方便就不换行了
k.replace(/\n/g,'-')
// output: "asd 	 asdasd -a asd  asda dadasd asd  " 同上,里面的"\r"我也不换行了
k.replace(/\s/g,'-')
// output: "asd---asdasd--a-asd---asda-dad-asd-asd--"
{% endhighlight %}

因为在console中输出的时候是不换行的, 所以有时候单单看console输出的话, 类似这种编码问题所致的错误就找不出来, 为了省事, 我们可以统一使用`\s`来代表所有此类符号.



## 谜题

Q: 按照正常来说`Number.MAX_VALUE`加上一个数应该就会自动转为`Infinity`, 但实际上, 测试过程中发现, 只有当`Number.MAX_VALUE`加上一个**足够大的数**后才会等与`Infinity`, 这是为什么?

{% highlight javascript %}
Number.MAX_VALUE
// output: 1.7976931348623157e+308
Number.MAX_VALUE +1
// output: 1.7976931348623157e+308
...
Number.MAX_VALUE + Math.pow(10,1000)
// output: Infinity
{% endhighlight %}

**正解:** _**the sum is computed and rounded to the nearest representable value using IEEE 754 round-to-nearest mode. If the magnitude is too large to represent, the operation overflows and the result is then an infinity of appropriate sign.**_

> IEEE 754

> In the following two rounding-direction attributes, an infinitely precise result with magnitude at least bemax ( b − ½ b^(1-p) ) shall round to ∞ with no change in sign; here emax and p are determined by the destination format (see 3.3). With:

> - **roundTiesToEven:** the floating-point number nearest to the infinitely precise result shall be delivered; if the two nearest floating-point numbers bracketing an unrepresentable infinitely precise result are equally near, the one with an even least significant digit shall be delivered

> - **roundTiesToAway:** the floating-point number nearest to the infinitely precise result shall be delivered; if the two nearest floating-point numbers bracketing an unrepresentable infinitely precise result are equally near, the one with larger magnitude shall be delivered.

_**ECMAScript does not specify which of the round-to-nearest, but it doesn't matter here because both gives the same result. The number in ECMAScript is "double", in which**_

- b = 2
- emax = 1023
- p = 53,

_**so the result must be at least 2^1024 - 2^970 ~ 1.7976931348623158 × 10^308 in order to round to infinity. Otherwise it will just round to MAX_VALUE, because that is the closer than Infinity.Notice that MAX_VALUE = 21024 - 2971, so you need to add at least 2^971 - 2^970 = 2^970 ~ 9.979202 × 10^291 in order to get infinity.**_

Q: `'0' == false` 是 true, 为什么 `null == false` 就是 false呢?

**猜测解释:** `==`这样的是比较`value`的, 而 `null`转换为`boolean`类型为`false`, 并不意味着两者的`value`是相同的. `==`只会比较`value`, 而不会进行转换. 也即`true`, `false`两个`boolean`类型的其`value`也是`1,0`. 而`null`和`undefined`的`value`则不同, 前者为空, 后者为无.


## 参考资料:

- [JavaScript the Definitive Guide 6th edition](http://book.douban.com/subject/5303032/)
- [Unicode Property](https://en.wikipedia.org/wiki/Unicode_character_property#General_Category)
- [List of Unicode Characters](http://en.wikipedia.org/wiki/List_of_Unicode_characters)
- [编码历史介绍](http://www.qianxingzhem.com/post-1499.html)
