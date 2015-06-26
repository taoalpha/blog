---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-69-初尝Evernote接入(php)
tags: [Evernote,应用推荐与技巧,coding,Patch]
---

前段时间把RNhelper接入Evernote的事情搞定了, 本来想立刻发以下这篇文章, 不过因为当时key还没有激活, 所以只能在evernote的sandbox里面测试, 就想着等正式发布在发个总结文吧~ 今早收到了key激活的邮件, 于是立刻去改了代码,验证线上生效了, <a href="http://callmet.zzgary.info/2014/11/25/announcement-rnhelper-official-connected-to-evernote/" title="公告-RNhelper接入Evernote" target="_blank">也发了公告文</a>, 所以这里就做个简单的Evernote接入总结吧:

<strong>流程:</strong>

<ol>
	<li><a href="https://dev.evernote.com/#apikey" title="申请APIkey" target="_blank">申请developer key和secret</a>, 以及<a href="https://sandbox.evernote.com/" title="evernote的sandbox" target="_blank">sandbox的帐号</a>, 这个是evernote的官网测试环境, 这些在官方的开发者网站就可以搞定了;</li>
	<li>拿到key和secret之后, 即可以开始部署你的接入部分了, 我这边主要借鉴了<a href="https://github.com/evernote/evernote-sdk-php" title="官方php实例" target="_blank">Evernote-SDK-php这个官网实例</a>, 先通过这个实例你大致就可以摸清evernote的接入逻辑了~</li>
	<li>搞清楚实例以后, 就需要你去查询一下<a href="https://dev.evernote.com/doc/reference/" title="官方API文档" target="_blank">官方的api接口</a>, 找到你需要用到的一些接口函数, 以及它们需要的参数, 格式和返回的格式等等; </li>
	<li>接下来就是微调实例, 给functions.php里面加上你自己需要的一些调用函数, 比如<code>getUser()</code>啊, <code>addNote()</code> 等等, 然后调整你的除法逻辑, 就可以了;</li>
	<li>在调整过程中, 你可以通过sandbox环境实时的进行验证, 直到准确无误后, 你就可以在<a href="https://dev.evernote.com/support/" title="support by evernote" target="_blank">官方的Support网站</a>上进行key激活了, 过程也比较简单, 就是提交申请表, 然后等待审批就可以了, 我这边大概是5天激活的(中间有一个周末, 大概在3个工作日), 这个过程不用太着急, 从论坛的反馈情况来说, 似乎审批人员要非常细致的审核你的key的使用情况, 然后才能确定是否给你激活;</li>
</ol>

需要注意的几个地方:
<ol>
	<li>在修改实例进行自己的开发时, 可能会出现类似定义new Note()发现报错class不存在, 这主要是因为在顶部的use应用中没有声明note这个类, 所以你只需要在顶部声明一下就可以了:<code>use EDAM\Types\Note;</code></li>
	<li>针对创建笔记的请求, 需要按照<a href="https://dev.evernote.com/doc/articles/enml.php" title="evernote支持的格式" target="_blank">evernote提供的文档格式</a>来, 基本来说支持大部分的tag, 在你的正文外层需要套上evernote的一个标准壳:<code><?xml version="1.0" encoding="UTF-8"?><!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd"><en-note>+content+</en-note></code>, 如此基本就可以被正确识别里面的html部分了;</li>
	<li>在之前的<a href="http://callmet.zzgary.info/2014/11/25/announcement-rnhelper-official-connected-to-evernote/" title="公告-RNhelper接入Evernote" target="_blank">RNhelper公告</a>中也说过我从cookie迁移到localstorage的原因, 不过因为一旦迁移到localstorage之后就不能直接通过php去获取这个属性了, 因为php作为server端的语言不能直接和本地存储的localstorage交互的, 这个时候最简单的方法就是通过post发请求,把localstorage中需要的内容直接post给php来调用php的函数;</li>
</ol>

哦了~ 有兴趣的朋友可以自己试试接入evernote, 还是比较好用的, 以后就可以写markdown直接保存到evernote中啦~哈哈

