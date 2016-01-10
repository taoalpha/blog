category: read
description: ''
date: 2014-07-15 6:00:00
title: Using @font-face
tags: [翻译文章,font-face,译系列,CSS]
---

如下例:


``` css

@font-face {
  font-family: 'MyWebFont';
  src: url('webfont.eot'); /* IE9 Compat Modes */
  src: url('webfont.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */
       url('webfont.woff') format('woff'), /* Modern Browsers */
       url('webfont.ttf')  format('truetype'), /* Safari, Android, iOS */
       url('webfont.svg#svgFontName') format('svg'); /* Legacy iOS */
}

```


由于如今WOFF是如此之火, 你也可以简化使用:


``` css

@font-face {
  font-family: 'MyWebFont';
  src: url('myfont.woff') format('woff'), /* Chrome 6+, Firefox 3.6+, IE 9+, Safari 5.1+ */
       url('myfont.ttf') format('truetype'); /* Chrome 4+, Firefox 3.5, Opera 10+, Safari 3—5 */
}

```

其实只用WOFF也可以的, 目前基本主流浏览器都能支持了.

然后你就可以在其他元素中使用这一属性了~ 比如:


``` css

body {
  font-family: 'MyWebFont', Fallback, sans-serif;
}

```


讲讲font-face的历史吧, @font-face是用于加载以及使用你自定义的字体而出现的, 针对的就是如今浏览器有权限使用的系统已有的有限字体. 这里有个<a href="http://practicaltypography.com/system-fonts.html" target="_blank">系统预装字体的详情介绍</a>.

说到性能. 一般我们认为字体文件都是非常巨大的, 同时还会让你的网站增加很多额外的请求, 这些都会拖慢你的站点速度. 所以在使用之前请务必确保你考虑清楚.

如果你确实要使用自定义字体, 有一种更好的更负责的方式是尽可能的加载足够少的字母和样式种类. 比如, 如果你使用google fonts, 只需要引入一些特定的组合即可:


``` css


@import url(http://fonts.googleapis.com/css?family=Averia+Sans+Libre:400,300italic,700);


```

甚至可以缩减引入的字符数量.


相比于性能, @font-face似乎经常出现各式各样的bug...比如<a href="http://blog.typekit.com/2014/02/28/new-bug-in-chrome-v33-affecting-web-fonts/" target="_blank">这种</a>, <a href="http://www.fontspring.com/support/troubleshooting/font-face-bugs" target="_blank">这种</a>,还有<a href="http://ianfeather.co.uk/ten-reasons-we-switched-from-an-icon-font-to-svg/" target="_blank">这种</a>...


关于字体格式, 倒是有几种, 每种都还有些历史.


<ul>
  <li>WOFF
    <p>Web Open Font Format. 是专为网络使用而创造的, 由Mozilla和一些其他组织共同发展起来的, WOFF字体通常比其他格式字体加载的更快, 主要是因为他们使用了比OTF和TTF更加压缩的结构, 这种结构中还能包含一些meta信息和license信息, 目前来说WOFF应该是最大的赢家了, 主流的浏览器基本都已经能够支持了.</p>
  </li>
  <li>SVG/SVGZ
    <p>Scalable Vector Graphic(Font). SVG是一种字体的矢量化过程, 主要可以让体积变的更小, 同时也能够用于移动设备. 这个字体格式是4.1版本以下的Safari浏览器唯一支持的字体格式了. 目前来说SVG依然不能被Firefox, IE以及IE 移动版支持. Firefox主要精力都在支持WOFF了~ 天知道他们什么时候支持SVG... SVGZ是SVG的再压缩版本.</p>
  </li>
  <li>EOT
    <p>Embedded Open Type. 这一格式是由微软从15年前创造的(真正意义上@font-face的源头). 也是唯一一种IE8以及以下版本支持在@font-face中使用的格式了.</p>
  </li>
  <li>OTF/TTF
    <p>OpenType Font 和 TrueType Font. 在一定程度上WOFF格式的出现也是因为这些格式可以很容易被复制, 无论合法与否. 同时, OpenType的某些特性(比如手写字体等)比较吸引设计师们.</p>
  </li>
</ul>


字体服务有很多, 主要就是提供那些你可能无权使用的字体, 从而让你的使用合法化. 主要有以下这些:

<ul>
  <li>Cloud Typography</li>
  <li>Typekit</li>
  <li>Fontdeck</li>
  <li>Webtype</li>
  <li>Typotheque</li>
  <li>Fontspring</li>
  <li>WebINK</li>
  <li>Fonts.com</li>
  <li>Google Fonts</li>
  <li>Font Squirrel</li>
</ul>



<a href="http://www.smashingmagazine.com/2010/10/20/review-of-popular-web-font-embedding-services/" target="_blank">想要对比下这些服务的好坏?</a>


<strong>Source Link:</strong>  <a href="http://css-tricks.com/snippets/css/using-font-face/" target="_blank">CSS Tricks</a>

