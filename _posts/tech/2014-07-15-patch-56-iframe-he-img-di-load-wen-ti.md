---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-56-iframe和img的load问题
tags: [onerror,onload,img,iframe,Patch]
---

一直觉得loading动画是个很有意思的事情, 前段时间帮助同事做一个网站, 发现加载数据比较耗时, 于是会在页面出现后有一个非常明显的页面延迟. 于是最后和设计师朋友讨论了下, 建议加一个loading动画来过渡~ 

同样的, 对于iframe而言, 经常会遇到类似的问题, 就是加载时间不定, 主要取决于网速和加载页面本身. 这种情况下, 类似我要做的feedpusher的preview, 更是频繁的加载iframe, 那么用loading动画过渡两次iframe加载和每次的加载过程就是最好的方法了.

如何写呢? 很简单, 因为iframe自身的onload()事件, 就是在判断页面加载完成之后触发的, 如此我只需要让loading gif在onload()事件触发后隐藏, 在加载时显示就可以了.


{% highlight python %}

<div id="loading"><img src="loading.gif"></div>
<iframe class="preview" src="http://fun.zzgary.info" onload="document.getElementById('loading').style.display='none';"></iframe>

{% endhighlight %}

如此, 就能实现iframe的过渡动画了~

光有了过渡的小gif其实还是很不好看的, 因为iframe本身内容还在, 整体会显得很乱, 于是我又把app上的那套随机图片背景逻辑迁移了过来~ 就是每次loading的时候会自动加载给力壁纸的一张壁纸覆盖在iframe上~

于是又遇到一个棘手的问题, 那就是我再获取给力壁纸的image url时, 是按照其image url的命名方式随机生成的, 所以存在一定的可能imageurl是不存在的, 这样会导致一个404错误, 而反映到展示上会出现一个broken image的默认图标...非常难以接受..

于是我又google了下, 发现img标签有个事件为onerror(),就是专门应对图片加载错误的情况的~ 于是我就利用onerror(), 一旦触发就重新随机一张图片地址~

{% highlight python %}

<img src="image.gif" onerror="randomwall();">
<!-- randomwall()就是用来获取随机图片的函数. -->

{% endhighlight %}


如此就获得了一个比较不错过渡效果~
<a href="http://callmet.zzgary.info/wp-content/uploads/2014/07/Loading.jpg"><img src="http://callmet.zzgary.info/wp-content/uploads/2014/07/Loading.jpg" alt="大功告成的loading过渡部分" width="1440" height="737" class="size-full wp-image-1454" /></a>
