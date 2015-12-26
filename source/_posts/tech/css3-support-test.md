date: 2015-05-30 8:00:00
title: HTML5以及CSS3兼容方法
category: tech 
description: 随着H5以及CSS3的盛行, 大家逐渐体会到了其带来的巨大好处, 但是依然有着一些顽固分子不支持新属性... 而身为开发者我们又不能决定用户用什么浏览器... 只能默默自己写检测代码校验了..
tags: [fallback,css3,html5] 
author: taoalpha
---

## 为什么做兼容性

H5和CSS3的出现可以说是广大网页开发者的福音啊, 但是依然有一些浏览器中的顽固分子对两者的支持不够, 而用户的选择又不是我们所能决定的, 所以我们只能默默的想办法来检测用户的浏览器对新属性的支持.

coding有个很重要的环节就是fallback. 你不能为了用新特性就不管老版本了~ 所以无论是软件开发还是网站开发, 都讲究向下或者向前的兼容性. 那么, 我们在使用html5和css3的时候, 如何做fallback呢?

## 如何做兼容性检测

基本思路都一样: 增加检测代码来预判浏览器对属性的支持度. 而具体的实现方法呢, 则有以下几种:

### 现成的三方库[Modernizr]:

  写代码有个好习惯就是除了自己研究目的之外, 很多时候遇到问题都可以先Google以下, 很多问题很多人都遇到过并且有了对应的解决方法, 我们就不用再造轮子了~ 当然, 如果你看了轮子以后觉得可以造一个更好的, 那自然是另一回事了~

  H5和CSS3的兼容性也是如此, 已经有一些现成的库可以满足我们的需求了, 为了省事, 你完全可以拿来直接用. 比如下面这个目前最流行的检测库:[Modernizr].

  [Modernizr]的功能就是检测当前浏览器对HTML5和CSS3各个特性的支持情况, 你可以通过[Modernizr的Doc]查看其检测属性的列表以及使用方法. 当然, 如果你想更进一步的理解[Modernizr]的运行原理, 还可以去[Github/Modernizr]上查看其源码~ 当然, Modernizr主要提供的兼容性的检测, 其可以输出一个Modernizr的Object, 其中包含了其对所有属性的检测结果. 比如我在chromium下的检测结果为(部分):

``` json
{
    "touch": false,
    "postmessage": true,
    "history": true,
    "multiplebgs": true,
    "boxshadow": true,
    "opacity": true,
    "cssanimations": true,
    "csscolumns": true,
    "cssgradients": true,
    "csstransforms": true,
    "csstransitions": true,
    "fontface": true,
    "localstorage": true,
    "sessionstorage": true,
    "svg": true,
    "inlinesvg": true,
    "_version": "2.6.1",
    "_prefixes": ["", "-webkit-", "-moz-", "-o-", "-ms-", ""],
    "_domPrefixes": ["webkit", "moz", "o", "ms"],
    "_cssomPrefixes": ["Webkit", "Moz", "O", "ms"],
    "blobbuilder": false,
    "blob": true,
    "bloburls": true,
    "download": true,
    "formdata": true
}
```

### 自定义检测:

  有时候我们不需要Modernizr这么齐全的检测结果, 我们可能代码中只用到了某些属性, 所以我们只需要针对这些属性的检测即可, 如何做呢? 其实很简单, 只是因为不同的属性的检测方法不一样, 所以具体情况需要对应的改变, 这里以颜色选择器为例:

``` javascript
// 检测是否支持html5的新input类型,以颜色为例
function hasColorSupport(){
input = document.createElement("input"); input.setAttribute("type", "color");
var hasColorType = (input.type !== "text"); // handle Safari/Chrome partial implementation if(hasColorType){
var testString = "foo"; input.value=testString;
hasColorType = (input.value != testString);
  }
  return(hasColorType);
}
// 选自<<HTML5 and CSS3 >>一书

```

其实所有检测的原理是一样的, 就是利用js来创建对应的元素给予对应的属性, 然后检测对应应该生效的项目即可.

_哈, 有个好消息就是[Modernizr]最新的3.0.0版本开始支持自定义了~ 你可以在其[官网页面](http://v3.modernizr.com/download/)选择自己需要的属性和扩展函数, 然后就能生成你需要的Modernizr了_

## 兼容性支持

  既然检测了兼容性, 那么下一步就是兼容性的支持了. 其实对这一点, 有一个专有的名词描述的: Polyfills.

### Polyfill

  Polyfill是专门用来形容用来替代原生API函数以支持跨平台的函数. 目前基本现有的H5,CSS3的各个属性差不多都有人写了对应的Polyfill, 有的还不止一个呢~哈哈 而[Modernizr]和Polyfills的结合就能够让你不止检测浏览器对新属性的支持, 甚至还能在不支持的情况下调用对应的Polyfills来给予支持. 赞!

  在[Github/Modernizr]的[wiki](https://github.com/Modernizr/Modernizr/wiki/HTML5-Cross-browser-Polyfills)中详细的介绍和目前主流的一些polyfills, 尽情享用吧~哈哈

### 范例介绍

  像[FlashCanvas](http://flashcanvas.net/)就是专门针对canvas元素的Polyfill. 除了这种专门针对一个元素的polyfill, 其实也存在如[html5shiv](https://github.com/afarkas/html5shiv)这种支持整个html5主要元素的大库. 当然, 同样的, 请根据你自己的需求来选择使用~


哈哈, 最近刚把blog的html部分修改了下, 将原来的div尽可能的用诸如section, nav, header, footer等semantic tags替换掉了, 准备逐步的彻底进入H5时代哈哈~ 下一步是研究CSS3的一些新属性, 会逐步应用在[404](/blog/404)或者[CSS3-Lab](/blog/css3lab)中~

That's all!

[Modernizr]: http://modernizr.com/ "Modernizr Homepage"
[Github/Modernizr]: https://github.com/Modernizr/Modernizr "Modernizr Github Page"
