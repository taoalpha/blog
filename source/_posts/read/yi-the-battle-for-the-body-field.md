category: read
description: ''
date: 2014-04-21 7:00:00
title: The Battle for the Body Field
tags: [HCIBib,翻译文章,html,译系列,alistapart]
---

原文来自alistapart(链接见文尾). 第一眼看到的时候以为是讲穿戴式设备的, 读完才知道此body非彼body...

===============正文==================

在90年代初期, 每一个网页背后都承载着一份赤诚的热爱. 但可惜的是, 任何管理一个大型网站的人最后都会遇到一个问题: 堆叠的HTML代码中掺杂着有价值的内容和模版以及粗糙的设计方法和其他一些难以维护的代码.

很快, 大型站点就彻底放弃了这种手写代码的方式. 他们把一个页面的核心内容存储在数据库中, 然后通过html模版把这些内容结合设计好的元素: 页脚(footer), 边栏(sidebar), 以及条幅广告(banner ads)来展现. 如今, 即便是像一本书的名字, 封面图片, 以及作者的简介这样的基础元素都被梳理成一个个html模版, 存储在独立的模版库中. 内容编辑们只需要一个个的填表, 而不是纠结在一个空白的canvas(画布)上, 而CMS(内容管理系统)模版则把这些元素按照需要进行重排.

<h3><strong>Trouble in Chunkytown</strong></h3>
这种模版和内容域结合的方式对于固定模式的内容而言, 效果是很突出的. 比如产品信息表, 图册以及播客. 完全符合NPR建立的成功的"一次创造, 随处使用"原则, 而且也很难发现一个内容管理系统或者发布工具不提供适用多种类型内容的模型.

但是这种组块有一个致命的弱点. 一旦描述文本混杂着嵌入的媒体, 复杂的调用, 或者其他的富文本信息, 格式化的模版就会遇到问题.

MSNBC.com是一个非常典型的例子. 作为它2013年再版的一部分, 有线新闻频道强化了它在新闻的深度和及时的特点上. 设计包含一些复用的模块来放置模版页: 视频以及播放列表, 图片画册, 投票插件, 相关报道等. 这些都如同典型的内容管理系统一样带来了很多的好处: 让设计风格更为一致, 简化了富文本元素复用处理的流程, 同时让响应时的css代码更容易管理.

<img src="http://d.alistapart.com/391/msnbc-screenshot_edit.jpg" alt="MSNBC news story, where rich media elements must appear at specific spots in stories and include captions, titles, related links, etc.">
MSNBC news story, where rich media elements must appear at specific spots in stories and include captions, titles, related links, etc.

但是不幸的是, 记者和编辑都一致坚持这会妨碍他们的工作. 它们需要混合多媒体视频, 画册以及投票, 相关报道, 针对每篇文章的特点来做. 把这些元素都割裂开来, 分成单独的一个个模版将会使保存和融合它们变得容易. 但是, 基于一些规则存在的CMS模版在展现这些内容的时候经常会破坏它们与相关的段落, 语句的联系.

这就是复杂的代码是如何在内容文本中挤占一席之地的. 很快WYSIWYG工具的添加允许在编辑中使用一些有限的HTML技巧. 但是在所有人意识到这将带来什么之前, 这种展示型的标记语言开始大肆流行. 移动布局被破坏, 本就很困难的跨频道内容复用变得更加困难.

一篇嵌入了tweets的博客, 一个利用相册来阐述每个产品的评测文, 一个需要别的文章作为支持的故事, 它们都面临着同样的问题: 这种模版加内容的方法不再适用于这种小口袋式的结构了.

<h3><strong>Why "clean markup" won't help</strong></h3>

如果你是在WYSIWYG战争期间成长起来的, 那个Adobe PageMill和Microsoft Word利用"Save to Web"功能把让人痛恨的标记语言散播的到处都是的时代, 你可能会觉得一个精简的html语言可能是正解. 去掉那些不必要的样式属性, 确保使用p标签而不是br标签, 合理的使用ul标签, 恰当的命名你的class, 那么世界就重归和平了.

实际上, 精简的, 有语义是很重要的, 但是它不能解决复杂的结构问题, 比如: MSNBC希望能够把插件绑定到普通的文本之中. 我们是有一些通用型的元素例如: ul, div以及span, 也有一些精确的如cite, table和figure, 最新的html5更包含了一些新的section, aside, nav等标签. 但是除非我们的内容真的就像这种无需样式属性的文本或者图片浮层, 我们就依然需要层级嵌套的html元素以及css类名来表达我们真的想要表达的.

想象一下要嵌入一个简单的图册到一篇文章中. 他的标记语言可能是非常间接而且语义正确的, 但是实际上, 图册显示的元素包含了一个标题, 3张图片, 一个链接到详情页, 以及一段说明文字? 这些都是随着时间可能会变更的设计方案, 我们需要把它们单独从组成html的内容中抽取出来.

``` css

    <aside class="gallery">
        <h1><a href="gallery1.html">Gallery Title!</a></h1>
        <figure>
            <a href="photo1.html"><img src="photo1.jpg" /></a>
            <a href="photo2.html"><img src="photo2.jpg" /></a>
            <a href="photo3.html"><img src="photo3.jpg" /></a>
        <figcaption>Custom caption</figcaption>
        </figure>
    </aside>

```


这个问题同样并不仅限于印刷业. 我的团队最近在为一个公司的hr部分做一个健康保险的项目的时候遇到了类似的问题. 在50,000 个页面的站点中包含了很多复杂的逐步的提示, 还有为特殊员工定制的特殊步骤, 以及在不同国家的超时设置等... 即便是利用WYSUWYG编辑器, 对于这个公司的商业用户而言还是太过复杂了点.

核心的问题是语法的匹配错误问题. 虽然标准的html对一个设计师而言已经足够表现复杂的内容了, 但是就以独立呈现的模式来说, 它还不能够准确的描述和存储内容. 这也是为什么WYSIWYG工具会让事情变得更糟: 没有让内容创建者逃开标记语言的复杂, 它让人们更容易的使用错误的语法来描述内容.

如今, 因为我们识图利用复杂的富文本元素去融合跨平台的设计需求, 我们就直面了这座墙. 我们发展出来的模版-域的方法无法帮助我们解决内容和HTML工具的匹配错误问题.

(待续...)

<strong>Links</strong>
<ol>
    <li><a href="http://alistapart.com/article/battle-for-the-body-field">原文: The Battle for the Body Field</a></li>
</ol>

