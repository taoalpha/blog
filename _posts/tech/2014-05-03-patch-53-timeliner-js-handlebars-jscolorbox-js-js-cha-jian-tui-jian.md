---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-53-Timeliner.js, Handlebars.js,colorbox.js-js插件推荐
tags: [Patch,coding,js]
---

今天看GUI Bloopers的时候看到一段介绍Usability的话语, 解答了我许久的疑惑和迷茫, 于是特别想记录下来, 却发现自己似乎并没有这么一个方便记录的工具.... 不是记事本, 不需要记录所有事, 只需要记录一些重要的事情就行, 于是乎, 就捣鼓了下, 自己写了个简单的记事工具~ 当然还是web版本的~ 现在只有view部分, module和control都还有很多没有完成, server部分也完全没开始, 不过这些部分都比较简单, 框架算是基本完成了.

期间主要使用了三个插件, 下面逐一介绍下:

<ol>
    <li>
        <strong><a href="http://www.technotarek.com/timeliner/timeliner.html" target="_blank">Timeliner.js</a></strong>
        <p>考虑到记事本身的时间属性, 所以就直接定位时间轴的显示方式, 本来想费点劲自己写一个jquery的插件, 后来发现有现成的, 就直接拿来用了~ 非常不错, 简单, 轻量! 除了本身html结构和class,id命名等需要按照固定的格式进行之外, 自己需要写的js很少, 可以说很节省时间! </p>
    </li>
    <li>
        <strong><a href="http://handlebarsjs.com/" target="_blank">Handlebars.js</a></strong>
        <p>也是因为Timeliner.js需要固定的html结构, 而数据传输多数是使用js进行的, 所以就想到了Mustache, js中应用Mustache语法的非handlebars最为出名. 于是就使用了它, 基本上用两个each, 一个if就完事了~ 哈哈, 简单吧~ 目前demo版本就是利用固定的数据进行测试的~</p>
    </li>
    <li>
        <strong><a href="http://www.jacklmoore.com/colorbox/example1/" target="_blank">Colorbox.js</a></strong>
        <p>写的过程中想到五一后Mac就能到手, 准备进入iOS开发的节奏, 于是想到了前段时间看到的一个高中学生开发的ToDo应用, 采用了图片取代文字的思路, 所以想着如果以后wordsdiary要做iOS版本的话, 肯定也会加入图片或者视频的属性, 再加上timeliner本身有video的例子, 于是就结合其中的colorbox范例以及官网的一些扩展范例, 加入了图片的box, 什么意思呢? colorbox其实说白了就是个关灯放映幻灯片... 不过colorbox本身支持性很好, 可以支持各种嵌入, ajax, video, image, inline-block等等... 于是我就偷懒连add new也直接用inline-block的方式实现了... 哈哈</p>
    </li>
</ol>

<strong>Links:</strong>
<li><a href="http://fun.zzgary.info/wordsdiary/login.php">目前还只是个非常简陋的demo, add功能也没有做, 目前来说看到就是js中存储的数据模版--直接登录即可~</a></li>



