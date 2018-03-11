date: 2015-07-12 3:00:00
title: JavaScript 闭包(Closure)初探
category: tech
description: 在上篇重载的介绍中提到了Closure的概念, 正好今天看到Ninja中介绍Closure的这部分, 所以今天梳理记录下.
tags: []
author: taoalpha
---

## 缘起

 在上篇重载的介绍中提到了Closure的概念, 正好今天看到Ninja中介绍Closure的这部分, 所以今天梳理记录下. Closure作为JS的高级用法之一, 对于JS开发而言有着极为重要的作用.

## Closure

### Closure的结构

什么是Closure? 更精确的说: 什么是JavaScript里面的Closure? 

> a closure is the scope created when a function is declared that allows the function to access and manipulate variables that are external to that function. 

上面是Ninja一书中对Closure的定义. 难懂吗? 应该不算难懂, 核心关键词就是: scope, function, access, manipulate, variables, external

即一个Closure代指的是一个scope, 一个js的小型工作环境, 这一环境是随着一个函数的声明而出现的. 但是所有函数都会伴随着closure吗? 当然不是, 对于这种函数有特定的要求, 就是这个函数本身可以访问并且修改该函数外部的变量. 只有具备此性质的函数才伴随着Closure的出现.

还是很难懂? 举几个例子:

- **在浏览其中, 我们定义的一个单纯的全局函数, 会伴随closure的出现吗?**

   答案是肯定的, 根据上述定义, 我们的全局函数是可以获取并操作其之外的变量的, 通常我们称为全局变量(定义在window对象中的变量);

- **那有啥函数不伴随Closure出现吗?**

   有, 我们可以认为window顶层是一个函数, 这个函数本身就没有外部的函数了, 自然也就没有Closure了.

- **如此一来, Closure岂不是随处可见? 那还有什么意义?**

   Closure确实随处可见. 但也正因为随处可见, 我们就会在clsore发现closure的嵌套, 我们可以在全局closure下, 定义我们自己的closure, 而利用closure的性质形成一个个小型的scope, 如此就可以构建并指定甚至操作我们的函数执行环境, 从而实现很多非常了不起的功能了.

### 如何理解Closure

- Closure 相当于一个保护罩, 其会在closure声明的那一刻为当前的scope(即此刻scope下所有的变量, 函数等, 即便他们是在closure之后声明或者是closure接受的参数)创建一个特殊的环境而不会收到垃圾回收的回收, 其存活周期完全依赖于closure自身的寿命;
- 在浏览器环境下, 即便是全局定义的函数其实也是在一个大的closure之中的, window则是这个closure中的核心对象;

### Closure的用法

- Closure 通常的用法:
  - 封装私有变量: 一个函数内部定义的变量, 只有内部才能访问, 所以一个函数内部的函数(closure)就可以访问这个函数定义的局部变量;
  - callback和timer函数中的应用: 对于嵌套在函数中的callback以及timers函数, 都可以访问函数内部定义的变量的, 虽然他们的context(this)通常都指向的是window全局对象或者某个特殊对象(比如jQuery.ajax的callback的this就是ajax构成的对象); 同时利用这一特点将变量定义在函数内来避免污染全局变量;
  - 改变函数工作环境(context), 在一定程度上它和`apply`,`call`的逻辑一致, 典型应用即Prototypt库中的bind函数(JS1.8.5以后就默认添加了bind函数), 详见下文;
  - 部分传参: 和上述中介绍的bind同理, 区别在于对参数的处理上, 部分传参的时候, 第一次传参可以传递部分参数, 希望之后补充的参数可以预置为undefined, 而在返回函数中, 也不是单纯的合并两次参数, 而是递归之前的传参, 将undefined的参数补上;
  - 重写函数: 利用closure可以对一些函数进行新的重写, 比如下例中的`memoize`函数;
  - 结合匿名自触发函数: Closure和`(function(){})()`的结合自然可以带来更多的想象力;

``` coffeescript
do ->
 c = 1
 $.ajax 
    url: "http://taoalpha.github.io/blog/api/latest.json"
    dataType:'json'
 .done (data)->
    console.log(this)
    console.log(c)
    console.log(data)

do ->
  cc = 1
  timer = setInterval ->
    if cc < 3 then console.log("cc#{cc}");console.log("this#{@}");cc++ else clearInterval timer
  ,1000


Function::bind ->
  # console.log arguments
  fn = @; args = Array::slice.call(arguments);object = args.shift()
  # 此处将传入参数拆解, 默认第一个为要绑定的对象
  ->
    # console.log arguments
    fn.apply object,args.concat Array.prototype.slice.call(arguments)
    # 这里返回一个新的函数, 新函数唯一的功能调用绑定函数(fn), 并传入绑定中除了object以外的参数(args)和调用传入的参数(这次的arguments)
    # 部分传参中这里需要做参数处理:
    # arg = 0
    # for i in [0..args.length] when arg < arguments.length
    #   if args[i] == undefined
    #     args[i] = arguments[arg++]
    # fn.apply @, args



# 利用Closure包装缓存函数 memoized 
Function::memoized = (key) ->
  @_values = @_values || {}
  if @_values[key]? then @_values[key] else @_values[key] = @.apply(@,arguments)

Function::memoize = ->
  fn = @
  ->
    fn.memoized.apply fn,arguments

isPrime = ((key)->
  prime = num != 1
  for i in [2...num] when num % i ==0
    prime = false 
  ).memoize()

# 利用自触发函数和closure来处理closure中的递归指数

divs = document.getElementsByTagName('div')

for i in [0...divs.length]
  divs[i].addEventListener 'click',->
    alert "divs ##{i} was clicked"
  ,fasle
## 如此执行的结果就是无路你点击哪个div, 都会显示的是 "divs #{divs.length} was clicked",因为这里的i被保存了, 始终指向最后一个循环值

for i in [0...divs.length]
  ((n)->
    divs[i].addEventListener 'click',->
      alert "divs ##{i} was clicked"
    ,fasle
  )(i)

通过closure, 我们把每次传入的i都单独用另一个私有变量n存储起来, 这样每个div对应的指数就是唯一的了


```

## 谜题

- **Q:** 那么bind和call,apply的区别又是什么呢? 与其使用`fn.bind(object)`, 为什么我不是用`fn.apply(object)`或者`fn.call(object)`呢?

**A:** 

> - bind returns a function which will act like the original function but with this predefined. It is usually used when you want to pass a function to an event handler or other async callback.
> - call and apply will call a function immediately letting you specify both the value of this and any arguments the function will receive.
> - bind和apply,call最大的区别就在于bind返回一个函数, 而apply, call则是执行一个函数. 所以bind通常用在一些异步事件处理中;

## 参考资料

- [Secrets of the JavaScript Ninja](http://book.douban.com/subject/3176860/)
- [CoffeeScript - 在线调试](http://coffeescript.org/)
- [what's the difference between 'call/apply' and 'bind'](http://stackoverflow.com/questions/15677738/whats-the-difference-between-call-apply-and-bind)



