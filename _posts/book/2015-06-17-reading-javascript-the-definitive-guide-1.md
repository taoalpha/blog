---
layout: post
title: JavaScript the Definitive Guide (1)
category: book
description: 读书笔记系列开篇~ 从JS开始, 主要记录阅读过程中一些心得, 或者不清楚的点. 本文主要为"JavaScript the definitive guide"的前7章内容相关记录.
tags: [js,reading notes] 
series: The Way I Learn JavaScript
author: taoalpha
---

## 概述

"JavaScript: the definitive guide"可谓是JS入门必读数目之一了. 今天正好读到第7章, 做一简单总结. 前7章的内容都集中在JS中的基本知识上, 包含了:

- 数据类型: 最简单的primitive datatyles: string, number, boolean , 两个空值类型: null, undefined,以及稍微复杂点的: object类型; 
- 变量问题: 变量规则, 变量作用域问题;
- 基础表达式和操作符: 操作符的优先级问题, 多操作数和单操作数以及执行顺序等;
- 陈述语句: 包含了if/for/while/do/with/switch(case)/break/continue/return/var/identifiers/empty statement等等;
- Object: json格式object以及常规的array类型对象的分别介绍以及自身结构属性, 异同点等;

## 心得

### break/continue 后接 label:

  break/continue是通常用于for/white/do等循环语句中用以做状态判断的, 但本身其还有另一种用法, 就是通过后接标记语句的用法来是break或者continue能针对标记语句操作, 比如下面这个跳出多层嵌套的例子: 

{% highlight javascript %}
test:
{
  for(var i = 0; i< 10; i++){
    for(var j = 0; j< i*5; j++){
      console.log(j);
      if(j==3) break test;
    }
  }
}
// continue test; 也是同样的用法
{% endhighlight %}

但需要注意的即使: 

- continue 语句(带有或不带标签引用)只能用在循环中;
- break 语句(不带标签引用),只能用在循环或 switch 中;


### with 语句

在js中经常涉及到变量作用域的问题, 而with语句的存在就是可以将某个object放入到其子语句的作用域链中, 什么意思呢? 首先通常来说, 在函数内, 其作用域链由全局作用域(全局对象)和本地作用域(local对象)组成, 我们在引用变量的时候就是在作用域链上逐个查询. 而with的作用就是把某个object插入到作用域链中去, 从而能够直接访问其子元素:

{% highlight javascript %}
a = {"nae":"hhh","test":"results"}
with(a){
  console.log(nae)
}
// output: "hhh"
nae = "sl"
with(a){
  console.log(nae)
}
// output: "hhh"
// 证明with引入的作用域甚至还在global域之上
{% endhighlight %}

不过呢, 通常很少人会去用`with`的, 因为它过于吃力不讨好了, 其对性能的影响是没有什么优化空间的, 与其使用`with`, 不如直接定义全局变量或者变量的简写(有一种with的用法是为了省略书写冗长的变量名)更为方便了.

### sort内嵌比较函数:

`sort()`本身作为array类型内置的几个函数之一, 默认通常是按照字母表来排序的, 但是其本身也是支持自定义排序规则的, 只需要我们把规则传入即可:

{% highlight javascript %}
// 以数字序列为例

var a = [12,3,5,8]
a.sort()
// output: [12,8,5,3]
a.sort(function(a,b){
return a - b;
// 返回<0, 则a排在b前面, >0 则b在前面, =0则表示相等;
})
// output: [3,5,8,12]
{% endhighlight %}

利用这一方法你就可以定制你的排序规则了, 甚至可以按照奇偶性排序都可以做到~ 比如 偶数在前: `return a % 2-b % 2;` 哈哈

### concat,slice,splice

这三个函数分别都是对array类型的元素进行母串增减获取子串而出现的, 其中有几点需要注意的:

- `concat()`函数支持数字多参数分别传入, 也支持数组传入的形式, 效果都是一样的, 但是`concat()`不支持递归解套, 即如果你传入的是多层嵌套的数组, `concat()`只会解套一次; 此外, `concat()`的操作是不影响母串的;
- `slice`和`splice`都可以用于获取子数组使用的, 其区别主要有两点, `slice()`接受的两个参数都代表的是index, 分别是起始次序到终止元素次序, 取子串时计算首位参数的元素,不计算第二位参数所代表的元素, 而`splice`则传入的两个参数分别是起始元素次序和要截取元素个数,即同样都是`(1,2)`, 后者代表截取第二个元素起始共计两个元素的子串, 前者则只获取第二个元素; 此外, `slice()`返回子串而不修改原数组, `splice()`则会在返回子串的同时修改原数组(原数组为去除子串的结果);
- `splice()`除了可以用获取子串外, 还能用于给母串添加元素. `splice()`可以接受超过2个参数, 从第三个参数起, 多出来的参数都是作为插入元素的, 执行的顺序则是删减完后当前位置插入, 即`splice(2,2,1,3,4)`表示的就是删掉第三个元素开始共计两个元素, 然后在同样的位置插入1,3,4三个元素, 同时, `splice()`也接受数组传入, 但是它不主动进行解套;

除了`splice()`, 上面的`sort()`的操作也是针对`a`数组进行的操作, 其结果也是针对a生效的, 即a的值是会被改变的;

### pop,push,shift,unshift

除了`splice()`之外, 我们通常用于直接操作母串增减的就是`pop,push,shift,unshift`四个了, 下面简单介绍下四者的区别:

- pop, push分别代表对母串最后一个元素的进出栈操作, pop是弹出最后一个元素, push则是在最后一个元素的后面继续压入新元素, 同样也支持数组元素压入, 但是不自动解套;
- shift, unshift和pop,push基本类似, 不同的地方在于操作的位置和后者相反, 是在栈头的位置, 即首位元素处; shift用于移出首位元素, unshift用于在首位增加元素, 接受数组, 也不自动解套, 同时多参数传入时, 作为整体一次性压入, 即`unshift(2,3)`,压入后为`[2,3,...]`.

这里比较独特的就是`unshift`多参数的压入问题了, 按我的预期其实是逐个元素压入, 这样顺序就是和传参相反, 但结果确实整体压入, 顺序与传参一致了~

## 谜题

书中第七章介绍说在array中如果直接赋值的index是超限(>2^32-1), 负值或者对应表达式的结果是此类值时, 会自动转为string传入定义, 这就引发了一个问题: 一旦如此定义后, 此变量还是array吗?

我在console中简单的测试了下:

{% highlight javascript %}
var a = [1,2,3]
// a.length == 3
a[-1.2] = "hehe"
a
// output: [1,2,3]  where is a[-1.2] ?
a[-1.2]
// output: "hehe"  WTF???
a.length
// output: 3 ??
console.log(a)
// output: [1,2,3,-1.2:'hehe']
console.log(a.length)
// output: 3
a instanceof Array
// ouput: True
a["h"] = "hh"
a
// output: [1,2,3]
console.log(a)
// output: [1,2,3,-1.2:"hehe",h:"hh"]
{% endhighlight %}

问题: a依然还是一个Array(亦或者不是?), 但用json定义的方式赋值的那几个值还是有效的, 可获取的, 但是为什么直接print出来的时候没有这些值呢, 甚至长度都不包含定义的这几个指? 为什么console.log()可以打出来呢?

**猜测解释**: a最初被定义为array, 但是却被json方式传值, 存储到了其内存中, 但是调用a时依然按照array来打印, 所以会自动滤除掉不符合array的几个值(只会按照index来找值). 但是console.log()是打出来其存储内容, 所以就按照其内存存储形式打印出来了.
