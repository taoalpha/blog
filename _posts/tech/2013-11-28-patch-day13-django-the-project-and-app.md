---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day13-django的project和app
tags: [app,Patch,django]
---

今天说下django下project和app的区别, 主要是这几天想要结合python做些小的项目,找来找去还是想要用django框架来搞~于是在之前直接搬用sunrunaway的django源代码修改样式后的代码基础上准备新开一个app去做搞一搞小项目~但因为之前只是照搬了一下,然后调整样式也主要是修改了template中的html,对于django本身并没有什么深的认知,所以这一次就从头开始学习一下~

首先是project和app的关系,因为是想要建立在原来的blog的基础上,所以也就没有单独再开一个django的project来做,而只是新建了一个app去做,这样也方便以后随时迁移~

那么,project和app的区别是什么呢?
<!--more-->
其实是一个包含的关系,一个project是一个整体的框架结构,其下可以包含多个app,这些app之间可以互相关联,共同构成一个产品,也可以完全不相关,分别是独立的两个产品~

说的更直白些,可以认为project是提供配置信息的,用来定义所有的数据库信息,静态文件,模板文件的位置,app列表等~而app才是真实的代码执行层面,在这里才能实现你想要的功能~

从上面也可以看出来,app和project并没有绑定在一起,所以app是完全可以支持迁移的,也就是一个app是完全可以存在在多个project之中的~所以想django本身含有很多project通用的app模块~

<strong>在新建app的过程中有个问题, 是发现一直重启nginx但是修改始终没有生效...后来才发现是用supervisor启动的环境配置,不重启supervisor的话,所有的py文件都不会重新编译,也就不会生效了~</strong>

如上,算是简单记录了一下今天抽空研究的django的app问题~过两天准备建一个小的分叉应用用于展示我在网上收集的infographic~
