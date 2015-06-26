---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-55-关于iframe的sandbox
tags: [sandbox,iframe,Patch]
---

最近因为更新feedpusher, 把多版本合一了, 但也为保持多版本之间体验的大致一致性而遇到了很多的问题. 比如接下来要说的iframe的问题, 多数FE或者网站建设者都应该知道CSP, 同时对于那些设定了X-iframe-option的网站深恶痛绝... 本来在不考虑在web版本上加入preview的我, 非常幸运的用chrome app的内置webview标签逃过一劫, 而且因为webview本身不care csp问题, 所以效果远超预期... 但是因为考虑到大屏问题..如今再次把iframe捡起... 就不得不面对iframe这个让人头疼的东西了...

==================事先声明: 本文主要介绍sandbox属性, 并不能解决x-iframe-option问题=================

对于chrome app而言, 因为在使用webview的情况下, 是不需要考虑X-iframe-option的, 即便对方网站设定为deny或者sameorigin也可以照常加载, 但是对于网页版本而言, 因为html本身没有webview这个标签, 只能用iframe来替代, 所以首先就是不能加载那些设定了deny和sameorigin的站点, 同时, 如果你担心iframe内置页面对你本身页面信息的窃取和危害, 那么就可以用sandbox来防止这一点了.

对iframe而言, 为了保证iframe里面的内容正确展示(包含js的post,get;以及form的提交,link的跳转等等), 我们需要给iframe几个sandbox的属性(sandbox是html5才有的属性哈):


{% highlight python %}

<iframe id="webv" sandbox="allow-popups allow-scripts allow-same-origin allow-top-navigation"></iframe>

{% endhighlight %}


关于sandbox的属性, html5的介绍中有非常详细的描述, 以下简单的归纳和转述以下:

<blockquote>
支持的值总共有allow-forms, allow-pointer-lock, allow-popups, allow-same-origin, allow-scripts, 以及 allow-top-navigation 这6种, 当然什么都不写的情况下(sandbox="")默认为default值--等价于<strong>均不允许</strong>.
  <ul>
    <li>全禁状态: 此种情况下, iframe作为一个单独的沙箱运行, 所有的api,js都会被禁止, 所以多数js实现的动态效果都会无效(当然多数广告也会自动被干掉了)...</li>
	<li>allow-scripts: 顾名思义, 这种情况下, iframe中的js脚本将被允许执行;</li>
	<li>allow-forms: 同样 这种情况下, iframe中的form表单是允许提交的;</li>
	<li>allow-same-origin: 此种情况下, iframe将会回归自己真实的域, 也就可以访问DOM和Window的一些属性了, 比如cookie,localstorage, 同时此种情况下的同域名post,get也是可以被允许的;</li>
	<li>allow-top-navigation: 赋予iframe这一属性的话, 则给予了iframe页面修改和进入母页面的权利, 无论是a标签的_top, 亦或者是js的window.top.location都会生效, 如此就可以允许子页面突破iframe的限制了;</li>
	<li>allow-popups: 这一属性是用于控制iframe页面中辅助性窗口创建的, 比如target, window.open()亦或者是 showModalDialog()等, 当这些在创建辅助弹窗时, 需要allow-popups;</li>
	<li>allow-pointer-lock: 这个是用于对那些应用了指针锁定(pointer lock)的页面, 可以允许iframe页面锁定鼠标指针;</li>

</ul>
PS.很重要的一点, sandbox=""和不写sandbox是完全不同的, 不写sandbox的话, 就是全开放!
</blockquote>

ok. sandbox就说道这里, 可能有人问, 既然要保证各项功能正确, 为啥不直接不设定sandbox, 全开放不就得了? 那你一定没仔细看上述几个值的含义, 对于部分网站而言, 为了减少流量因为iframe而导致拦截以及内容的原创主导, 所以会通过js判断iframe, 从而拒绝iframe展示, 甚至直接重定向到自己的链接的~ 但是如今有了allow-top-navigation, 那么, 在不被允许的情况下, 就不能这么做了.


<strong>Related links:</strong>

<ul>
	<li><a href="http://www.html5rocks.com/en/tutorials/security/sandboxed-iframes/" title="html5 rocks--Sandbox" target="_blank">HTML5-Sandbox--HTML ROCK</a></li>
	<li><a href="http://www.tfan.org/pointer-lock-api/" title="html5 pointer lock" target="_blank">HTML5--Pointer Lock</a></li>
	<li><a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/browsers.html" title="Html5 Security" target="_blank">HTML5 Security</a></li>
</ul>



