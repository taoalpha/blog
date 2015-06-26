---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-65-npm遇pty.js相关问题
tags: [npm,Patch,coding,nodejs]
---

今天正式进入一个modern front-end developer的世界! 遍搜各种前端高级配置后, 开始着手搭建自己的workflow!

具体的配置改天令说, 本文主要谈一下使用npm安装一些组件时遇到的pty.js问题, 本人是在安装devtools-terminal的时候遇到的, 也有人在安装pty.js的时候就遇到了, 也有装其他的模块的时候遇到的...总之是千奇百怪啊... 不过问题基本都是一致的, 都是因为pty.js引起的.

错误描述为:

{% highlight python %}

../src/unix/pty.cc:487:10: error: use of undeclared identifier 'openpty'
return openpty(amaster, aslave, name, (termios *)termp, (winsize *)winp);
     ^
../src/unix/pty.cc:533:10: error: use of undeclared identifier 'forkpty'
return forkpty(amaster, name, (termios *)termp, (winsize *)winp);
     ^

{% endhighlight %}

从而可以定位到pty.cc上, google后从伟大的stackoverflow中找到了一个同样问题的解决方案, 链接附后.

原文解决方案如下:
<blockquote>
This is the work around I use:

{% highlight python %}
mkdir /tmp/pty.js
git clone https://github.com/chjj/pty.js.git /tmp/pty.js
vi /tmp/pty.js/src/unix/pty.cc
# replace line 39: #include <util.h> with #include "/usr/include/util.h"
npm install -g /tmp/pty.js
# and now npm install -g devtools-terminal should work.
{% endhighlight %}

</blockquote>

  但是... 竟然再次遇到致命错误....
  
  
{% highlight python %}

"/usr/include/util.h" file not found

{% endhighlight %}

  !!!! 细查了下, 发现竟然连usr/include文件夹都不存在...
  于是再次google... 不知道在哪个犄角旮旯中让我看到说通常需要装xcode-select的command tool才行... 这才猛然想起之前升级yosemite的时候这部分应该是需要重装才行... 于是果断搞起...
  
    
{% highlight python %}

$ xcode-select --install

{% endhighlight %}

  
  跑完后就赶忙先看了下/usr/include/, 果然出现了, 也看到了util.h文件~ 于是非常自信的再次npm了一下pty.js, 果然不负我望...

 <strong> Reference Link:</strong>
  
<a href="http://stackoverflow.com/questions/24949902/errors-installing-pty-js-node" target="_blank">stackoverflow--errors instaling pty.js</a>
