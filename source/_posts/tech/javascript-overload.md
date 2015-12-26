date: 2015-07-11 0:00:00
title: JavaScript 重载函数实现探究
category: tech
description: 今天花了2个多小时研究一个只有8行的js重载函数代码... 记录下心得... 省的下次忘了...
tags: [javascript,overload]
series: The Way I Learn JavaScript
author: taoalpha
---

## 缘起

今天看[Secrets of the JavaScript Ninja][book]看到js中如何实现重载函数的部分, 然后对着一个只有7,8行代码的函数范例研究了2个多小时... 掩面羞愧难当ing... 为了让记忆更加深刻些, 特意记录下心得以防止以后再次跌在同一个坑里...

## JS的重载

### 重载函数

重载函数的概念在很多OOP(面向对象的编程), 尤其是C系的语言中是很基本的, 其允许在同一范围中声明几个功能类似的同名函数，但是这些同名函数的形式参数（指参数的个数、类型或者顺序）必须不同，从而实现同一个函数可以执行不同的逻辑.

但是, javascript中是不存在重载函数这个概念的, 不过其松散的函数(比如参数传递的数量和类型等限制), 变量尤其是其变量类型的自动判断的特点都让我们通常选择在函数的主体逻辑上实现根据参数的不同而执行不同的逻辑. 但是js中能模拟出真正的重载函数吗?

答案是肯定的, 而且很简单, 真的很简答...

### JS中的实现方法

首先我们来看源码:

``` coffeescript
addMethod = (object, name, fn) ->
  old = object[name]
  object[name] = ->
    # console.log fn  # 通过调用fn来了解其每一步的逻辑
    if fn.length == arguments.length
      fn.apply(@, arguments)
    else if typeof old == 'function'
      old.apply(@, arguments)

example =
  values : ["Dean Edwards", "Sam Stephenson", "Alex Russell"]

addMethod example, "find", ->
    @values

addMethod example, "find", (name) ->
    ret = []
    for i in [0..@values.length-1]
      ret.push(@values[i]) if @values[i].indexOf(name) == 0
    ret

addMethod example, "find",(first, last) ->
    ret = []
    for i in [0..@values.length-1]
      ret.push(@values[i]) if @values[i] == first + " " + last
    ret

console.log example.find()
# ["Dean Edwards", "Sam Stephenson", "Alex Russell"]
console.log example.find("Sam")
# ["Sam Stephenson"]
console.log example.find("Alex","Russell")
# ["Alex Russell"]

```

可以看到我们通过`addMethod`给example连续三次添加了一个`find`函数, 三个函数之间首要区别就是接受参数的个数不同. 而通过后面的调用发现, 我们成功的实现了不同个数传参对不同`find`的调用.

下面具体来探讨下, 这是如何实现的:

- **首先是添加部分:** 
  - 三次添加的`find`所指向的函数逻辑是相同的, 区别在于其`old`的指向是不同的, 第一次添加时没有`old`, `old`是undefined, 而第二次添加的时候`old`是指向第一次添加时的`find`的, 而第三次添加的时候`old`是指向第二次的`find`的;
  - 需要注意的是, 因为`old`的存在, `fn`这个变量在`addMethod`域内和`old`域内都是一直存在的(这里包含了一个闭包的实现 Closure):
    - 在`addMethod`域内因为每次其都会被调用更新, 所以三次添加后, 其指向的就是最后添加的那个函数, 本例中即两个参数的find;
    - 在`old`域内, 则会指向前一次的find, 本例中第三次添加的`old`的fn指向的就是第二次添加时`addMethod`传入的find函数, 即一个参数的;
  - 此外, 要记得`arguments.length`是我们传入的参数个数, `fn.length`则代表函数接受的参数个数;

- **下面我们看下三次执行:**
  - `example.find()`:  毫无悬念, 因为此时`fn.length`为2(`first`,`last`), 但是我们调用传入的`arguments`长度为0, 所以需要调用`old`, 即第二次添加的find函数, 此时`fn`也顺势切换到一个参数的函数, 但还是和`arguments.length`不同, 所以需要再次调用当前的`old`, 此时`old`指向的是第一次执行的`addMethod`, `fn`变为0参数,和`arguments.length`相同了, 我们就可以执行此时的`fn`了, 即返回example中的全部values的函数;
  - `example.find("Sam")`:  同上, 我们还是需要从`fn.length`为2的情况开始, 上溯到前一次, `fn.length`为1时, 符合条件, 执行此时的`fn`, 即根据`name`查询;
  - `example.find("Alex","Russell")`:  同理, 不过这一次就不用上溯了, 直接可以执行`fn`了;

通过在`addMethod`的赋值函数中加入`console.log`输出`fn`, 你会把这一过程理解的更为清晰.


## 总结

随着对JS的逐步深入, 越发觉得JS是一个很了不起的语言, 其兼容了Function Programming和OOP. 对开发者有一种极强的普适性, 可以很简单的写函数调用, 也可以实现很复杂的功能. 了不起!

为了缩短文章的长度, 我选择coffeescript来展示源码(可以省掉很多空间), 其实coffeescript真的很简单, 记住几个基本的规则, 理解起来很容易, 逻辑都还是js的逻辑. 有兴趣的可以查看我之前写的 <a href="{% post_path book-coffeescript-programming-with-jquery-rails-and-nodejs %}">CoffeeScript Programming with jQuery, Rails and Nodejs读书笔记</a>

## 参考文献

- [Secrets of the JavaScript Ninja][book]
- [CoffeeScript - 在线调试](http://coffeescript.org/)


[book]: http://book.douban.com/subject/3176860/ "Secrets of the JavaScript Ninja"
