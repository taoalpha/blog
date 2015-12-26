date: 2015-06-10 1:00:00
title: 修复rake aborted以及lsi warning问题
category: tech 
description: 昨天update了以下ruby到2.2.2, 然后就发现rake挂了... 后来通过重装删除修复后, 又发现lsi每次会弹出巨量warning信息...于是修改了下lsi源码的warning部分
tags: [ruby,rake,lsi] 
author: taoalpha
---

## 缘起

昨天升级了下ruby, 从2.0.0到2.2.2, 升级完jekyll, bundle等均完好无损, 当打包完一些更改push到github后, 想要用rake自动发布的时候发现rake不工作了...

## 修复Rake

### 错误信息

在jekyll跟目录运行rake后出现:

> rake aborted!
> require: cannot load such file -- jekyll

错误代码指示在Rakefile的require "Jekyll" 一行.

### 错误原因猜测

回忆了以下之前所有设计到jekyll和rake的操作就是ruby的升级了. 所以猜测应该是ruby升级所致. Google后没有找到合适的解答. 于是就自己折腾分析了一下, 猜测主要可能在与:

- ruby版本号已经从2.0.0提升到2.2.2, 但是`bundle show jekyll`的时候还是提示的是2.0.0的目录;

### 修复方式

我首先尝试了利用gem重新安装jekyll, 然后利用其路径验证问题是否是版本号的原因, 但是发现`gem install jekyll`命令一直处于卡死状态. 无论我切换[淘宝ruby源](https://ruby.taobao.org)还是自有源都无效. 猜测gem也出了一些问题.

接下来我尝试重新安装ruby 2.0.0, 试图恢复升级前的环境, 结果依然失败...

于是我又彻底卸载了ruby, 重新用homebrew安装了ruby最新的2.2.2版本, 并且清楚了bundle的gems目录(里面那个2.0.0的目录), 然后重新安装了bundler, 再用bundler去恢复了所有的gems.

成功!! 具体原因真心不知, Google没有找到解答, 只能自己瞎分析了, 如果有哪位知道原因, 记得告诉我哦

## jekyll lsi warning问题

### 问题描述

成功修复了rake后, 心情大好, 再次开启jekyll准备记录以下这一过程~ 结果就发现build的时候出现大量的warning信息... 发现是lsi建立索引的那一步出的问题, 问题如下:

> warning: Comparable#== will no more rescue exceptions of #<=> in the next release.
> warning: Return nil in #<=> if the comparison is inappropriate or avoid such comparison.

当前环境:

jekyll (2.5.3)
classifier-reborn (2.0.3)
rb-gsl (1.16.0.4)

### 修复问题

这次Google了下找到了一个遭遇相同的兄弟! 哈哈

[Fix lsi.rb Comparable#== warning #33](https://github.com/jekyll/classifier-reborn/pull/33)

根据解答, 大意就是需要替换出错行(237行)的`pair[0] == doc`判断为 `pair[0].eql? doc`.

why? 于是我查了下ruby中`eql?`和`==`的区别:

> #### == — generic "equality"
> 最常用的相等判断, 属于值判断;
> 
> #### eql? — Hash equality
> The eql? method returns true if obj and other refer to the same hash key. 一般Hash对象都会使用eql?来判断其成员之间的相等与否. 当然此外, 在数字判断上, `==`与`eql?`的区别也有点像严格判断(1 和 1.0, 后者就会判断为false);

虽然稀里糊涂, 但感觉很有道理的样子.. 传说中的不明觉厉吗...
