---
layout: post
title: 网页渲染过程简介
category: tech
description: 都说好的前端必须要懂浏览器, 毕竟我们操作的就是浏览器. 如果不懂页面的渲染逻辑, 如何能够有针对性的开发出高性能的网页呢?
tags: [浏览器,渲染]
author: taoalpha
---

## 概述

做web开发尤其是性能优化, 首先要明了的就是web渲染逻辑. 只有知道了浏览器是如何渲染页面的, 你才能更有针对性的去优化你的网页. 今天就来详细的说一下web的渲染步骤.

## 浏览器的组成

1. UI: 指浏览器的外在表现样式;
2. Browser Engine: 连接UI和渲染引擎;
3. Rendering Engine: 渲染引擎, 根据请求内容的不同进行不同的渲染, 比如html的话就是渲染HTML和CSS(使用的就是HTML和CSS的Parser) (我们常说的webkit就是rendering engine);
4. Networking: 网络, 用以处理网络请求, 比如HTTP请求的;
5. UI backend: 用来生成一些基础控件的, 比如窗口等, 这些控件都是跨平台的, 其会调用系统本身的界面方法来生成对应的控件;
6. JavaScript Interpreter: 用以解析以及执行JS代码的;
7. Data Storage: 用以存储数据, 包含存储本地的cookies以及类似localstorage等这种存储机制;

- Webkit redering engine main flow
{% image http://www.html5rocks.com/en/tutorials/internals/howbrowserswork/webkitflow.png title='Figure : WebKit main flow' alt='Figure : WebKit main flow' %}
- Gecko redering engine main flow
{% image http://www.html5rocks.com/en/tutorials/internals/howbrowserswork/image008.jpg title="Figure : Mozilla's Gecko rendering engine main flow" alt="Figure : Mozilla's Gecko rendering engine main flow" %}
- Parser Compilation Flow
{% image http://www.html5rocks.com/en/tutorials/internals/howbrowserswork/image013.png title='figure: Parser Compilation Flow' alt="figure:Parser Compilation Flow" %}
- CSS Parser Flow
{% image http://www.html5rocks.com/en/tutorials/internals/howbrowserswork/image023.png title='Figure : parsing CSS' alt='Figure : parsing CSS' %}

## 如何渲染一个网页

1. 在浏览器中输入要访问网页的url;
2. 浏览器开始解析url, 找寻其所属的协议, 主机所在, 所用端口以及对应的路径;
3. 浏览器通过进行DNS查询将域名转为IP地址;
4. 浏览器开启对应的通信端口并与解析出来的IP地址相连(通常会使用80端口);
5. 当建立链接后, 就会向主机地址发送一个HTTP请求, 包含了一些浏览器的基本属性和网页参数等;
6. 主机将请求接收并转发给监听对应端口的服务器, 比如Apache或者Nginx等;
7. 服务器解析请求路径, 并根据设定的配置将其转交给对应的处理器处理(具体会因不同语言而有所区别: PHP, Pyhton等);
8. 处理器接收请求, 并着手准备回应请求;
9. 根据具体情况, 处理器可能会需要链接数据库获取数据来构建回应内容(链接数据库->执行查询->获取并解析数据->关闭数据库链接);
10. 将所有数据整合构成回应主体(对于网页而言多数是html字符串), 加上必须要的元信息(HTTP的Header), 以同样的协议返回给用户的浏览器;
11. 浏览器接收回应内容, 根据回应的状态, 如果有错误则进行错误处理, 若无则进行解析;
12. 浏览器首先根据获得的内容(多数情况下为HTML)生成一个DOM树;
13. 然后针对其内引用的外部资源逐个发起请求获取, 比如图片, 样式, js等, 此刻重复上述请求步骤;
14. 浏览器获得返回的样式后开始解析其内容, 将css构建CSSOM, 而根据具体的属性来执行js的解析和执行;
15. 针对更新后的DOM和CSSOM, 生成render tree, 即包含了视觉展现信息的树, 浏览器根据render tree来进行渲染, 即你看到的页面;
16. 根据css来对render tree进行layout - 定位, 然后再对定位好的部分进行Painting, 然后你就看到了呈现在你眼前的页面;

### css和js的加载顺序

#### JS

- 默认下, js的加载是同步的, 即遇到`<script>`标签后立刻就会开始解析js, 如果js本身是外部资源, 则还会先去请求获取后再解析, 同时Dom的解析也会因此而暂停,一直等待js解析执行后才会继续;
- 对于外部引用的js(不是直接写到html里的),开发者可以通过给script标签增加`defer`属性来使js滞后加载, 这样就不会影响到Dom的解析了, 其也会在Dom解析后执行, 但这种情况下, 务必要保证js中不会用到`document.write()`这种直接创建Dom Node的语句;
- 除了`defer`,H5中新引入了`async`属性, 可以让js保持异步加载, 如此js的解析执行就是在另一个线程中进行的了, 就和Dom的解析互不影响了, 当然同样的, 这种情况下, js中也不能有类似`document.write()`的函数;
- 同时引擎方面目前也有一定的优化, 一般来说, webkit或者firefox所用的引擎都会在执行某个脚本的同时, 开启另一个线程继续处理下面的文档并请求所需的外部资源(images,css,js);

用一张图总结`defer`和`async`的区别就是:

{% image http://khan4019.github.io/MakeWebFaster/images/asyncVsDefer.jpg title="Async Vs Defer" alt="Async Vs Defer" %}

通常来说, 对于互不依赖的模块而言, 用async比较好, 因为不会占据整体的时间, 而如果js之间互相有所依赖, 则需要根据具体情况来看, 这个时候很不推荐滥用`async`, 因为无法保证模块的执行先后顺序;

**`async`依然会block掉Dom的ready事件, 即`async`的js执行完之前dom是不会变为`complete`的**

#### CSS

虽然css不会影响Dom的结构, 但是因为js对css有获取权限, 所以css的加载也会因为js的不同而有所不同.

- Firefox会在保证css加载后才会加载js;
- Webkit则智能一些, 它只会延缓加载那些会因为css未加载而受到影响的js;

即css的执行要优先于js

## 结语

在[How Browsers Work](http://www.html5rocks.com/en/tutorials/internals/howbrowserswork)中, 作者详细描述了很多`parse`,`render`,`layout`,和`painting`的细节, 如果有兴趣的话, 可移步详细阅读.

浏览器可以说是人类21世纪最伟大的发明之一, 其蕴藏了很多技术细节, 也正是其不断的优化, 才能让我们今天看到如此绚丽多彩的网页. 而WebKit的出现则让浏览器赤裸的展现在了开发者的面前, 也为前端开发带来了性能优化的领域.

有兴趣了解更多WebKit的技术, 可以阅读[WebKit技术内幕](http://book.douban.com/subject/25910556/)一书.

## 参考资料

- [rendering a web page - step by step](https://friendlybit.com/css/rendering-a-web-page-step-by-step/)
- [How Browsers Work](http://www.html5rocks.com/en/tutorials/internals/howbrowserswork)
