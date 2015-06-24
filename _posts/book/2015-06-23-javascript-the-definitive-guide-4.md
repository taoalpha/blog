---
layout: post
title: JavaScript the Definitive Guide (4)
category: book
description: 续前篇, 查漏补缺5-9章
tags: [js,reading notes]
series: The Way I Learn JavaScript
author: taoalpha
---

## 概述

第六版和第五版的最大区别在于ECMAScript 5的引入, 这是目前发布的最新的js版本, 有着最新的属性和函数, 目前主流浏览器基本都已经完全支持. 本文为阅读5-9章内容的笔记总结, 主要是覆盖了JS中的语句和典型对象.

## 阅读笔记

### Chapter 5 - Statements

- `switch/case`中使用的是`===`进行比较判断的, 而不是`==`;
- `with`带入`scope chain`的对象只有读取权限, 没有写入功能, 即`with`后, 可以获取其代入的对象, 但其内声明的变量都依然归于`gloabl`或者`local`之中;
- `debugger`是ECMAScript 5引入的一个新的`statement`, 起主要作用是和浏览器结合使用, 用于创建断点以便查错使用;
- `use strict`也是ECMAScript 5引入的, 严格来说不算`statement`而是`directive`, 不过两者很是相近; 其使用必须位于js整体的起始位置或者是一个`function`主体的起始位置;
- `use strict`的使用会开启代码的`strict mode`, 为了提升效率, 错误追踪以及更好的安全性, 其语法要求会更加严格, 简单列举如下:
  - 停用`with`语句;
  - 所有变量必须声明才能调用;
  - 所有独立声明的函数而非对象的方法定义的, 其`this`域都默认为`undefined`, 而函数如果通过`apply`,`call`调用, 其`this`域为传入对象;
  - 对未声明变量的赋值或者不能写入的对象进行写入, 都会抛出异常;
  - `eval`调用会自动创建临时局部`scope`, 不再能直接对母域新建声明了;
  - `arguments`成为传入参数的硬拷贝, 和传入参数名之间不在绝对相等, 即改变一方不会引起另一方的改变, 同时停用其`caller`,`callee`方法;
  - `delete`用于变量, 函数或者函数参数的时候会抛出异常, 操作对象的某个未声明属性也会抛出异常;
  - 对象(包括函数)创建中不能出现同名属性(参数);
  - 直接声明的八进制数是不允许的(即0开头的数字);
  - `eval`,`arguments`作为`keywords`对待, 不能赋值, 或赋予其他变量, 也不能用于`identifier`;

{% image 2015-06-23/javascript-statements.jpg alt="JavaScript Statements" title="JavaScript Statements" [no-autosize] %}

### Chapter 6 - Objects

- Property Attributes (ECMAScript 5之后引入可自定义配置, 之前默认三者皆有.)
  - `writable`: 可赋值;
  - `enumerable`: 可递归;
  - `configurable`: 可配置 - 可删除也可修改;
- Object Attributes
  - `portotype`: 指向当前对象的属性继承对象;
  - `class`: 指代对象所属类别;
  - `extensible`: 指示当前对象是否能够新增属性 (ECMAScript 5引入);
- Object Categories and Property Types:
  - `native object`: js中内置的对象, 包含`Arrays, functions, dates, regular expressions`等;
  - `host object`: 由js运行环境所定义的对象, 比如常见的浏览器, 就包含了`HTMLElement`对象;
  - `user-defined`: 执行js代码的时候创建的对象;
  - `own property`: 直接由对象中定义的属性;
  - `inherited property`: 由对象的`prototype object`继承来的属性;
- `Prototype`:
  - 任何一个对象(除了`Object.protytpe`)的出现都必然包含了第二个对象的存在: `new Array() => Array.prototype`;
  - `Object.prototype`是唯一一个没有母继承的对象了, 它是最顶部的类;
  - 类似`new Array() => Array.prototype => Object.prototype`这样的两个`prototype`就组成了`Array`的`prototype chain`;
  - `Object.create()` 是ECMAScript 5引入的新的创建对象的方法, 其接受两个参数, 第一个参数会作为新建对象的`prototype`传入, 第二个则是用来描述新对象的属性的. 如果你传入`null`, 则新建对象是完全没有`prototype`的, 只有`Object.create(Object.prototype)`才是等价于我们常用的`{}` or `new Object()`;
  - 获取某个object的未定义属性将返回`undefined`, 但是获取`undefined`或者`null`的某个属性则会抛出异常;
- `getter` && `setter`
  - ECMAScript 5新引入的两个`accessor properties`, 分别对应某个属性的调用和赋值;
  - 只有`setter`的属性只有写入权限, 只有`getter`的属性则是只读权限;
- `property attributes`
  - `value, writable, enumerable, and configurable`
  - 对应的`accessor property`: `get, set, enumerable, and configurable`
  - `Object.getOwnPropertyDescriptor(object_name, property_name)` 获取某个属性的特征描述;
  - `Object.defineProperty(object_name, property_name,{property_attribute:attribute_value})` 对某个属性设定其特征描述;

下例即为利用`Object.defineProperty`自定义的一个`extend()`函数:

{% highlight javascript %}
// Example 6-3. Copying property attributes
/*
* Add a nonenumerable extend() method to Object.prototype.
* This method extends the object on which it is called by copying properties
* from the object passed as its argument. All property attributes are
* copied, not just the property value. All own properties (even non-
* enumerable ones) of the argument object are copied unless a property
* with the same name already exists in the target object. */
Object.defineProperty(Object.prototype,
  "extend",
  {
    writable: true,
    enumerable: false,
    configurable: true,
    value: function(o) {
      // Define Object.prototype.extend
      // Make it nonenumerable
      // Its value is this function
      // Get all own props, even nonenumerable ones
      var names = Object.getOwnPropertyNames(o); // Loop through them
      for(var i = 0; i < names.length; i++) {
        // Skip props already in this object
        if (names[i] in this) continue;
        // Get property description from o
        var desc = Object.getOwnPropertyDescriptor(o,names[i]);
        // Use it to create property on this Object.defineProperty(this, names[i], desc);
      }
    }
  }
);
{% endhighlight %}

- Object Attributes;
  - `Object.getPrototypeOf()` ECMAScript 5引入, 可用于获取某个对象的prototype;
  - `p.isPrototypeOf()` 同上, 用于判断某个对象是否为另一个对象的prototype;
  - `Object.isExtensible()`,`Object.preventExtensions()`则分别是用于判断一个object是否是可扩展的, 以及禁止其可扩展性的(此操作不可复原);
  - `Object.seal()`类似`Object.preventExtensions()`, 不过它同时禁掉了`properties`的`configurable`属性,`Object.isSealed()`则是对应用于判断是否`sealed`的函数;
  - `Object.freeze()`比`Object.seal()`还要严格,所有属性都变为可读了, 对应的查询函数为:`Object.isFrozen()`;
  - `Object.preventExtensions()`,`Object.seal()`,`Object.freeze()`都是**只针对当前object而言的**;
  - `class`属性目前基本没啥用, 有点等价或者说更细化的`typeOf` or `instanceOf`了;

### Chapter 7 - Arrays

这里主要记录ECMAScript 5引入的一些新的方法, 3已有的可以查看[阅读笔记-2]({% post_url book/2015-06-18-javascript-the-definitive-guide-2 %}).

- `forEach(value,index,array_itself)`: `array`自身的循环调用函数, 相当于`for(i in array_name){}`, 区别在于其不支持`break`等可以跳出循环的语句, 如果你想要提前结束循环, 就需要通过`try/catch`包裹并利用抛出异常来结束循环;
- `map()`: 也算是循环的一种, 遍历每个元素并传递给传入的函数, 最终返回一个**新数组**;
- `filter()`: 顾名思义, 这是对数组进行筛选的, 值得一提的是`filter()`会自动跳过空白,所以对于稀疏数组通过`filter()`可以去除所有空白, 在加上`undefined`判断, 就可以去除所有空值了;
- `every()` 和 `some()`: `every()`是当数组每个元素都使传入函数为真的时候返回真, `some()`则是只要一个为真即返回为真, 需要注意的事, 对于空数组, `every()`会返回真, 而`some()`会返回为假;
- `reduce(function,initial_value)` 和 `reduceRight()`: 通过执行传入函数而对数组元素进行整合,计算,判断, 最终返回一个结果: `var max = a.reduce(function(x,y) { return (x>y)?x:y; });`即返回数组的最大值; `reduceRight()`与`reduce()`一致, 只是循环顺序相反, 从右到左; 当没有声明初始值时, 采用第一个执行元素作为初始值;
- `indexOf()` 和 `lastIndexOf`: 顾名思义, 获取数组中某个元素的index, 前者获取首个匹配元素的index, 后者获取最后一个匹配元素的index;

### Chapter 8 - Functions

- Functions的调用有四种:
  - 直接调用;
  - 作为对象的方法调用;
  - 作为constructor调用;
  - 通过`call`,`apply`方法调用(间接调用);
- `call()` 和 `apply`:
  - `call`和`apply`都是间接调用的方法, 允许一个函数临时客串为某个object的方法;
  - 一定程度上, 可以等价于`o.m = f;o.m();delete o.m;`
  - 其接受的第一个参数会成为函数运行的`this`域, 如果是非strict mode下, 传入`null/undefined`则会自动将global作为`this`, 而如果传入的是`primitive datatype`, 则自动转为对应的`wrapper object`, 即`string => String`;
  - `call`和`apply`的区别主要体现在后面的参数上, 前者以分散元素传入, 后者则以整体数组形式传入, 所以用`apply`可以把原本只支持不定长参数的函数转换为接受数组的函数:`var biggest = Math.max.apply(Math, array_of_numbers);`;
  - `apply`对类array元素处理方式同array元素;
- `bind()`: 很是类似`call`和`apply`, 本质也是把某个函数作为某个对象的方法调用, 实现则是通过把object和function绑定, 形成一个新函数从而每次调用新函数都等价于调用了`object.funtion`, `bind`接受多个参数, 其首个以后的参数都会作为`this`域成员代入函数中, 并按序成为函数自身的参数`function f(y,z) { return this.x + y + z };var g = f.bind({x:1}, 2);g(3) // 2被赋予了y, 新的3则给了z`;
- `higher-order function`: 作用于另一个函数之上的函数;

- `partial and memoization` 这两个都是`function programing`中常用的方法:
  - `partial`: 类似`bind()`这种会把传入参数默认分配到函数自身的部分接受参数上的做法就是`partial application`;
  - `memoization`: 将函数运行过程的计算结果缓存起来的方式;

{% highlight javascript %}
function array(a, n) { return Array.prototype.slice.call(a, n || 0); }
// 用以处理类array元素(转为真正的array)
function partial(f /*, ... */) {
  var args = arguments;
  // 存储partial的参数
  return function() {
    var a = array(args, 1);
    // 取出首位以后的参数
    var i=0, j=0;
    for(; i < a.length; i++)
      if (a[i] === undefined) a[i] = arguments[j++];
      // 这里的arguments是第二层参数
      // 将空元素逐个替换成第二层参数里的值, j自动随着执行+1
    a = a.concat(array(arguments, j))
    // 组成新的参数数组
    return f.apply(this, a);
    // 调用f函数, 并传入参数a
  };
}

var f = function(x,y,z){return x*y*z}

partial(f,undefined,2)(1,3)
// x:1,y:2,z:3

{% endhighlight %}

{% highlight javascript %}
// Return a memoized version of f.
// It only works if arguments to f all have distinct string representations.
function memoize(f) {
  var cache = {};
  return function() {
    var key = arguments.length + Array.prototype.join.call(arguments,",");
    if (key in cache) return cache[key];
    else return cache[key] = f.apply(this, arguments);
  };
}

// 应用方式类似;
var factorial = memoize(function(n) {return (n <= 1) ? 1 : n * factorial(n-1); });

factorial(5) // 此时会自动缓存4,3,2的阶乘值. 对于一些复杂的运算, 如此可以很好的加快运算速度.

{% endhighlight %}


### Chapter 9 - Classes and Modules

除了[阅读笔记-2]({% post_url book/2015-06-18-javascript-the-definitive-guide-2 %})中包含的, 由于ECMAScript 5所引入的那些`object property`自然都可以应用到新的class中, 从而创建更为复杂有效的函数. 其实js中目前不存在class这个关键词, 所以其模仿的class, 说白了就是一个复杂一些的函数对象.

而因为其内容驳杂繁多, 我么会在后面的应用中有很多实践的机会, 这里就不一一描述了.

## 参考资料

- [JavaScript the Definitive Guide 6th edition](http://book.douban.com/subject/5303032/)
- [Functional Javascript](http://osteele.com/sources/javascript/functional/)
