---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-54-Session和Cookie的一点小心得
tags: [Session,Cookie,Patch]
---

前段时间帮朋友搭一个网站, 因为涉及到第三方登录各种状态的判断, 就整了一把session和cookie, 也是第一次比较仔细的研究了下两者的区别~ 特来分享给大家哈~

首先, cookie和session的区别是非常明显的, 可以简单列举如下:

<ol>
  	<li>Session是存储在服务器端的, Cookie则是存储在客户端的;</li>
	<li>Session和Cookie的过期时间都可以设定, 但是一旦浏览器关闭重启后, Session就会失效, 但Cookie依然有效(在用户不主动清理且没有过期的情况下唉);</li>
	<li>Session和Cookie都可以被php操作(包含修改,删除,增加等), 但是只有Cookie可以同时被js进行同样的操作, 对于Session, js只能删除而不能进行任何的修改和新增了;</li>
</ol>

那么, 从上面的这些特点来说, 什么情况下用cookie, 什么情况下用session呢? 我大致列举了几种笼统的情况如下:

<ul>
  	<li>首先, 请确保一些敏感信息还是用session来保存吧, 比如重要的密码之类的, 因为cookie是可以被明文查看到的, 所以可能容易泄漏, 而且登录状态有的时候也应该只保留在一个浏览器浏览周期内--至于在session保存密码的情况下, 如何记录登录状态, 就可以各自发挥了;</li>
	<li>其次, 如果需要js操作, 请用cookie;</li>
	<li>在其次, 如果需要频繁操作, 请用cookie以及js操作...php是在太不好写了...也太不好看了...</li>
	<li>最后, 如果是需要长期有效的, 最好还是cookie, 这样即便是浏览器关闭也不用太担心的;</li>
</ul>

啊哈~ 基本如此啦, 另外推荐一个js操作cookie的plugin哈:

<a href="https://github.com/carhartl/jquery-cookie" title="jquery cookie plugin" target="_blank">jQuery Cookie Plugin</a>

祝好!

