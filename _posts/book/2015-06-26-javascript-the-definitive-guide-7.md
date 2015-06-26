---
layout: post
title: JavaScript the Definitive Guide (7)
category: book
description: 正式进入本书第二部分的内容, 核心主要围绕在浏览器内的js. 包含了最基本的使用方式, 方法, 因浏览器而增加的各种属性方法, 操作css, dom的方法, 以及常用的一些js框架, 库等, 同时还包含了目前浏览器大热的安全领域.
tags: [js,reading notes]
author: taoalpha
---


## 概述


## 阅读笔记


### Chapter 15 - Scripting Documents

- Selecting:
  - `document.getElementById(id)`: 通过id, 一个id对应一个元素;
  - `document.getElementsByName(name)`: 通过name, 可多个;
  - `document.getElementsByTagName(tagname)`: 通过标签名;
  - `document.getElementsByClassName(class_name)`: 通过类名;
  - `querySelectorAll(css_selector)`: 通过css的选择器, 返回所有匹配;
  - `querySelector(css_selector)`: 返回首个匹配;
- Trees of Nodes:
  - `parentNode`: 父节点;
  - `childNodes`: 子节点;
  - `firstChild, lastChild`: 首个或者最后一个子节点;
  - `nextSibling, previousSibling`: 下一或者上一兄弟姐妹节点;
  - `nodeType`: 节点类型, Document 节点返回9, 元素节点返回1, 文本节点返回3,注释节点返回8, DocumentFragment节点返回11;
  - `nodeValue`: 当前节点的文本内容;
  - `nodeName`: 标签名, 大写;
- Trees of Elements: 忽略所有的文本节点和注释节点;
  - `firstElementChild, lastElementChild`: 返回首个或者最后一个元素节点;
  - `nextElementSibling, previousElementSibling`
  - `childElementCount`: 返回子元素节点的个数;
- Attributes of Elements:
  - `getAttribute()`
  - `setAttribute()`
  - `hasAttribute()`
  - `removeAttribute()`
- Dataset Attributes: 由HTML5引入, 所有带`data-`前缀的属性都算是合法的html元素属性.
- Element Content:
  - `innerHTML`
  - `outerHTML`: 包含匹配元素自身标签;
  - `insertAdjacentHTML()`: 允许指定插入位置`beforebegin, afterbegin, beforeend or afterend`;
  - `textContent`: IE不支持
  - `innerText`: IE支持, 功能同上;
- Creating,Inserting, and Deleting Nodes
  - `document.createElement(tag_name)`
  - `document.createTextNode(text)`: 创建文本节点;
  - `document.createComment(text)`: 创建注释节点;
  - `document.createDocumentFragment()`: 创建孤立节点;
  - `node_name.cloneNode()`: 复制当前节点;
  - `element_node.appendChild(element_node_2)`: 由后插入;
  - `element_node.insertBefore(element_node_2)`: 由前插入;
  - `removeChild()`: 移除当前节点`n.parentNode.removeChild(n);`;
  - `replaceChild()`: 替换
- DocumentFragment: 孤立节点, 其没有母节点(null), 当`appendChild()`等操作针对其时, 操作执行对象自动变为其所有子节点, 且操作完成后, 其自身为空;
- viewport: 表示实际展示内容的窗口, 在顶层网页中为去除浏览器菜单等等之外的部分, 而在`iframe`中则为`iframe`定义的frame大小;
- document: 表示页面内容的窗口, 通常都大于viewport;
- `getBoundingClientRect()`: 返回节点的长宽,上下左右边界属性`width,height,top,left,bottom,right`, **返回的结果是基于viewport的**;
- `document.elementFromPoint()`: 返回x,y处的元素节点 - 根据z-index, 从外到内的返回;
- `scroll(), scrollTo(), scrollBy()`: 窗口滚动控制, 最后的`scrollBy()`传入的x,y表示在原有的基础上的增加值;
- `scrollIntoView()`: 滚动到某个节点;
- `document.forms`: 获取页面中所有form元素;
- 其他document属性:
  - `cookie`
  - `domain`
  - `lastModified`: 修改时间;
  - `location`: 等同于`window.location`
  - `referrer`
  - `title`
  - `URL`: 之前提到过, 其只保存打开时的当前链接, 不随页面内的动态变化而变化;

### Chapter 16 - Scripting CSS

- js可以通过`node.style`来访问元素样式属性, 可以获取, 赋予; 而通过更加复杂的函数变化, 就可以创造出一些很棒的动效来, 在css3之前, 所有的非gif或者flash动效基本都是通过js实现的.
- `window.getComputedStyle(element,"null or :first-line etc")`则可以获取某个元素(或者某个元素的伪类)的所有样式属性, 同时获取的值都会自动转为标准的绝对值(比如设定的百分比也会自动计算出来返回),但是其不能赋予;
- `disableStylesheet()`可以禁止某个元素的所有样式, 如果传入的是数字, 那么会按照`document.styleSheets`的顺序查找, 如果是string, 则作为css selector查询对应的元素;
- `insertRule(rules,insert_index), deleteRule(rules)` 即插入整条的结构化的css语句, IE下对应的函数为`addRule(),removeRule()`;
- `document.createStyleSheet`则可以创建一个新的样式表, 等价于在head里面创建一个`style`标签;

### Chapter 17 - Handling Events

- Events的类型
  - Device-dependent input events:`mousedown`, `mousemove`, `mouseup`, `keydown`, `keypress`, `keyup`, `touchmove`, `gesturechange`;
  - Device-independent input events: `click`
  - User interface events: `focus`, `change`
  - State-change events: `loadstart`, `progress`, `loadend`
  - API-specific events: `dragstart`, `dragenter`, `dragover`, `drop`, `waiting`, `playing`, `seeking`, `volumechange` etc
  - Timers and error handlers;
- Handlers:
  - `Event Handler Attributes`: `onclick=""`,`window.onload = f()`;
  - `addEventListener(event_name,function,[capturing event handler])`: 添加事件, 最后的`capturing`通常为false;
  - `removeEventListener()`: 和上面的add相反;
  - `stopPropagation()`: js的事件触发是沿着DOM树向上传递的, 而通过`stopPropagation()`就能抑制这一环节;
  - `preventDefault()`: 很多元素有其自身的事件属性, 比如a标签的跳转, form元素的提交, 当我们想要取消其默认事件的发生时, 可以使用此函数来阻止其发生;

总的来说, 这一章内容其实很丰富, 但是其内容多数都是建立在之前的基本内容之上的. 着重需要知道的就是各种不同的事件, 其支持的元素, 类型以及触发的方式即可. 此类用法主要还是多用多练, 可以试试不同的event都包含那些属性~哈哈

### Chapter 18 - Scripted HTTP

- XMLHttpRequest:
  - Ajax: 由js端发起, 通过http请求和服务端交互;
  - Comet: 由服务端发起, js如果需要反应则使用Ajax回应, 通常由`EventSource`对象处理;
  - 标准流程:`new XMLHttpRequest()`=>`open('type of request', url,[],[username],[userpassword])`=>`setRequestHeader()`=>`send([content_body])`<=`onreadystatechange`<=`customized handler`
  - 通常`GET`类型的请求我们会通过`encodeURIComponent`来进行url拼接, 直接在url中体现, `send()`的时候就不用传值了;
  - `POST`类型的请求通常以json格式传递, 我们需要在`send()`中传入`JSON.stringify()`的数据, 当然如果是XML的POST, 那么直接传入对应的doc即可, 而像file这类的文件实体, 也是直接传入对应的实体即可;
  - 起中`Header`部分我们只能自行设定部分, 而`Content-Length`,`Date`,`Referer`,`User-Agent`等等都由浏览器自动帮我们填上了;
  - `readyState`: UNSENT 0(`open()`还没执行); OPENED 1(`open()已经执行`);HEADERS_RECEIVED 2(headers已被接收),LOADING 3(正在接受返回),DONE 4(完毕).
  - XMLHttpRequest对象有一个`onprogress`的属性可以用来检测其执行进度, 它对应的属性值中包含了`lengthComputable`, `loaded`,`total`, 通过这三个就可以做一个简单的进度条跟踪请求的进度了;
  - 如果是上传行为, 其`onprogress`属性存在于`XMLHttpRequest_Object.upload.onprogress`之中;
  - `abort()`: 用来取消请求;
- EventSource:
  - 标准流程: `new EventSource("url_to_server_file")` => `onmessage`

### Chapter 19 - The jQuery Library

jQuery流行度的一大证据之一! 哈哈 我计划抽时间好好读一下jQuery的源码, 所以这里只是大概扫了一遍, 基本也都是应用层面的, 多数我差不多都使用过~哈哈

### Chapter 20 - Client-Side Storage

我在早先做chrome插件[详见我的portfolio](zzgary.info)的时候, [写过一篇专门介绍web存储的文章](http://callmet.zzgary.info/2014/02/04/data-storage-patch-day40-web-app-in/). 恩, 当时写了不少`patch`系列, 哈哈, 改天写个脚本全部导出来转移过来.

恩 我现在就去写导入工具... 今天就到这里吧, 明天算是最后一篇就能完结本书啦~
