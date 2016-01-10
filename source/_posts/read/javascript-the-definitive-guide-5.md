date: 2015-06-24 4:00:00
title: JavaScript the Definitive Guide (5)
category: read
description: 第十章, 正则表达式; 十一章, js的子集和扩展; 十二章, 走出浏览器的js.
tags: [js,reading notes]
series: Basic Guide for JavaScript
author: taoalpha
---

## 概述

在十到十二章中, 第十章的正则表达式内容最为丰富, 也是目前应用即为广泛的内容之一. 不过这里也主要是结合js的应用, 实际上正则表达式本身就是一个很值得研究的话题, 有不少书都在谈这个话题, 我后面要读的书目中恰巧就有这么一本, 后面会更加详细的学习以下正则表达式的方方面面.

十一章算是非常前沿, 高端或者说冷门的点了, 随着浏览器的盛行以及技术的进步, 安全问题始终都是一个很重视的点, 而在这种攻防演练中也促进了js本身的进步, 而主流浏览器本身更是走在了js的最前沿. 各种新的属性都是由他们引入而逐渐成为标准的;

十二章主要是对走出浏览器的JS做了一个简单的介绍, 而NodeJS的大名在近几年在前后端, 全端领域都可谓是人尽皆知. 我也会在之后阅读相关书籍的时候做更详细的笔记记录.

## 阅读笔记

### Chapter 10 - Pattern Matching Regular Expressions

- `normal repetition characters`:
  - `{m,n}` 匹配m-n次;
  - `{m,}` 匹配至少m次;
  - `{m}` 匹配恰好m次;
  - `?` 匹配0或1次;
  - `+` 匹配1或多次;
  - `*` 匹配0或多次;
- `Nongreedy repetition`:
  - `??`, `+?`, `*?` 在常规的匹配后加上`?`就能让匹配尽可能发生的短, 它会在允许范围内, 找到尽可能短的匹配;
- `Alternation, Grouping, Reference`:
  - `|` 表示匹配前者或者后者;
  - `(...)` 成组, 以组的形式来使用`*,+,?`等, 同时会记录组的匹配以用于`Reference`;
  - `(?:...)` 只是成组, 不记录匹配, 不能用于`reference`, 也不算做`reference`的序号中去;
  - `\n` 引用, n表示序号, 从1开始, 代表之前第几个group的匹配, 用于匹配开头结尾相同且多样的有奇效:`/(['"])[^'"]*\1/` 匹配单引号或者双引号内的内容;
  - 需要注意的就是, `reference`不能用于`[]`的`character class`之中!
- `anchor characters`:
  - `^`: 匹配开头;
  - `$`: 匹配结尾;
  - `\b`: 匹配词边界, `/\bJava\b/` => `Java`
  - `\B`: 匹配非词边界, ` /\B[Ss]cript\B/` => `JavaScript, postscript...`
  - `?=p`: 表示内容需要匹配p规则,但是返回的命中中不包含这部分;
  - `?!p`: 表示内容不匹配p规则;
- `flags`:
  - `i`: 大小写敏感, 即区分大小写;
  - `g`: 全局匹配, 默认是匹配首个;
  - `m`: 多行匹配;
- `String Methods for Pattern Matching`:
  - `search()`: 返回匹配词的位置或者-1代表无返回;
  - `replace()`: 支持正则匹配替换, 同时支持替换时使用`$n`代表是正则匹配的引用, 比如`text.replace(/"([^"]*)"/g, '“$1”');`即替换`""`为`“”`;
  - `match()`: 返回包含了匹配的结果, 返回结构为数组格式;
  - `split()`: 接受正则匹配作为其分隔符, 比如: `"1, 2, 3".split(/\s*,\s*/); => ["1","2","3"]`, 就去掉了本来直接`split()`多余的空格;
- `RegExp prototype method`:
  - `exec()`: 基本等同`match()`, 不过接受的是string类型去匹配, 而由正则去调用, 当表达式加了全局flag后, `exec()`每次执行会记录其上次匹配的位置并从此开始新的匹配, 比如:`var pattern = /Java/g;pattern.exec("JavaScript is more fun than Java!").indexpattern.exec("JavaScript is more fun than Java!").index`就会相继输出`0,28`两个位置;
  - `test()`: 用以检测表达式是否匹配了传入的string, 其执行逻辑(g模式下记录上次匹配位置)和`exec()`一样;

### Chapter 11 - JavaScript Subsets and Extensions

本章主要介绍一些目前主流浏览器支持但是还没有写入JavaScript官方版本中的一些js语言的子集(非官方版本)和扩展属性:

- `subsets`: 通常是为了确保不确定安全性的代码能够安全的运行而出现的(除了Crockford’s JavaScript: The Good Parts);
  - [ADsafe](http://adsafe.org), 最早一个因为安全因素设计的子集语言, 会禁止对绝大多数全局变量的访问;
  - [dojox.secure](http://www.sitepen.com/blog/2008/08/01/secure-mashups -with-dojoxsecure/): 算是[Dojo toolkit](http://dojotoolkit.org)的一个扩展;
  - [Caja](http://code.google.com/p/google-caja/): 其包含了两个子集, 一个是`Cajita`, 比较严格, 类似ADsafe 和 dojox.secure; 还有个是`Valija`, 则比较接近如今ECMAScript 5的`strict mode`了;
  - [Microsoft Web Sandbox](http://websandbox.livelabs.com/);
  - [FBJS](http://facebook.com): facebook使用的一个自己;
  通常子集都需要对应一个`verifier`, 来确保代码符合其要求;
- `extensions`:
  - `const`: 声明常量, 比如: `const pi = 3.14;`;
  - `let`: 块变量声明, 相当于缩小版的var, 作用域仅存活在最近的一个块结构里, 你可以用`{}`来自行创建一个block;
  - `destructing`: 允许多变量结构化赋值: `let [x,y] = [1,2];let [r,theta] = polar(1.0, 1.0); function polar(x,y){...};`甚至这种`all = [first,second] = [1,2,3,4];` 或者这种`let transparent = {r:0.0, g:0.0, b:0.0, a:1.0}; let {r:red, g:green, b:blue} = transparent;`;
  - `for/each`: 和`for/in`循环不同, `for/each`遍历对象的属性值而不是属性名, 且可操作类array对象;
  - `for/in`: 从js 1.7(mozilla的js引擎版本号)开始, `for/in`也不局限在array和常规object了, 只要是可循环的元素都可以使用了;
  - `yield`: 从python中引入的;
  - `Array Comprehensions`:  还是从Python中借用的, `let evensquares = [x*x for (x in range(0,10)) if (x % 2 === 0)]`;
  - `try/catch`: 支持多`catch`;

### Chapter 12 - Server-Side JavaScript

随着js的发展, 慢慢的超出了其本身的作用域: 浏览器. 随着Google V8引擎为js包入了unix的常用API: files,processes,streams,sockets等, js开始走出浏览器进入server端了. 正式命名为Node.JS. 想来很多人可能都听过, 因为后面我的数目中也包含了相关的书, 且本章内容也没见过太多, 所以就一起留到以后吧~

## 参考文献:

- [JavaScript the Definitive Guide 6th edition](http://book.douban.com/subject/5303032/)
