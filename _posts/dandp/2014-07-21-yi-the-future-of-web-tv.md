---
layout: post
category: dandp
description: ''
title:  The Future of Web TV
tags: [HCIBib,Web TV,多屏,Chromecast,译系列,翻译,翻译文章]
---

2013年末, 时代杂志称赞Google的Chromecast为"年度工具". 一个酷炫的用来投影互联网视频到你的电视屏幕的小工具, 售价仅为35$, 也正式这个小玩意, 提供了一种全新的网络电视交互形式, 用Netflix执行官Todd Yellin的话说: (它)将引领第二屏TV的主流.

当下有很多设备都可以将你的大屏幕和网络互联起来, 总的来说可以粗略分为以下3类:
<ul>
	<li>三星,索尼,LG等出厂的智能电视. 目前许多待售的电视都属于智能电视, 虽然调查显示接近一半都没有接入网络之中;</li>
	<li>类似Apple TV和Roku系列的媒体播放器. 他们的主要作用是作为互联网视频的载体, 所以这些设备肯定都是联网的了;</li>
	<li>像Xbox和PS这种的游戏手柄. 虽然游戏是它们的核心功能, 但是他们本身网络电视的功能也被广泛的使用了;</li>
</ul>

虽然明确的统计数字很难找到, 但是如下由SM,Parks Associates, Strategy Analytics 以及IDC提供的三种设备的市场占比(主要基于各厂商的出货量)粗略报告也能看出一二:
<img src="http://uxmag.com/sites/default/files/uploads/wijering-the-future-of-web-tv/webtv-platforms.jpg" alt="各类网络视频媒介的占比" />

虽然游戏手柄方面似乎大占优势, 但是他们真正用于网络用途的本身又是一个很小的比例了. 比如, 在StatCounter的全球设备调查中, 手柄的占比相比于台机, 平板和手机而言还是非常微小的.

<img src="http://uxmag.com/sites/default/files/uploads/wijering-the-future-of-web-tv/online-platforms.jpg" alt="Online Platform Comparison" />

不能更进一步的问题同时出现在发行商和客户两边.

<strong>应用开发</strong>

对于多数发行商而言, 提供对网络视频平台的支持是比较困难而且高成本的.

每一种平台其实都是被一个非标准的, 甚至是过时的语言和开发IDE所支持的. 三星,LG以及索尼都在使用一些偏离HTML5的东西, 再配上问题多多的SDK... Xbox 和 PS3 则同时使用自己的SDK, 并要求一些基本的游戏开发技巧来创建媒体应用. Apple则使用的Object C, ROku用的是Brightscript, 一个基于Vbscript/javascript的变体. 顺畅的播放视频流本身已经挺有挑战了, 更何况说还要加上推广和数据统计分析的相关问题...

即便所需的技能都能满足, 依然存在一个ROI(成本和回报)的问题: 有多少人会真的安装我的app, 并且观看里面的内容呢? 通过广告/订阅/市场获取的收入能够抵过开发的成本吗? 通常来说, 只有那些提供娱乐广播的视频大户, 例如netflix才敢给出肯定的答复.

<strong>用户体验</strong>

对于消费者而言, 最大的问题在于用户体验. 智能电视经常(也确实)因为丑陋的界面而被批评, 但是UX的问题可能潜藏的更深. 对于入门者, 设置当下繁多的遥控设定就是一个很大的问题了. 遥控器还经常丢失... 经常设计的很难理解很难搞懂... 他们基本对文本输入都非常的不友好, 但实际上对web tv而言是很重要的. 想象一下你为了更改频道, 搜索内容,登录以及创建付款认证而需要做多少工作...
<img src="http://uxmag.com/sites/default/files/uploads/wijering-the-future-of-web-tv/onscreen-keyboard.jpg" alt="这比起小米电视差得远到天边了啊..." />
另一个问题则是探索内容的问题. 在台机或者手机上, 这很简单而且非常充裕. 有搜索引擎, 社交网络, 邮件短信, 以及各种超链接都提供给了我们一个每天都要面对的巨大的内容流. 而在WebTV平台上, 只有一个光秃秃的应用商店... 即便当应用商店慢慢发展起来, 出现一些我们日常使用的app, 它们也经常只能被动的接受内容. 那些社交网络, 搜索引擎, 网页, 以及邮件客户端都完全不能在智能电视上使用...

<strong>初识Chromecast</strong>
介绍完了这些渣渣, 我们就可以聊聊Google的Chromecast了, 不愧为google出品, 必属精品啊. Chromecast极大的消除了上述的诸多问题. 它采用了一个非常创新的接收模型:
<ul>
	<li>Chromecast的接收对象完全由HTML/CSS/JavaScript写成的, 所以开发起来就很容易也很明了了. 除掉一些特殊的部分, 基本上如果一个接受对象, 通常是网页, 能够在chrome下正常的显示, 那么就能在chromecast上正常显示.</li>
	<li>chromecast没有遥控器. 取而代之的是, 它以来于你的笔记本, 手机或者平板来控制, 浏览, 启动app和展示内容. 使用的也是标准的HDMI-CEC, 甚至可以帮你启动电视.</li>
</ul>

更多的是, chromecast利用你的手持移动设备来输入的功能带来了各种有趣的多屏交互形式. 比如, Chromecast的YouTube接受器允许使用者从自己手机上的Youtube app上收集一个播放列表来在party的时候播放; 而且因为内容本身是来自网络的, 所以即便手持设备关闭后, 内容依然可以继续播放.

<img src="http://uxmag.com/sites/default/files/uploads/wijering-the-future-of-web-tv/chromecast-schema.jpg" alt="" />

这种交互的模型也正是chromecast得以区别于apple tv 饱受赞誉的Airplay功能的重要原因. 因为Airplay虽然提供了一个快捷的方式来投放视频到TV上, 但是却没有提供这么丰富的逻辑性(例如投放广告等)和交互(比如播放列表). 在一定程度上, chromecast是Airplay的一种进阶模式, 从一个低级的接收器变成一个更加智能的存在.

<strong>展望下未来?</strong>

虽然还没有宣布具体的销售额, 但是Chromecast的销售情况明显不错. 它从一上市开始就一直是Amazon电子设备的热销产品. Google 的CFO 在最近一次发布会上已经宣布Chromecast已经卖脱销了, 言称"是整季度销量最好的产品", 而Android SVP Sunder Pichai 也曾说销量破百万了. 下一步无疑就是把chromecast引进到其他的国家来进一步的提升销量和销路.

同时, 竞争并没有停歇. Apple TV, 曾经一度被Steve Jobs称为hobby的产品, 目前也是身价破百亿的大土豪. 随着2012款开始降价销售, 已经有传言新一代设备即将上市了. 同时, Roku同学也不甘落后, 刚刚上市了一个50$的电视棒, 提供了youtube和netflix的多屏支持. 微软同样也推送了一个xbox的更新, 提升了其SmartGlass--多屏技术--的功能.

无论最终哪个平台能够脱颖而出, 由chromecast开创的这种多屏交互模型都将会一炮而红, 而全世界的网络视频发行商们都会收益其中, 它同时提升了丰富的交互性和接入TV的钥匙.


<strong>Source links:</strong>
<a href="http://uxmag.com/articles/the-future-of-web-tv" target="_blank">the future of web tv| UX mag</a>
