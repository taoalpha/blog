---
layout: post
title: JavaScript callback学习笔记
category: tech 
description: 本文介绍我在学习js的callback函数过程中的一些新的, 比如如何用callback来确保js的执行顺序.
tags: [javascript,callback] 
series: The Way I Learn JavaScript
author: taoalpha
---

## 缘起

今天帮朋友做一个网站, 涉及到js请求并且渲染数据. 因为js语言的特点使得其代码是由上至下依次执行的, 有一个比较恶心的问题在于这一执行顺序并不等同于其先后顺序, 如果中间有一步或者几步的后续执行比较耗费时间, js本身是不会等待其执行完再去执行下面的语句的. 如此就会出现一些因为执行时间而导致的问题, 尤其是请求和渲染数据的时候. 如果你分开来写, 顺次执行的时候, 请求这一步花费的时间比较多, 那么很可能渲染环节都不会得到执行...

比如下述代码:

{% highlight javascript %}
tmpVar = 1;
changeItOne();
tmpVar = 2;
changeItTwo();
console.log("Second output: "+tmpVar);

function changeItOne(){
  tmpVar = 3;
  console.log("Output: "+tmpVar);
}
function changeItTwo(){
  // setTimeout(changeItOne,100);
  tmpVar = 3;
  console.log("Output of changeItTwo: "+tmpVar);
}

// 输出:
// Output: 3
// Output of changeItTwo: 3
// second output: 3

// 加上延时后输出
// Output: 3
// Second output: 2
// Output: 3

{% endhighlight %}

## callback

那么, 我们如何确保这种情况下的执行顺序呢? callback.

回调说白了就是在某个函数执行过程中在指定的情况下调用另一个函数的过程.

基本调用方法:

{% highlight javascript %}
function doSomething(params,callback) {

  // 主函数部分
  
  // 调用函数, 可以加上一些对应的限制条件来做调用判断
  callback(anything_you_want_to_send_with);
} 

function funOne(c) {

} 

para = ""

// 传参调用
doSomething(para,funOne); 

// 隐式调用 - 利用匿名函数调用
doSomething(para,function(data){
// data就是doSomething里面的callback()传参
// 调用函数内容
})
{% endhighlight %}

当然, 回调函数可以应用到很多地方, 甚至可以结合class, prototype以及apply,call从而模拟出私有函数, 私有变量等等~ 一切等你去挖掘! 哈哈

## 参考资料

- [WeiRSS - 我在其search.js中就用到了多层回调函数的调用](http://weirss.me/new)
- [javascript 回调函数笔记](http://www.jb51.net/article/53027.htm)
