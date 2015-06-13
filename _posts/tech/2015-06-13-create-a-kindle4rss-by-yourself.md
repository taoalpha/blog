---
layout: post
title: 利用KindleEar定制属于你自己的RSS推送服务 
category: tech 
description: 喜欢读书的人一定有一台kindle! 他们也通常是RSS的忠实用户之一, 而rss和kindle的结合可谓是此类人绝对的强需求啊. 本文介绍如何通过GAE以及KindleEar的结合定制属于自己的rss推送kindle服务.
tags: [kindle,python,rss,GAE] 
author: taoalpha
---

## 缘起

正巧最近Kindle4RSS会员到期, 本来计划续费的. 不过正巧有朋友推荐了[KindleEar](https://github.com/cdhigh/KindleEar), 而我又恰好之前因为[给博文添加GA的pageview]({% post_url tech/2015-06-07-add-google-analytics-pageviews-to-jekyll-blog %}), 用到了GAE, 而从我从GoAgent转移到Shadowsocks之后, 空出来了不少GAE的帐号, 于是就干脆拿来用喽~

## 搭建方法

搭建方法其实[KindleEar-Readme](https://github.com/cdhigh/KindleEar/blob/master/readme.md)中已经描述的比较清楚了, 我简单根据自己的搭建流程概括如下:

- 申请GAE帐号创建app, 搭建本地的GAE SDK, KindleEar也是Python写成的, 所以依然用Python的SDK即可, 创建好了之后就可以了, 因为这一次没有用到google的api服务, 所以不需要我们申请api权限之类的了;
- 下载[KindleEar](https://github.com/cdhigh/KindleEar), 你直接`git clone`到本地即可;
- 修改`app.yaml`, `module-worker.yaml`两个文件中第一行的appid为你创建的appid,`config.py`中的email修改为你GAE的邮箱以及应用的域名:`appid.appspot.com`;
- 基本上你需要修改的就这些喽, 剩下的就是通过SDK的`appcfg.py`命令来部署了, 如果你已经建立了symbol link, 那么你应该可以直接执行appcfg.py的命令, 否则的话, 你需要到SDK安装目录去执行`python appcfg.py`(即此文件所在地址);
- 因为其使用了两个yaml配置文件, 包含了两个模块, 所以我们需要部署的时候将两个yaml都update一下, 即`appcfg.py update path_to_file/app.yaml path_to_file/module-worker.yaml`;
- 部署成功后, 需要再次执行`appcfg.py update path_of_kindleear`来更新`cron, queue`等, 因为随着GAE的升级, 目前更新yaml的过程不会自动更新这些了;
- 如此基本就ok了, 接下来你只需要打开你的app域名`appid.appspot.com`就能使用了~ 默认的登录用户和密码都是admin!

目前来说KindleEar支持自定义RSS的添加, 多账户, 你完全可以把服务分享给你的朋友们, 也完全支持定时推送, 这个很实用! 

最为牛叉的扩展在于, 你完全可以自己修改其python代码来优化对应的环节, 比如它自身开发支持的`自定义RSS采集`, 你就可以通过参照其books下的文件来自己编写自己的python采集文件!!!

亲身体验下来, 推送还是很到位的, 立即推送的同步时间大概也只有2-3分钟的延迟, 很赞!

## 一些Issue解决方法

部署过程遇到了几个问题, 不过基本都在[KindleEar- FAQ](https://github.com/cdhigh/KindleEar/blob/master/static/faq.html)上或者[KindleEar - Issues](https://github.com/cdhigh/KindleEar/issues)上解决了~ 列举如下:

- 刚部署后发现登录后的`/my`页面无法展示, 出现interval error:

  **问题原因以及解决方案:** 因为KindleEar需要使用GAE的数据库, 所以其部署后需要创建数据库, 而这一步需要一点时间的~ 你可以在[GAE Console Database](https://console.developers.google.com/project/zzgary92/datastore/stats)里面查看其创建的进展, 等到由building变到serving就说明创建完成了~ 如果显示没有创建的话, 你可以手动执行:`appcfg.py update_indexes KindleEar` 或者`update KindleEar`即可;
- 部署后点击deliver now现实interval error:

  **问题原因以及解决方案:** 类似上面的问题, 如果你去log面板看日志的话, 也会发现其提示UnknowQueueError, 原因在于你可能没有部署`queue`的部分, 同样的, 你只需要执行`appcfg.py update KindleEar`就可;

恩~ 根据GAE的免费配置, 基本上可以支持10-20个人左右的同时使用~ 快去分享给自己的朋友吧!! 

Tips: 为了你更好的使用RSS, 请不要泛滥订阅... 要量力而行... 提倡精品阅读! 做有质量的阅读人~

