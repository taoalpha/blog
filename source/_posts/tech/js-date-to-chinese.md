date: 2015-05-12 5:00:00
title: JS实现中文日期的方法
category: tech 
description: 如何把默认的date类型转换为中文日期表示形式...
tags: [js,日期转换] 
author: taoalpha
---

这是一篇草稿转正的文章, 一直忘记发布了.

当时为了让blog左侧随机图不至于太空, 所以加入了天气预报的彩蛋. 目前还没做太复杂的地理位置判定, 所以按照我所在位置给予的北京天气, 之后会考虑修改成地理位置相关的天气.

因为要显示天气和日期, 英文的比较好说, 只需要用默认的`toDateString()`函数转换即可. 中文的则需要做一个简单的转换, 下述是我所使用的方法, 其实就是把日期数字和中文汉字对等起来而已~
``` javascript
var day = new Date(dt).getDate()
var month = new Date(dt).getMonth()
var Dcharacters = ["","一","二","三","四","五","六","七","八","九","十"]
var Mcharacters = ["","十","二十","三十"]
// 汉字对应的版本, 因为日月转换规则一致, 所以可以共用的~
// 设计的规则是分成十位和个位进行分别转换, 所以因为考虑到都有没有(十位/个位)的情况, 首个元素都给予的是空值
var ZdataM = Mcharacters[Math.floor(month/10)]+Dcharacters[month % 10+1]
// 月份的转换, 十位+个位
var ZdataD = Mcharacters[Math.floor(day/10)]+Dcharacters[day % 10]
// 日子转换: 十位+个位
```

没有做全部日期测试, 所以如果您发现任何问题请及时告诉我哈~

[TaoAlpha]:    http://zzgary.info "TaoAlpha"
