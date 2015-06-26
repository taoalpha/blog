---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-67-如何用bower打造自己的cdn或者资源库
tags: [coding,Patch,bower,nodejs]
---

最近发现不少项目共用一些资源文件, 比如jquery, 于是觉得现在这种每个project都是各自为战的方式略显粗糙, 正好最近使用nodejs比较多, 发现bower更新组件的方式非常省心, 安装后想要update也只需要bower update一下就行, 简直完美啊~

唯一的问题可能就是bower安装的是源码, 所以路径层次多不说, 文件命名有时候也不同... 唯一的共同点就是其bower.json文件的格式是一致的, 于是就简单用nodejs的fs写了一个转移脚本, 主要用来转移bower组件中的main file到根目录下的对应分类, 比如jquery.js就被转移到root/js/jquery/jquery.js中~ 如此也能方便调用~

最后形成的目录结构为:


{% highlight python %}

//  directory structure:
// ├───root
//     ├───js/
//         └───jqeury
//              └───jquery.js
//              └───jquery.min.js
//     └───css/
//         └───normalize.css
//              └───normalize.css
//     └───fonts/
//         └─── font-awesome.woff
//         └─── fontawesome-webfont.eot
//     └───css/
//         └───normalize.css
//              └───normalize.css
//     └───bower_components/
//         └───normalize.css
//              └───bower.json
//              └─── *
//         └───jQuery
//              └───bower.json
//              └─── *
//     └───transfer.js

{% endhighlight %}

以下是脚本的gist:

[gist id="c1153f7bc94256168184" file="transfer.js"]
