category: read
description: ''
date: 2015-03-08 3:00:00
title: What is Pythonic?
tags: [python,翻译文章,pythonic,coding,译系列]
---

<p>[缘起] python算是我最常用的语言之一了, 随着最近对自身定位的思考以及抉择, 我也开始逐渐加深自己对知识领域的纵深了解了. 所以开始有意识的去更加全面, 深入的了解一些喜欢的东西, 正如福尔摩斯所言: 人类的大脑是有限的, 我们应该尽量装入更多的有价值的东西, 而不能让无意义的东西占据有限的空间. 又扯远了... Pythonic是最近看到的一个名词, 于是简单做了下搜索, 查到了一个05年的定义, 考虑到虽然时间有点久远, 但是本身pythonic的基本没有多少变化, 所以还能勉强拿来借鉴的.</p>

<p>作者写文本是回答一个在EuroPython会议邮件中的同一个问题. 考虑到这是个很有趣的问题, 而且作者本身也已经见过多次pythonic这个词语, 却一直没怎么看到过一篇很详细的解释, 所以作者写本文总结了自己以及其他人对这一名词的理解.</p>

<p>[正文]  pythonic是一个很模糊的概念, 但又不至于像"智慧"或者"生命"那种你完全无法准确定义的模糊. 但是无法被定义不代表他们就是无用的, 尤其是人类本身对于这种模糊定义的事情非常擅长. Pythonic 的意思是"易读易于人类理解的Python",  下面我们则针对它的意思进行简单的介绍.</p>

<p>随着时间, Python在逐渐的发展, Python社区也在逐渐的成长, 于是出现了很多关于如何正确的使用python的想法. 而python本身也非常鼓励用多样的风格方法来实现各种任务. 而新的风格方法也会反过来帮助python社区以及python语言的发展. 举个简单的例子就是dictionary对象的<code>.get()</code>方法, 它结合了对象的读取和<code>has_key()</code>函数的调用这本来需要两步完成的操作.</p>

<p>很多时候有些风格方法也不完全是直接从其他的语言中借用来的. 以C语言中的列表元素循环为例, 下面是在C语言中的写法:</p>


``` css
for (i=0; i &lt; mylist_length; i++) {
    do_something(mylist[i]);
}
</code>
```


<p>而直接转换到Python中会是如下写法:</p>


``` css
i = 0
while i &lt; mylist_length:
   do_something(mylist[i])
   i += 1
</code>
```


<p>虽然这样写也没有错, 但是通常我们不认为它符合Pythonic的原则. 这绝不是python语言所鼓励的风格. 我们可以进行一些修正. 通常来说, python中建议用内置的<code>range()</code>函数来生成一个纯数字的列表:</p>


``` css
for i in range(mylist_length):
     do_something(mylist[i])
</code>
```


<p>但是这样也不能算是pythonic. 那么符合pythonic的方式是如何写呢? 如下所示:</p>


``` css
for element in mylist:
    do_something(element)
</code>
```


<p>在comp.lang.python 上有一个常见的问题是如何传递以及直接修改引用, 而这本身在python中是不能实现的, Python中只有assignment(类似import, class以及def这类). 很多时候, 我们会希望在自己写的函数中返回多个值. 那么在C语言或者其他很多语言中推荐的方式都是传递指针或者引用到函数中去:</p>


``` css
void foo(int* a, float* b){
    *a = 3;
    *b = 3.5;
}

...
int alpha;
int beta;
foo(&amp;alpha, &amp;beta);
</code>
```


<p>在Python中也确实可以利用一些策略实现把函数返回结果赋值给变量 , 比如:</p>


``` css
def foo(a, b):
    a[0] = 3
    b[0] = 5.5

alpha = [0]
beta = [0]
foo(alpha, beta)
alpha = alpha[0]
beta = beta[0]
</code>
```


<p>但是这种用法就相当的不pythonic了, 我们通常可以直接使用更好的方法, 利用数组:</p>


``` css
def foo():
    return 3, 5.5

alpha, beta = foo()
</code>
```


<p>对于那些不那么pythonic的代码, 那些有经验的python程序员是很容易可以看出来的, 因为这样的代码往往会比较奇怪或者粗糙笨重. 往往还会感觉非常冗余, 难以理解, 尤其是和使用正常的, 推荐的, 简介的方法相比.  而且语言本身也是为了支持正确的风格方法,  所以那些不好的方法执行速度也会很慢.</p>

<p>那么如何做到pythonic呢? 简单说就是要保证结构和数据结构都简介, 高可读性. 只在需要时为实例生成动态的类型而不是到处定义冗余的变量. 而遵循pythonic的优势之一也是为了不给那些有经验的python程序员带来因为陌生代码而引起的不必要的麻烦...</p>

<p>pythonic除了在这种低效风格上外, 还有很多别的用处. 比如对于一个library或者框架而言, pythonic就意味着简洁自然, 能够让一个python程序员很容易的使用. 通常一个用python写的library或者框架,  如果不能有效的帮助程序员写出优质的python代码也会被认为不算是pythonic.  可能是因为它没有使用python提供的一些结构, 比如类啊, 虽然有时候这样做能够让library更加便捷或者更加容易理解.  有时候利用类似可以把函数作为参数传递给函数的方法也能够带来很多帮助的.  在一个library的类中, 有时候你可能会像在Java中那样去隐藏一些信息, 但是在Python中则相对更为宽松, 属性默认是开放的但是程序员可以通过前置下划线来声明其私有属性.</p>

<p>当然, 当你达到使用libraries和框架的境界前,  有时候判断是否符合pythonic会更加困难或者界限模糊. 但是我们依然有一些原则可以借鉴. <strong>其中之一就是尽量简洁, 避免废话</strong>: Python的接口跟倾向于小而轻, 尤其是和Java的相比起来. Python中那些有着非常详尽的复杂的API通常被认为不那么的Pythonic. 比如W3C XML DOM API就是个典型的例子. 有一些人认为它很像JAVA的风格, 但是实际上就我所了解的, 很多JAVA的程序员也并不是很认同这是JAVA风格的.</p>

<p>一个基于Python的框架只要不是在重造轮子的话倒是可以被认为是pythonic的, 当然它也要符合python的一些通用方法. </p>

<p>当然问题在于框架既然被称为框架, 不可避免的会引入一些模式或者方法是那些习惯小型应用的所不熟悉的. 这也是你发挥一个框架的为例的途径. 比如我比较熟悉的一个Zope 2的框架, 就是一个典型的例子, 它引入了很多你平时不会经常使用的方法. Acquisition就是一个典型例子, 但这样的结果就是Zope 2在很多有经验的python程序员眼中是不符合Pythonic的.</p>

<p>想要创造一个pythonic的框架是很困难的. 这一点和如今Python本身越发完善, 优秀无关. 有一些诸如generator, set, unicode string和datetime的功能都已经被认为算是pythonic的了. Zope 2则是一个过于年轻的框架, 所以一定程度上到也不能责怪它, 毕竟它是97年才创造的. 考虑到这一点, 它已经很不容易啦.</p>

<p>近些年来通过我自己的观察, 是可以找到一些pythonic下的新趋势的. 尤其是基于一些标准的常用python库的发展来看. 比如Twisted, Zope 3, 以及PyPy他们都或多或少的遵循这下面这一模式:</p>

<ul>
<li>模块名称简洁, 基本使用小写, 单数形式;</li>
<li>包名称通常只是包名, 基本都有一个空的<strong>init</strong>.py文件.</li>
</ul>

<p>我也沿用了同样的方式在我写的lxml库中.</p>

<p>有时候我认为把一个软件直接谴责其不够pythonic是一件不公平的事情, 因为有时候会影响人们看到它更有价值的一面. 一个功能不那么强大的框架往往更加容易去学习和使用, 而那些符合pythonic的框架有时候往往反而需要花费更多的时间.</p>
