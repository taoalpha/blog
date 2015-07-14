---
layout: post
title: JavaScript the Definitive Guide (2)
category: book
description: 学习JS中的一等公民 - function. 也是本书第八章内容的一些心得和笔记分享.
tags: [js,reading notes] 
author: taoalpha
series: Basic Guide for JavaScript
---

## 概述

作为JS中的一等公民, `function`(函数)始终是JS的核心中的核心. 所以这里单独用一篇笔记来记录`JavaScript: the definitive Guide`一书第八章的内容. 主要介绍了函数的定义, 作用域, 参数, 声明以及执行等基础知识, 另外也着重介绍了其高级用法中的`closure`. 我将自己觉得重要的, 值得记录的部分都作为心得摘抄如下:

## 心得

### arguments对象

对每一个function而言, 都自动会有一个内置的`arguments`对象, 用它就可以访问传入的参数了. 通常来说`arguments`对象我们只会用在不定长传参的函数上, 但`arguments`本身带有的一个函数却是可以在某些时刻发挥重要作用的~ 这个函数就是`callee`函数:

{% highlight javascript %}
// 递归自我调用函数在解决一些问题的时候是很常用的, 而通常情况下我们都会在函数内调用本函数名即可, 但是如果我们需要实现自我调用的函数正好是一个无名函数呢?

// arguments.callee 即调用当前执行的函数

function(x){
return x*arguments.callee(x-1)
}
// 如上, 就实现了一个很简单的>2阶乘计算了

{% endhighlight %}

需要特别注意的就是`callee`作为`arguments`对象的一个方法, 是可以跟随`arguments`作为参数传递的, 而且其作为参数的时候保持其所指代函数不变.

既然说到`arguments`, 就多说两句喽. 首先`arguments`算是一个类array的object. 它本身具有array的一些特性, 比如可以直接调用length函数(通常的object是不能通过`.length`直接调用获取长度的, 需要使用`Object.keys(object_name).length`才能获得). 但是它本身和`array.length`有很大的差别, 其中最大的一个差别就是: 无法通过`.length`直接更改数组长度.

{% highlight javascript %}
var a = [1,3,4]
a.length = 5
console.log(a)
// output: [1,3,4,undefined x 2]
(function(x){arguments.length = 5;console.log(arguments)})(10,1,2)
// output: [10,1,2]
{% endhighlight %}

可以看到通过对`arguments.length`直接赋值, 并不会影响其本身的长度, 这一点和array本身有很大的差别.

PS. 上述示例是增加长度, 其实缩减长度也是一样的, 多余的元素会被自动删除. 所以, 通过直接向`array.length`赋值也算是一个修改`array`长度的方法喽~

PSS. 通常如果一个函数接受参数比较多的时候, 为了预防因为参数顺序而产生的问题, 可以采取传json格式的object作为参数, 这样就能够通过key而不根据顺序获取参数了.

### Function的property

请先看下述代码:

{% highlight javascript %}
f.temp = "test"

function f(x){
  console.log(arguments.length);
  console.log(arguments.callee.length);
  console.log(f.temp);
}

f(1,2)

// output: 2 1 "test"
{% endhighlight %}

首先, 我们看一下我们前两个输出值:

  如上所述,`arguments.length`即代表传入参数的数量, 我们传入了两个参数, 所以这里输出2, 没有任何问题. 那么后面的`arguments.callee.length`又是什么呢? 为什么它输出的是1呢? 
  
  根据之前的介绍, 我们当知道`arguments.callee`是代指当前的函数`f()`, 那么对应的`arguments.callee.length`即我们的函数`f`的length了. 对于`Function`这个对象而言, 它所拥有的`length`这一属性特指其声明的参数数量, 我们应该知道JavaScript作为一个很宽松的语言, 其函数定义后接受的参数是不定长的, 即便传入参数与函数声明的参数不相等也是不会抛出异常的, 那么有时候我们需要获取确保函数接受的参数和其声明的参数数量一致, 就可以使用函数自身的length属性来实现;

其次, 我们自定义了一个`f`的属性`temp`, 但是我们实在函数定义之前赋予这个属性的, 为什么依然能够在函数运行中输出呢? 

  这主要是因为js的执行顺序所致. js在载入执行过程中, 首先会将内部声明的函数都定义之后才会正式由上至下的逐次执行. 所以这里虽然我们把`f.temp`写在了函数定义之前, 但是js执行过程中, 还是首先定义了函数`f`, 接着才开始运行我们的`f.temp`赋值语句. 自然就不会报错说`f`没有定义了~

PS. 其实不止是Function, 即便是普通的变量声明, 也是编译和执行分开进行的, 比如`var a = 2;`也是拆解为`var a; a = 2`两步执行的, 而声明都是发生在编译过程, 待编译过程全部结束后, 才会由上到下一次执行, 这也是为什么, 单纯的声明可以出现在代码的任意部位都不会影响其所在作用域的生效, 不会爆出`not defined`的错误;


### reserved word, identifier, keyword

这三个作为基础知识, 可以说是每门语言都共通的概念,  但很多时候我们都不会用到或者不会特意去区分这三个名词, 而最近因为看原版书, 经常会出现三个词的交叉, 所以这里特别google了以下, 试图总结下三者的区别:


- **identifier:** 通常我们把我们定义的变量名, 函数名, 类名, 标签名,宏定义名, 类型名等称为`identifier`, 取其标识之意, 用以作为其名称以便代用;
- **reserved word:** 与`identifier`相对, `reserved word`则是指由语言规定而保留的一些词, 这些词有着特定的用途而不能被用作`identifier`;
- **keyword:** 作为语言语法的组成部分之一, `keyword`通常都会有着特定的含义, 绝大多数的`keyword`都是`reserved word`, 但也有少量语法中存在`keyword`不是`reserved word`的情况, 比如`fortran`就没有`reserved word`的概念, 它的所有`keyword`都可以用作`identifier`;

`reserved word`和`keyword`确实在很大程度上是共同的, 除了上述说的类似fortran语言这种情况外, 也存在`reserved word`不是`keyword`的情况, 比如[java中的`goto`就是一个`reserved word`, 但本身又不是一个`keyword`, 所以可以说`goto`这个词基本在java中是完全废弃的][1]~ 那他们为啥要定义这个`goto`呢?? [有一种说法是这样情况通常是为未来版本预留的~ 还有一种说法是JVM作者**James Gosling**最初加了`goto`的支持, 但后来发现完全没必要, 就又去掉了, 但是为了兼容性问题,也一直没有把`goto`从`reserved word`此表中删去.][2]

PS. 很多时候也有人完全不区分`reserved word`和`keyword`的区别, 完全等同二者为"不能用来做`identifier`的词".

### closure - 闭包

在javascript中, 一个`function`由两部分组成: 函数执行的代码以及代码执行的环境. 而这两个组合到一起后也有个专属的名称, 即`closure`. 不过单独一个独立函数的`closure`并没有什么值得说的意义, 因为其执行的环境, 即我们称之为`scope`的东西, 随着函数的执行开始与结束会自动的被创建并清理掉, 所以通常情况下`closure`都单指在嵌套函数中. 当存在嵌套的函数时, 并且函数之外存在一个`reference`指向函数的话, 事情就变得好玩多了:

{% highlight javascript %}

function f(){
  var id = 1;
  return function(){console.log(id++)}
}

f()();f()();f()()
// output: 1,1,1
// 每次我们调用`f()`,都会自动创建一个包含了其局部变量`id`的对象, 而嵌套的函数`f()()`会自动继承母函数的作用域;
// 但每次随着调用结束, 因为没有任何外部引用, 所以创建的对象都会自动的被回收, 如此就导致每次调用`f()()`都会输出1了;

var k = f();
k();k();k()
// output: 1,2,3
// 同样是调用`f()`, 但是我们首先引入了一个新的变量`k`引用`f()`函数; 
// 这样随着`f()`的调用和结束, 其创建的`call`对象(即包含了局部变量id的那个对象)就因为还存在外部引用而得以保留
// 所以后面连续调用`k()`的过程中, 本身的嵌套函数就始终共享着`call`对象的作用域, 如此每次输出的时候都是先获取了局部变量id, 然后在执行`id++`,所以输出为1,2,3

// 不喜欢`f()()`这种调用方式, 也不想单独创建新变量来增加引用? 当然可以, 只需要借助下`anonymous function`即可:

var f = (function(){
    var id = 1;
    return function(){console.log(id++)}
  })();

f();f();f()
// output: 1,2,3
// `anonymous function`是自执行的函数, 这里相当于把之前的`var k = f()`以及`f()`的声明定义合二为一了.

{% endhighlight %}

可以说上述基本就是`closure`最基本的内容了, 而`closure`作为js的高级用法之一, 掌握了它, 你就能做很多有意思的操作了. 一个简单的例子就是: [你可以参照closure的原理来模拟实现浏览器探查元素(inspector)的breakpoint功能.][3]

因为原作`trimpath`上的文章已经无法访问, 所以转载了一个类似的如下, 略作了简单的修改(加了几句更友好的提示和显示每一步的运算结果):

{% highlight javascript %}
// This function implements a breakpoint. It repeatedly prompts the user
// for an expression, evaluates it with the supplied self-inspecting closure,
// and displays the result.  It is the closure that provides access to the
// scope to be inspected, so each function must supply its own closure.
// 
// Inspired by Steve Yen's breakpoint() function at
// http://trimpath.com/project/wiki/TrimBreakpoint
//
function inspect(inspector, title) {
    var expression, result;

    // You can use a breakpoint to turn off subsequent breakpoints by
    // creating a property named "ignore" on this function.
    if ("ignore" in arguments.callee) return;

    while(true) {
        // Figure out how to prompt the user
        var message = "";
        // If we were given a title, display that first
        if (title) message = title + "\n";
        // If we've already evaluated an expression, display it and its value
        if (expression) message += "\n" + expression + " ==> " + result + "\n";
        else expression = "";
        // We always display at least a basic prompt:
        message += "Enter an expression to evaluate, or just click cancel to see the next step of current calculation.";

        // Get the user's input, displaying our prompt and using the
        // last expression as the default value this time.
        expression = prompt(message, expression);

        // If the user didn't enter anything (or clicked Cancel),
        // they're done and so we return, ending the breakpoint.
        if (!expression) return;

        // Otherwise, use the supplied closure to evaluate the expression
        // in the scope that is being inspected. 
        // The result will be displayed on the next iteration.
        result = inspector(expression);
    }
}

function factorial(n) {
        var inspector = function(x) {
                return eval(x);
        }
        inspect (inspector, "Entering factorial()");
        var result = 1;
        while (n > 1){
                result = result * n;
                n--;
                inspect(inspector, "factorial() loop with current result:"+result);
        }

        inspect(inspector, "Exiting factorial()");
        return result;
}
inspect(function (x) {return eval(x);}, 'Hello')

factorial(5)

// 通过closure, 它就可以检测factorial执行的各个环节, 从而更容易的找到你在不同环节的问题.

{% endhighlight %}

虽然`closure`让你可以写出更加复杂的js代码, 但是本身`closure`的使用还是要慎重的, 因为`closure`需要存储函数对象在内存中而不销毁, 所以如果函数主体庞大, 那么对于内存的压力和运行性能都是会有影响的~

### Function constructor

类似Array, String等都有着一个对应的类, 可以允许你通过`new`来创建对象. Function也有自己对应的`Function()`类, 可以通过:`new Function()`来创建函数, 其接收不定长参数, 最后一个参数始终作为函数运行主体. 不过通常来说这种方法定义函数远没有我们常用的`function`关键词来的方便, 所以使用上倒是少了很多~ 不过有几点还是值得注意的:

- new ClassFunction() 是把function作为constructor的一种用法, 你可以简单的理解为: `var cc = new ClassFunction(params)` ==> `var cc = new Object();ClassFunction.call(cc,params)`
- `new Function()`不接收函数名参数, 即其创建的都是`anonymous function`;
- `new Function()`不继承作用域, 几遍其是在嵌套函数中定义, 也只继承global域, 不会继承上层函数的作用域;

## 谜题

{% highlight javascript %}
var name = "The Window";
var object = {
  name : "My Object",
  getNameFunc : function(){
    console.log(this);
    return function(){
      return this.name;
    };
  }
};
console.log(object.getNameFunc()());

// output: Object{name:"My Object"}; "The Window"
{% endhighlight %}

上述定义中, 为什么嵌套函数没有继承上层函数的`this`呢? 反而继承了全局的`this`?

**猜测解答:** `this`这个关键字是个比较特殊的关键字, 它具有一个很有趣的特点就是: 当一个函数作为函数而不是方法来调用的时候, `this`指向的是全局对象, 只有当它是方法的时候, 其指向的才是所属对象; 题目来源[阮一峰博客][4]. 

[1]: https://en.wikipedia.org/wiki/Reserved_word "reserved word - wiki"
[2]: http://stackoverflow.com/questions/2545103/is-there-a-goto-statement-in-java "why keep the goto in java"
[3]: http://jmvidal.cse.sc.edu/talks/javascript/breakpointsusingclosures.html "Breakpoints using javascript closures"
[4]: http://www.ruanyifeng.com/blog/2009/08/learning_javascript_closures.html "Issue 1"
