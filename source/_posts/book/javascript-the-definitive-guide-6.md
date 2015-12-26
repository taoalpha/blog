date: 2015-06-25 6:00:00
title: JavaScript the Definitive Guide (6)
category: book
description: 正式进入本书第二部分的内容, 核心主要围绕在浏览器内的js. 包含了最基本的使用方式, 方法, 因浏览器而增加的各种属性方法, 操作css, dom的方法, 以及常用的一些js框架, 库等, 同时还包含了目前浏览器大热的安全领域.
tags: [js,reading notes]
series: Basic Guide for JavaScript
author: taoalpha
---

## 概述

正式进入本书第二部分的内容, 核心主要围绕在浏览器内的js. 包含了最基本的使用方式, 方法, 因浏览器而增加的各种属性方法, 操作css, dom的方法, 以及常用的一些js框架, 库等, 同时还包含了目前浏览器大热的安全领域.

## 阅读笔记

### Chapter 13 - JavaScript in Web Browsers

- 异步:
  - `defer`: 使浏览器在解析并加载渲染完HTML的DOM后加载此js脚本;
  - `async`: 使浏览器在尽快执行js脚本, 但在下载js脚本时不停止DOM的解析, 优先级高于`defer`;
  - 使用方式为在script中增加关键字即可: `<script defer src="deferred.js"></script>`;
  - 注意在使用`defer/async`的时候, js中不能使用`document.write()`;
  - `document.readyState`的变化过程: `loading(async downloading, normal executing) => interactive (defer/async executing) => complete(defer/async done, event handlers invoked)`;
- `Compatibility Check`:
  - 按照目前的浏览器格局, 基本上一个浏览器就有着一种js的版本, 除了标准版本的基础功能之外, 所有的扩展功能, 各家与各家的实现方式都略有不同, 所以在使用过程中, 就需要我们考虑到兼容性的问题;
  - [Can I Use...](http://caniuse.com/), 这是一个非常优秀的检测某个属性, 方法的浏览器支持度, 拿不准的都可以在这里进行查询确认, 其还支持css和html5的检测;
  - IE5的时候引入了一个`Conditional Comments`的技巧, 是通过特殊的html注释从而让浏览器识别其IE版本, 比如`<!--[if lte IE 7]><![endif]-->`就代表IE7及以下, 而写在这个if里面的内容就会在IE7及以下的浏览器中被识别并作为页面html的一部分而提取出来(仅限IE浏览器), 其他的浏览器都会自动当做注释不理会此部分;
  - IE的JS也支持`Conditional Comments`, 比如`/*@cc_on @if (@_jscript)...@end @*/`, 这里面`@cc_on...@*/`是整个`Conditional Comments`, 而里面的`@if (@_jscript)...@end`则是判断部分, 其中`@_jscript`是IE自身js编译器的名称;
- `Accessibility`:
  - 对于身体原因而有不便的人, js的支持效果会大打折扣, 所以根据这部分人的情况而优化自身的网页结构, 目前也是网页设计的一大核心之一;
- `Security`:
  - 随着js的发展使用, 其危害性也日益提升;
  - 目前的保障安全手段主要有:`限制其功能`,`限制其使用范围和情景`,`敏感权限默认关闭虚人工开启`;
  - `The Same-Origin Policy`: js只允许读取与**当前执行环境**域名相同域名下的windows属性, 那么怎么界定相同域名呢:
    - 来自不同的网络服务器;
    - 来自相同的网络服务器, 不同的端口;
    - 同一网络服务器, 同一端口, 不同的http协议(http,https);
    - 以上, 都认为是不同域名;
  - 如何舒缓此规则:
    - `document.domain`: 考虑到同级子域名也会被禁止, 那么通过设定`document.domain`为同一母域名即可实现同级子域名的跨域;
    - ` Cross-Origin Resource Sharing `: 通过http请求新增的`Access-Control-Allow-Origin`头部, 服务器就可以指定其允许跨域的程度了;
    - `cross-document messaging`: HTML5新增了一些很强大的API,`cross-document messaging API`就是其中之一, 它允许不同的document之间的js进行通讯;

### Chapter 14 - The Window Object

- Timers:
  - `setTimeout()`: 延时触发;
  - `setInterval()`: 定时循环执行;
  - `clearTimeout()`: 清除延时触发;
  - `clearInterval()`: 清除定时循环;
- Location:
  - `window.location === document.location` 两者皆为当前页面url, 并随页面url变化而更新;
  - `document.URL` 也是指代加载后的当前页面, 但不随页面内动态变化引起的url变化而变化;
  - `Location`这个对象本身包含了多个属性分别指代url的不同部分:`protocol`表示网络协议, `host, hostname`通常都指示域名,前者包含端口, `port`表示端口, `pathname`表示以域名根目录为`/`的相对路径, `search`表示url中`?`以后的部分但不包含`hash`部分, `hash`则是表示url`#`以后的部分;
  - `Location`还包含了三个常用的函数:`assign()`,`replace()`,`reload()`, 其中前两者功能都一样, 都是用以加载新页面的, 不过`replace()`加载的同时将当前页面从`history`中去除了(就是不能后退后之前页面了), 而`assign()`还保留着; `reload()`就更不用说了, 只是单纯的重载页面;
- History:
  - `back()`,`forward()`: 等价于浏览器的后退,前进按钮;
  - `go(n)`: 接受数字作为参数, 表示向前或者后退n个页面;
  - 如果页面中有`iframe`, 那么其history会自动合并到主界面的history中;
- Navigator:
  - `appName`: 浏览器的名称;
  - `appVersion`: 浏览器版本号;
  - `userAgent`: 用户代理, 对应HTTP的`USER-AGENT`;
  - `platform`: 操作系统;
  - `onLine`: 是否连通网络, HTML5支持;
  - `geolocation`: 用户地理位置信息, HTML5支持;
  - `javaEnabled()`: 对Java扩展的支持, 非标准;
  - `cookiesEnabled()`: 能够设置cookie, 非标准;
- Screen:
  - `width`,`height`: 当前屏幕的长宽尺寸;
  - `availWidth`,`availHeight`: 去除功能区等部分之后的实际展现内容的屏幕尺寸;
  - `colorDepth`: 显示屏幕的bits-per-pixel;
- Dialog Boxes:
  - `alert()`: 弹出对话框, 展示传入的信息;
  - `confirm()`: 自带`OK`,`Cancel`按钮的对话框, 返回对应的boolean值;
  - `prompt()`: 附带输入框, 返回输入的值;
  - 上述三个类型的对话框的样式结构都无法调整, 是浏览器默认设定的;
  - `showModalDialog()`: 则更加复杂, 它可以支持弹出一个页面, 其接受的第一个参数即为页面的url, 后面的参数则是弹出窗口的属性; _在chromium中已经被禁止了_
- onerror handler:
  - 用于处理错误信息的, 你完全可以定制这个函数来更好的显示js中的错误信息;
- Document Elements As Window Properties:
  - 当一个html元素被赋予了id时, 其id对应名称的全局变量不存在时, 其自动转为全局变量, 属性名称即为id名, 但如果id名已经被使用, 则不生效;
  - 对于`<a> <applet> <area> <embed> <form> <frame> <frameset> <iframe> <img> <object>`这样的元素, 其name值和id效果是一样的, 且name值支持多个元素相同, 会自动生成类array形式, 对于`iframe`, 对应的属性会指向其内嵌窗口的window对象;
- Multiple Windows and Frames:
  - 通过js打开的新窗口都可以被js获取到, 并进行操作, 但是需要符合`same-origin`的原则;
  - `frame`嵌入的窗口可以通过`parent.frames`属性来获取, 也可以通过其自带的`contentWindow`来获取;


## 谜题

- Q: 在测试`same-origin`的时候, 发现有些网站可以设定子域名的`document.domain`为母域名, 有些不能? 比如在google的搜索结果页, 就可以, 但是在github pages中想要设置为`github.io`就不可以, 会出现`'github.io' is a top-level domain.`这样的错误?

## 参考资料

- [JavaScript the Definitive Guide 6th edition](http://book.douban.com/subject/5303032/)
- [Can I Use ...](http://caniuse.com/)
- [host and hostname](http://stackoverflow.com/questions/6725890/location-host-vs-location-hostname-and-cross-browser-compatibility)
