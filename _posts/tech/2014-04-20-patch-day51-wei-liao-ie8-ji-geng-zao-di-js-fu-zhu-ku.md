---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day51-为了IE8及更早的js辅助库
tags: [Respond,Selectivizr,Patch,IE6-8,js]
---

需要开发跨浏览器的页面的同学一定对于IE很是愤恨! 尤其是IE8以及更早的IE... 这也是可以理解的, 毕竟谁让IE这么难伺候, 又有这么多人用呢... 尤其是在天朝, IE6都活的好好的呢... 欲哭无泪的节奏....

今天主要介绍三个js, 一个是 selectivizr.js, 一个是respond.js, 还有一个html5shiv.js~

<ol>
    <li>
        <a href="http://selectivizr.com/" target="_blank"><strong>Selectivizr.js</strong></a>
        <p>Selectivizr是专门为IE6-8量身定做的伪类辅助. 相信进入css3时代以后, 新引入的那些pseudo-class一定让不少人大呼: 这才是css应该有的样子嘛! 但是悲剧的是IE6-8不支持... 所以再无法拜托这个大尾巴的情况下, selectivizr绝对是第一选择.</p>
        <p>使用也非常简单, 只需要引入后就能在jquery等中正常使用伪类的选择器了. 具体的支持列表可以移步官网查看.</p>
        
{% highlight javascript %}

            <script type="text/javascript" src="[JS library]"></script>
            <!--[if (gte IE 6)&(lte IE 8)]>
              <script type="text/javascript" src="selectivizr.js"></script>
              <noscript><link rel="stylesheet" href="[fallback css]" /></noscript>
            <![endif]-->
            <!-- 加入判定语句来在需要的时候加入selectivizr.js -->
        
{% endhighlight %}

    </li>
    <li>
        <a href="https://github.com/scottjehl/Respond" taget="_blank"><strong>Respond.js</strong></a>
        <p>与Selectivizr类似, Respond也是为IE6-8设计的一个增强库, 但针对的不是伪类而是media query, 只需要在你的css代码后引入respond.js就能让你css中的media query在IE6-8下生效了~!</p>
        <p>而结合Selectivizr和Respond, 你就可以为IE6-8设计响应式的页面了~ 而且还能在尽可能地情况下不改变你的原始代码~</p>
    </li>
    <li>
        <a href="https://github.com/aFarkas/html5shiv" taget="_blank"><strong>Html5shiv.js</strong></a>
        <p>同样的一款为IE6-9设计的js辅助, 有了它, 你就可以在IE6-9下使用一些html5支持的新功能了.</p>
        <p>html5shiv的名气要相对小一些, 但功能上也是非常齐全的, 和前两个协同使用还是比较方便的~</p>
    </li>
</ol>

最开始听说responsive design的时候, 就有人和我说: responsive design is a beautiful dream of designers and a horibble nightmare of developers.

我深表同意!

