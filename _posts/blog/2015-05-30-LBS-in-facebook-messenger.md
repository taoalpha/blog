---
layout: post
title: Facebook Messenger成为跟踪神器
description: harvard的一个学生发现了messenger中位置信息的暴露, 做了一个插件整理这些位置数据, 然后发现玩大了...然后...就被facebook要求下线了...
category: blog
tags: [Facebook-Messenger,GPS]
author: taoalpha
---

本文是前几天一位harvard的学生[Aran Khanna](https://github.com/arank) 在 [Medium](https://medium.com/@arankhanna/stalking-your-friends-with-facebook-messenger-9da8820bd27d)上发布的. 介绍了他是如何利用facebook messenger网页端中公开的位置信息制作的一个chrome插件, 可以呈现你的好友甚至是陌生人的位置记录. 而你越是对messenger的依赖程度越高, 其位置记录功能就越精确... 利用这个工具, 你完全可以跟踪某个好友甚至是群组中的某个陌生人过去一段时间内的行踪... 听起来就很惊悚不是吗... 快去看最新的美剧[stalker](http://v.qq.com/cover/2/2idanx1okscg6dg.html)吧...

_更新: 应facebook的要求, 作者已经下线了发布的插件(不过源码还在github上), 同时facebook本身也关闭了网页端message的位置共享功能, 所以这个插件本身也失效了. 不过移动端的位置共享依然还在, 且默认开启的._

原文颇长, 我就简单概述下.

facebook作为世界上最大的互联网王国, 用户的数量和活跃度一直让其引以为傲. 而旗下的messenger更是很多用户聊天首选. 但是messenger默认信息发送时附注地理位置信息这一点就隐藏着一些非常不好的可能.

作者经常使用messenger联系一起打扑克的好友和牌友们, 所以当他发现messenger每次发送信息时有一个附注位置信息的选项时. 他就开始研究起messenger的历史信息. 结果发现这些信息比他自己想的还要有趣...


 ![A screenshot of the map the extension creates:](https://d262ilb51hltx0.cloudfront.net/max/800/1*FyAbfBKXGFpoNU-W0dEMSQ.png)

首先, 它可以轻松的让你定位你的好友或者群组人士(定位到其上次使用messenger的时间)...

而因为messenger本身存储的位置信息是高精度的经纬度, 从而完全可以精确定位到米级别... 所以如果你抽取某个好友的聊天记录, 你就完全可以获取到其的位置记录, 比如下面这个是作者的一个stanford熟人几周内的活动记录:
 ![The location history data over the course of a few weeks for my Stanford acquaintance.](https://d262ilb51hltx0.cloudfront.net/max/800/1*uLtnaYTtB-ySWYWeRbmhMg.png)

甚至你可以根据时间筛选从而定位到此人的宿舍...

 ![Where my acquaintance who goes to Stanford sleeps.](https://d262ilb51hltx0.cloudfront.net/max/800/1*UjOiHrFnQhU25xcOMcPU7A.png)

而因为群组的特性, 你甚至可以获取到群组中那些与你不是好友的人的位置信息... 只要TA发过一次附带位置信息的消息即可... 发的越多, 越准确... 惊悚中...

作者甚至拿自己测试了下这种记录和手机自身的记录的差别, 结果发现当你在messenger上足够活跃时, 其精准度惊人, 如下就是某个活跃天的两厢对比(下图是手机定位记录):

![My scraped messenger location history for a certain active day](https://d262ilb51hltx0.cloudfront.net/max/800/1*1VZq8ArS8LCTYyxmjWOfAA.png)

![My Android phone’s location history for that same day.](https://d262ilb51hltx0.cloudfront.net/max/800/1*xQ3Jzh4UoIVg6Vwsf4zajQ.png)

作者写此文以及发布此插件的主要目的是提醒大家身处网络时代, 隐私的泄露经常是神不知鬼不觉的. 尤其是对于共享GPS这种, 总是很难预见到其有什么不好的后果... 所以人们经常很轻易的就给出了自己的这些数据.

最后分享下[作者的github](https://github.com/arank) 以及[这个插件的repo地址](https://github.com/arank/marauders-map). 快去[Medium](https://medium.com/@arankhanna/stalking-your-friends-with-facebook-messenger-9da8820bd27d)给作者点赞吧~
