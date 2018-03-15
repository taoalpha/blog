category: readings
description: ''
date: 2014-07-24 7:00:00
title:  High-Performance Browser Networking .1.Preface
tags: [翻译文章,技术文章; 浏览器性能; 译系列]
---

chrome一直以极速著称, 当然这和webkit内核有很大的关系, 但是本身chrome在网络处理上也有着非常多的优化方案, 综合了这些优化和本身优质的内核属性, chrome才能实现如今的极速~ 

进入正文前, 先介绍下<a href="https://www.igvita.com/posa/high-performance-networking-in-google-chrome/" target="_blank">原文</a>或者说<a href="https://www.igvita.com/" target="_blank">原书</a>的作者: <strong>Ilya Grigorik</strong>.

Ilya是google的一个网络性能开发工程师, 其在很多方面都有杰出的成绩~ 有兴趣的可以去<a href="https://github.com/igrigorik" target="_blank">大神的github</a>上看看大神都在做什么项目, 顺带能观摩学习下大神的代码~

==================================正文=============================

<strong>前言</strong>
--Steve Sounders, Head Performance Engineer, Google, 2013

"优秀的开发者知道如何做, 伟大的开发者知道为什么这么做."

我们一直都以此名言勉励自己. 我们都希望成为那个知道而且可以解释我们所使用系统的底层原理的人. 但是, 如果你是一个网页开发者, 你可能反而要走相反的路子.

网页开发者现在变得越来越细分. 你是什么类型的开发者呢? 前端? 后端? 韵味? 大数据分析? UI/UX(交互设计)? 存储? 视频? 信息流? 我还可以给这个长长的列表中加入性能工程师这一细分领域. 

我们很多时候很难平衡技术的基础学习和前沿领域的了解. 但是, 如果我们不能了解这些基础知识, 我们的知识系统一定很空洞, 很浅薄. 仅仅知道一个技术手段的顶层使用是不够的, 尤其是在面对一些复杂的问题时, 一旦出现了一些莫名其妙的问题, 那么依赖的还是掌握底层原理的人.

这也是为什么本书(High Performance Browser Networking)如此重要了. 如果你是一个网页开发者, 那么你的基础知识就是网络以及网络协议基于的金字塔结构: TCP-TLS-UDP-HTTP以及其他一些东东. 这其中的每一个协议都有其自身的性能属性特点和优化方法, 而为了创建高性能的应用, 你就需要去了解网络的工作形式, 为什么是这样的而不是那样的~

感谢上苍, 你已经找到了如何阅读本书的方法. 我真希望在我开始网络编程之路时能够有这本书啊. 当初完全依靠那些懂得网络原理的前辈的言传身教以及自己硬啃那些说明指导才一步步走到现在的. HPBN一书集合了一个网络界的前辈--Ilya Grigorik--他把自己对网络的方方面面了解都融合集成到了这本书中.

在本书中, Ilya详尽解释了许多关于网络的原理性知识: 比如为什么延迟(latency)是性能的绊脚石. 为什么TCP并不总是最好的传送机制以及UDP可能是你更好的选择. 还有为什么链接复用是个非常关键的优化. 紧接着他更进一步的提供了很多提升网络性能的具体方法. 想要减少延迟? 尽可能在里客户端更近的服务器端中断会话. 想要提升链接的复用? 启用链接的长效性. 就是这种如何做和为什么这么做的结合让本书传达的知识更有可操作性.

Ilya 阐述了网络的基本原理并且基于此介绍了很多协议和浏览器方面的前沿知识. HTTP 2.0的有点也有所介绍. 回顾了XHR以及它的局限性, 和由此引发的跨域资源共享问题的介绍.Server-Sent Events, WebSockets, 和 WebRTC 也都所涉及, 带我们领略了一些浏览器网络的最前沿.

本书的两大核心就是基础原理和前沿知识. 性能是帮助我们理解网络的根本, 并将之转化到性能是如何影响到我们的网页和用户的. 它把复杂的概念转化成了我们可以真正用于提升优化自己网站并创造更好的用户体验的工具. 这一点很重要, 这也是你为什么要阅读本身的重要原因.

浏览器是当下受众面最广的部署平台了: 它出现在每一台智能手机, 平板, 笔记本, 台机和每一个介于其中形式的载体上. 实际上, 从目前设备的涨势来看, 我们预期2020年的时候入网设备能够达到200亿--至少有一个浏览器而且至少可以接入wifi或者信号基站. 而平台的形式, 设备的厂商, 以及操作系统的版本都不是问题, 每一个设备都至少会有一个网页浏览器, 而浏览器本身功能也在越发丰富了.

我们如何看到的浏览器已经和过去的老版本有了千差万别, 这得益于进来的一系列创新: HTML, CSS形成的展示层, JavaScript作为web集成的新语言被引入, 以及HTML5的提出和其新的API都在继续提升着新平台提供高性能应用的能力. 当今再没有别的技术或者平台能够做到这样, 这么的面向全部人类, 同时这也是如今各种机会, 创新频出的领域.

实际上, 再没有比浏览器内部的网络基础机构更适合阐述网络的快速迭代和创新了. 历史上, 我们曾经受限于简单的HTTP请求式交互, 而如今, 我们拥有了更加丰富的机制, 可以实现更加有效的信息流传递, 双向而实时的交流, 自定义应用协议的传递以及一对一的视频会议, 各方之间的数据直接传输等等, 只需要JavaScript, 足矣.

最终结果? 不计其数的联网设备, 已有服务和新服务中不断壮大的用户基数, 以及对高性能应用的高需求. 速度一直都是一个功能特点, 甚至对一些应用而言, 它是决胜功能点, 而一个高性能的网页应用也需要一个对浏览器如何工作以及和网络的交互有扎实, 基础的了解的人, 这也是本书的受众.

<strong>About this Book(关于本书)</strong>

我们的目的是能够覆盖到每一个应该了解网络是如何工作的开发者: 我们使用的是哪一种协议, 它有什么局限性, 如何最大化的优化你的性能来使用你的网络, 以及浏览器提供了什么样的网络特性来让你使用.

在此过程中, 我们会深入的了解TCP, UDP以及TLS协议, 以及如何去针对性的优化我们的应用和基础结构. 接着我们会深入的了解下无线和移动网是如何工作的--就是无线电波这家伙, 比较难懂--还会讨论一些它对我们设计和搭建我们自己的应用的启发. 最后, 我们们仔细剖析一下HTTP协议是如何工作的, 并调查下浏览器中许多新的,让你兴奋的网络特性:
<ul>
	<li>即将到来的HTTP 2.0的改善;</li>
	<li>新XHR的特点和能力;</li>
	<li>结合Server-Send Events的数据流</li>
	<li>使用WebScoket的双向沟通;</li>
	<li>点对点的视频和音频沟通--WebRTC;</li>
	<li>点对点的数据交互--DataChannel</li>
</ul>

理解每一个字节都是如何传递的,以及每个传递过程和协议的属性对我们创建高性能应用都是至关重要的知识. 毕竟, 如果我们的应用卡死在网络上, 那么无论怎么渲染, JS或者其他的优化方式都是没有意义的. 我们的目标是通过近可能最大的提升网络性能而减少等待的时间.

HPBN一书将会是任何一个乐于研究优化传递和应用性能的开发者的菜, 更广面的, 任何一个不满足于一个简单的checklist, 而是想要了解浏览器和底层协议是如何工作的, 有着强烈好奇心的人, 都是本书的受众. 其中如何做以及为什么做会交替进行: 我们将会覆盖到很多实际的建议, 帮助你更好的进行配置和架构规划, 我们还会探究下每一种优化方法的益处和代价.

<strong>Conventions Used in This Book(本书使用的一些习惯表达)</strong>
<ul>
	<li><i>斜体:</i> 代表新术语, URLs, email地址, 文件名或者文件扩展名;</li>
	<li>Constant width:Used for program listings, as well as within paragraphs to refer to program elements such as variable or function names, databases, data types, environment variables, statements, and keywords.</li>
	<li>Constant width bold: Shows commands or other text that should be typed literally by the user.</li>
	<li>Constant width italic: Shows text that should be replaced with user-supplied values or by values determined by context.</li>
</ul>
后面三个和两种tip的形式都无法在本译文中体现, 所以就不管了哈...

<strong>Source links:</strong>
<ul>
	<li><a href="http://chimera.labs.oreilly.com/books/1230000000545/pr01.html" target="_blank">Preface Part1</a></li>
	<li><a href="http://chimera.labs.oreilly.com/books/1230000000545/pr02.html" target="_blank">Preface Part2</a></li>
</ul>
