---
layout: post
title: Cookie中path规则介绍
category: tech
description: Cookie种植过程中path规则的一些介绍, 结合我的使用经历介绍一些小的技巧~
tags: [javascript,cookie]
author: taoalpha
---

cookie这个东西经历了多次风波后, 很多人应该都有所耳闻了, 简单来说就是浏览器用来记录一些小型信息以待之后访问使用的一种机制. 一个标准cookie有几个基本的域: name, value, Domain, Path, Expires, Size, HTTP, Secure. 下面一一介绍.

## cookie各项属性

### Name

作为cookie的名称, 在赋值时必填的, 同时也是获取的凭证;

### Value

具体的cookie内容存储所在. 通常不为空(为空无意义), 存储基本以文本形式或者数字形式存储, 你可以存储stringify的json, 但读取后还是需要parse才能还原为json. 直接试图储存json的话, 只会存储成`"[object Object]"`的文本..

### Domain

cookie生效的域名, cookie只会在对应的domain下生效(直接表现为可获取), 而domain的层级是向下继承的, 所以下级域名可以获取到上级域名的cookie;

举个例子就是: inbox.google.com的cookie就只能被inbox.google.com下属的页面获取, 而不能被mail.google.com获取;

通常为cookie生成所属的域名;

### Path

和Domain基本类似, 只是限制放在了路径上, 同样也是向下继承, 下级路径可以获取上级路径的cookie, 举个例子就是:

google.com的域名, /reader/的二级路径的话, 就只能在google.com/reader/及以下的路径下获取.

默认情况下为cookie赋予的当前路径.

### Expires

过期时间, 用于设置cookie过期的时间的. 过了这个时间后对应的cookie会自动销毁.

通常默认值为session, 寿命基本存在于浏览器的一次开关周期中, 基本属于关闭浏览器后, 就销毁了.

### Size

表示cookie的大小, 属于浏览器计算的, 在我们赋值过程中没有体现. 值得一说的是, 根据HTTP的协议要求, 单个cookie的大小是不能超过**4kb**的.

对于cookie的数量, 其实是有限制的, 但是这个因浏览器而有所不同, 通常来说, 大概在300个左右, 超过限制后, 会自动删除老旧的cookie来腾位置给新的cookie.

### HTTP

一旦设定httpOnly的话, 那么浏览器会默认这一个cookie只能通过http协议来获取, 那么任何客户端的获取都会被阻止, 比如js.

### Secure

设定secure的话, cookie只会通过https来传输. 算是增强安全性的一种方法.

## 使用途径

通常你可以使用`jQuery.cookie`的库来进行cookie的赋予和获取以及销毁. 当然, 本身原生的js也是支持的, 而且语法也很简单, 完全可以使用.

HTTP以及Secure两个属性都属于基于安全性原则的考虑, 也通常需要服务器配合生成, js是无法直接完成的. 一般来说, 个人博客使用的话, 基本是不太需要的;

## 参考资料:

- [An Introduction to Cookies](http://code.tutsplus.com/tutorials/an-introduction-to-cookies--net-12482)
- [What are Cookies?](http://www.cookielaw.org/introduction-to-cookies/)
- [How to Create Totally Secure Cookies](http://blog.teamtreehouse.com/how-to-create-totally-secure-cookies)


[TaoAlpha]:    http://zzgary.info "TaoAlpha"
