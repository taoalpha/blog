category: read
description: ''
date: 2014-08-15 9:00:00
title: 10 Tips to Get You Started with Responsive Design
tags: [关于HCI,译系列,Responsive Design,翻译文章,响应式,设计]
---

结合响应式设计, 出现了很多优秀的原则, 比如: Mobile First等等. 那么到底该如何进行响应式设计呢?

==================正文=====================

最近有项研究表明: 大约1/4的美国人只用手机上网!! 而在全世界, 每5个人就会有一个拥有智能手机, 而至少有一半人会使用它来浏览网络.

如果你的网站在这些设备上不能很好的浏览的话, 你真的损失了很大一部分的手机用户. 快来拥抱响应式设计吧. 万事开头难, 不过下面这些小贴士可能会有所帮助.

<strong>1. Go Mobile First</strong>

<img src="http://uxmovement.com/wp-content/uploads/2014/08/responsive-design-1.png" alt="Mobile First">

在你准备为笔记本,台机等大屏设计网站时, 考虑下手机用户的浏览体验. 很多设计师现在开始使用移动居先的策略了. 为什么呢? 因为移动端正在超越PC端.

大概1/7的用户会使用他们的移动设备浏览网络. 所以先聚焦在手机用户如何和你网站进行交互, 之后在慢慢的扩展到大屏范围.

<strong>2. Get Acquainted with Media Queries.</strong>

<img src="http://uxmovement.com/wp-content/uploads/2014/08/responsive-design-2.png" alt="Media Queries">

media queries(媒体查询)是CSS3引入的一个新功能, 可以允许页面元素的样式随设备种类和尺寸大小而变化. Media Queries会查询设备的分辨率, 宽, 高以及是否横屏. 然后根据这些信息来判断改应用哪些CSS样式. MQ可谓是响应式设计的首要推动力.

<strong>3. Understand What Mobile Means for your Users</strong>

<img src="http://uxmovement.com/wp-content/uploads/2014/08/responsive-design-3.png" alt="Mobile Users">

用户在使用手机上网时, 他们的操作等交互方式都和桌面有很大的差别. 你可以利用分析数据来了解用户为什么用手机访问你的网站. 比如他们可能想要通过搜索框更快的获取信息, 如果你的用户中大多数都这么做, 那么就可以修改你的搜索框, 让它更加明显可观.

<strong>4. Use Percentages</strong>

<img src="http://uxmovement.com/wp-content/uploads/2014/08/responsive-design-4.png" alt="Percentages">

响应式设计中最困难的部分就是如何作出一个流畅的结构. 一个流畅的结构会更好的辅助media queries, 从而更好的针对不同视窗显示.

你不需要针对每一个视窗界限都设置断点, 你可以设定最大的布局尺寸. 然后在它里面, 你就可以通过百分比而不是像素来定义宽高了. 这样就可以让网站基于百分比来安排布局了.

<strong>5. The Need for Speed</strong>

<img src="http://uxmovement.com/wp-content/uploads/2014/08/responsive-design-5.png" alt="Speed">

响应式布局有一个缺点就是会影响加载速度. 实际上, 近期的一个研究表明, 48%的响应式站点平均加载速度在4-8s左右. 这个加载速度在1997年的时候是完全可以接受的, 但是到今天, 就是完全不能接受的了. 要知道64%的智能手机用户对一个站点的加载时间预期是4s以内的.

最主要的拖慢原因在于那些没有优化的图片. 千万不要让这些图片影响你的加载速度. 你可以通过一些类似Adaptive Images或者TinyPNG等工具来缩减你的图片大小.

<strong>6. Eliminate the Unnecessary</strong>

<img src="http://uxmovement.com/wp-content/uploads/2014/08/responsive-design-6.png" alt="Unnecessary">

去掉那些多余的元素, 不仅是为了用户体验, 同时也为了提升网站的加载速度. 一个网站如果太臃肿, 元素过多也是不能够让用户满意或者愉快的. 可以利用GZIP等方式来进行压缩.

<strong>7. To Hamburger or Not to Hamburger</strong>

<img src="http://uxmovement.com/wp-content/uploads/2014/08/responsive-design-7.png" alt="Hamburger">

汉堡包图标 - 即用三条线来表示一个隐藏的菜单 - 经常处于争论的焦点... 一些人很讨厌它, 但还有一些人很喜欢它, 但是怎样才是最好的方式呢?

对于响应式设计, 最重要的往往是方便. 如果一个用户必须通过点击icon才能看到菜单, 这本身就不方便了. 如果你把最长用的菜单显示出来就能节省用户不少的时间以及防止他们产生浮躁感. 所以, 尽量不要把常用的链接放在你的汉堡包菜单导航中.

<strong>8. Make it Readable</strong>

<img src="http://uxmovement.com/wp-content/uploads/2014/08/responsive-design-8.png" alt="Readable">

网页千万不要做到需要用户使用放大缩小才能阅读的地步. 请设置足够大的字体, 方便在移动端的小屏幕下阅读. 我推荐的设定是文本16px,1em或者12pt. 附上一个很方便的<a href="http://pxtoem.com/">px to em</a>链接. 当你设计标题时, 可以使用如FitText的工具来创造响应式的字体.

<strong>9. Use the Right Button Size</strong>

<img src="http://uxmovement.com/wp-content/uploads/2014/08/responsive-desing-9.png" alt="Button Size">

虽然在移动设备上可谓是寸土寸金, 但是还是要尽量避免小按钮. 要确保你的按钮至少是44x44px大小的, 以方便触击. 还有个技巧是多使用padding而不是margin. Padding可以增加可触击区域的大小, 而margin不能的. Margin只能增加围绕按钮周围的空白区域.

<strong>10. Design for Screen Orientation</strong>

<img src="http://uxmovement.com/wp-content/uploads/2014/08/responsive-design-10.png" alt="Orientation">

根据统计, 移动用户中竖屏比例(59%)是超过横屏比例(41%)的. 所以虽然我们需要尽量设计在两种方式下都好看的界面, 但可以给予竖屏更多的经历. 记得确保你的图片不会被拉伸~

<strong>Final Thoughts</strong>

响应式设计可以让你使用各种各样设备的用户都能轻松的访问你的网站. 以上这些都是一些基础的贴士, 来帮助你开始你的响应式设计. 那么, 那些网站应该遵循的最佳方案来提升其用户体验的又是哪些呢?

<strong>Source Link:</strong>
<a href="http://uxmovement.com/mobile/10-tips-to-get-you-started-with-responsive-design/">原文: 10 Tips to Get You Started with Responsive Design from UX movement</a>
