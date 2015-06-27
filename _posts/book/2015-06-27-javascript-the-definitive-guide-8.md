---
layout: post
title: JavaScript the Definitive Guide (8)
category: book
description: 本书收篇.
tags: [js,reding notes]
series: The Way I Learn JavaScript
author: taoalpha
---

## 概述

先说题外话: 昨天读到中途转去忙把以前的旧文章移植过来, 昨夜就已完成, 主要通过python解析了导出来的xml文本, 然后获取对应的时间信息和url信息组成符合jekyll规则的文件名, 再利用文本拼接出每个文件中固有的头和主体, 本来计划用[html2text](https://github.com/aaronsw/html2text)来把每个博文转为markdown, 不过后来源码有些问题, 对部分博文识别不好, 我也没时间细改, 所以就干脆拼接了html到主体中去.

主要导入了当初写的[Patch系列]({{site.basurl}}/tag/Patch/)和针对UX写的[翻译系列]({{site.baseurl}}/tag/译系列/). 分别归类到了[Tech]({{site.baseurl}}/tech)和[DandP]({{site.basurl}}/dandp)目录下. 有兴趣的可查看之~

今天来继续完结`JavaScript: the Definitive Guide`一书.



## 阅读笔记

### Chapter 20 - Client-side Storage

- `application cache`:
  - 为了丰富web app的功能, 或者说让web app更加的像native app, 就有了`application cache`这个机制, 从而让离线对于web app来说成为了可能;
  - `application cache`存储所有的静态格式, 包含`html`,`css`,`javascript`,`images`等等, 所有和web运行相关的资源文件;
  - `application cache`不作为常规`cache`而被轻易清理掉, 它会一直保持直到被要求删除或者用户手动删除;
  - `Manifest`: 为了能够让浏览器将网页存储到`application cache`里, 我们需要一个`manifest`文件, 并将之引入到html的head中`<html manifest="myapp.appcache">`
    - 此文件必须以`CACHE MANIFEST`为起始行;
    - 列出所有需要加入application cache里的文件, 用相对路径, 相对与manifest文件而言;
    - `#`表示注释, 空行自动忽略;
    - 此文件生效的前提是其MIME属性为`text/cache-manifest`, 即`Content-Type`这个header属性, 通常你需要自行在server中添加对应的规则;
    - 如果网页由多个html组成, 则每个html都需要使用`<html manifest="myapp.appcache">`声明, 指向同一个appcache文件即可;
    - 一旦缓存, 则所有资源文件都从缓存中获取, 未列出的资源不予加载;
  - `Complex Manifest`:
    - `manifest`支持复杂规则, 其支持多个`section`, 包含了`NETWORK:`,`FALLBACK:`这两类, 还要加上默认的`CACHE:`;
    - `NETWORK:`: 所有不予cache必须要从网络获取的资源, 可以设定路径, 支持通配符`*`;
    - `FALLBACK:`: 如其名, 优先从网络获取, 无法获取时从本地获取, 所以其每行指定两个url;
  - `Update`:
    - 对于`Application Cache`而言, 其更新主要依照`manifest`, 浏览器会自动在情况允许时帮助你查看`manifest`是否更新, 如有, 则重新缓存所有文件;
    - 注意: 浏览器不会自动帮你查看缓存的文件是否更新, 只查看`manifest`;
    - 通常可以使用`#`加一行version的注释行来强制更新;
    - `applicationCache.onupdateready`: application cache提供了状态函数来指示其更新的进度, 你可以针对其加以操作, 还包含`onchecking`,`onnoupdate`,`ondownloading`,`onprogress`,`oncached`,`onerror`,`onobsolete`;
    - 除了上述事件外, 还可以通过`applicationCache.status`来探测其状态: `ApplicationCache.UNCACHED => (0)`,`ApplicationCache.IDLE => (1)`,`ApplicationCache.CHECKING => (2)`,`ApplicationCache.DOWNLOADING => (3)`,`ApplicationCache.UPDATEREADY => (4)`,`ApplicationCache.OBSOLETE => (5)`;
    - `swapCache()`: 清楚旧或者废弃的缓存;
  - `Delete`:
    - 很简单, 删除`manifest`, 去掉html中的引用即可;

{% highlight html %}
CACHE MANIFEST
# appVersion: 1

CACHE:
myapp.html
myapp.css
myapp.js

FALLBACK:
videos/ offline_help.html

NETWORK:
cgi/
{% endhighlight %}

这就算是一个最基本的`manifest`了.

### Chapter 21 - Scripted Media and Graphics

- `Images`:
  - `onmouseover`: 鼠标`hover`移入事件;
  - `onmouseout`: 鼠标`hover`移出事件;
  - `new Image()`: 通过创建一个`Image`对象, 可以赋予其`src`属性从而实现预加载的功能;
- `Audio`
  - `(new Audio()).canPlayType(type)`: 检测某种类型的文件是否能播放;
  - `play()`: 播放;
  - `initialTime`: 初始播放进度;
  - `duration`: 文件总时长;
  - `currentTime`: 当前播放进度;
  - `muted`: boolean, 是否静音;
  - `volume`: 音量值;
  - `controls`: boolean, 是否显示控件;
  - `loop`: boolean, 是否循环;
  - `preload`: 是否预加载以及预加载类型, `metadata`表示加载时长,帧速等, `auto`表示尽可能预加载更多的内容, `none`什么都不预加载;
  - `autoplay`: boolean, 是否自动播放;
  - `playbackRate`: 播放速度(1.0 == normal speed);
  - `readyState`: 加载情况(0,1,2,3,4)=>(尚未加载, 已加载但当前位置未加载, 当前位置已开始加载但是不足以开始播放(下一帧还没加载好),已加载且足够播放但是不足以播放到结尾,加载基本足够可以播放至结束)
  - `networkState`: 当前媒体文件使用网络的情况(0,1,2,3)=>(还没开始, 没开始但可能已经加载完或者预加载设置为none, 正在使用中, 无法找到资源);
  - `error`: 错误信息(1,2,3,4)=>(用户手动停止, 类型正确网络不通畅, encoding问题, 类型不支持)
- `Video`

{% image 2015-06-27/Video-Event-Type.png %}

- `SVG: Scalable Vector Graphics`
  - SVG算是一种xml格式的矢量图类型;
  - 最新的主流浏览器基本都支持直接在`img`中嵌入svg, 部分老的浏览器依然只支持使用`object`标签: `<object data="sample.svg" type="image/svg+xml" width="100" height="100"/>`
  - 一定程度上SVG很像`canvas`, 不过它是通过XML的属性来实现的(比如通过`<line x1='50' y1='5.000' x2='50.00' y2='10.00'/>`来画线);

- `Canvas`
  - 作为HTML5引入的一个可谓是最重要的标签之一, canvas的存在极大的丰富了网络的表现形式;
  - `canvas`和js的关系紧密, 因为其绘画的实现方式就是通过js;
  - `canvas.getContext('2d'/'3d')`: 通过它创建的对象就可以在画布上尽情挥洒了;
  - 很多canvas的函数本质都是数学坐标的公式运算!

我会在后面阅读的[HTML5 Canvas](http://book.douban.com/subject/6383126/)中更加详细的研究canvas的各种用法~ 敬请期待~

{% image 2015-06-27/canvas-api.png %}  

### Chapter 22 - HTML5 APIs

- Geolocation:
  - `navigator.geolocation.getCurrentPosition()`
  - `navigator.geolocation.watchPosition()`: 在用户位置变化时唤醒;
  - `navigator.geolocation.clearWatch()`
  - [实例 codepen](http://codepen.io/agrayson/pen/IvjCi)
- History Management:
  - `pushState()`
  - `replaceState()`
  - [实例 codepen](http://codepen.io/lodr/pen/ldcwk)
- Cross-Origin Messaging:
  - `postMessage()`
  - `onmessage()`
  - [实例 codepen](http://codepen.io/matt-west/pen/lpExI)
- Web Workers:
  - 通常来说, js的执行是单线程的, 不支持多线程, 利用`Worker`可以稍稍的模拟下多线程;
  - `Worker`开启的执行不能对window和Dom有任何的操作, 和主线程只能通过`postMessage()`来交互;
  - `Worker`对象的工作域是`WorkerGlobalScope`, 完全和主线程工作域不同;
  - `Worker`支持`importScripts`来引入其需要的js库;
  - [实例 codepen](http://codepen.io/lodr/pen/qpfEy) - 因为跨域问题, 所以这里不能执行, 不过代码很简单, 很好理解, 有兴趣的可以download到本地测试
- Typed Arrays and ArrayBuffers:
  - HTML5 的数组类型变的更加强大, 开始出现类似`Int8Array()`,`Uint8Array()`等多种新形式;
  - [实例 codepen](http://codepen.io/lodr/pen/ymlgt)
- Blobs:
  - 算是存储的一种新形势, 浏览器通常可以存储`Blobs`到内存或者硬盘中, `blobs`本身更是可以代表任何数据, 以二进制的形式;
  - [实例 codepen](http://codepen.io/davidelrizzo/pen/cxsGb)
- The Filesystem API: 开启本地文件交互时代;
  - [实例 codepen](http://codepen.io/lodr/pen/aHwtn)
- Client-Side Databases: 主要为IndexedDB;
  - [实例 codepen](http://codepen.io/gtorodelvalle/pen/puBoE)
- Web Sockets: 一种相对http来说的新网络协议;
  - [实例 codepen](http://codepen.io/matt-west/pen/tHlBb)

上面针对HTML 5的各个API给出了一个对应的实例, 毕竟看着具体的代码和例子才有意思哈哈

## 参考资料

- [JavaScript the Definitive Guide 6th edition](http://book.douban.com/subject/5303032/)
