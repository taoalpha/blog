---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day42-FE工具整理
tags: [web developer,网页开发,FE,Patch]
---

作为一个一心想要贯通产品线的PM, FE一直是核心的一部分. 这一次看tuts的视频:<a href="https://tutsplus.com/course/tools-of-the-modern-web-developer/" target="_blank">TutsPlus-Tools of the Modern Web Developer</a> 确实是收获颇丰啊!

这里特别做一整理, 分享给大家:

<ul>
    <li><strong>基础技能</strong>
        <ul>
            <li>HTML</li>
            <li>CSS</li>
            <li>javascript</li>
        </ul>
        <p>不用说, 这三个是FE最基础的部分, 对于web developer而言, 更是吃饭的东西.</p>
    </li>
    <li><strong>Boilerplate(样板/模版)</strong>
        <ul>
            <li><a href="http://html5boilerplate.com/">HTML5 Boilerplate</a></li>
            <li><a href="http://getbootstrap.com/">Bootstrap</a></li>
            <li><a href="http://foundation.zurb.com/">Foundation</a></li>
            <li><a href="http://yeoman.io/">Yeoman</a></li>
            <li><a href="http://getskeleton.com/">Skeleton</a></li>
            <p>上述都是非常完善的框架级工具, 在各个方面都已经基本完善, 相互之间也各有优劣. 但是总的来说无论哪一个都够用了, 用这些框架来做网页开发, 有个巨大的好处就是可以用它们本身已经完善的各种属性设定, 各种js函数等等, 一旦掌握绝对可以事半功倍~ <a href="http://responsive.vermilion.com/compare.php" target="_blank">关于这几个的对比, 有兴趣的可以从此了解一下</a></p>
        </ul>
    </li>
    <li><strong>HTML Abstraction</strong>
        <ul>
            <li><a href="http://emmet.io/">Emmet</a></li>
            <li><a href="https://daringfireball.net/projects/markdown/">Markdown</a></li>
            <li><a href="http://jade-lang.com/">Jade</a></li>
            <li><a href="http://haml.info/">Haml</a></li>
            <p>这几个算是比较流行的html的简写或者转换工具了~ Emmet是我个人非常常用的一个工具, 目前其插件的支持基本上已经能覆盖了主流的编辑器~ markdown作为老牌的一个工具, 和Emmet以及其他两个都有着不小的差别, 毕竟这本身是一个比较完善的语法结构, 而不像Emmet是一个基于html的缩写工具, markdown需要专用的工具来转换到html~ 但是写起来确实挺爽的, 有个在线的自动转换编辑器不错: <a href="http://mahua.jser.me/" target="_blank">mahua</a>, mac的童鞋可以用mou试试~ 非常帮的一个工具, 可惜没有windows版本的.</p>
        </ul>
    </li>
    <li><strong>CSS Abstraction</strong>
        <ul>
            <li><a href="http://emmet.io/">Emmet-CSS</a></li>
            <li><a href="http://sass-lang.com/">Sass</a></li>
            <li><a href="http://lesscss.org/">Less</a></li>
            <li><a href="http://visionmedia.github.io/nib/">Stylus-nib</a></li>
            <p>这几个和html部分的几个工具功能上比较一直, 只是针对目标换成了css, 是专门用来简化写css而设计的~ 其中通常写简短代码的时候一般用emmet, 很方便, 很快捷, 但是如果是写项目代码, 几百行上千行的时候就会用Sass或者Less了, 置于最后的Stylus-nib也是首次听说, 不过功能上到时差不多~ sass的话, 推荐可以使用<a href="http://compass-style.org/" target="_blank">compass</a>, 比较成熟, 而且本身的mixins库很全了~</p>
        </ul>
    </li>
        <li><strong>JS Abstraction</strong>
        <ul>
            <li><a href="http://coffeescript.org/">CoffeeScript</a></li>
            p{关于js的缩写比较少, coffeescript是最流行的一个, 也许是因为coffeescript真的很完美, 所以也没有什么竞争者出现了(^_^), 目前还没有试用过, 因为主要是用jquery, 所以这里正好分享一篇如何<a href="http://www.coffeescriptlove.com/2012/08/coffeescript-and-jquery.html" target="_blank">结合coffeescript和jquery的教程</a>给有兴趣的童鞋~}
        </ul>
    </li>
    <li><strong>JS Templates</strong>
        <ul>
            <li><a href="http://mustache.github.io/">Mustache.js</a></li>
            <li><a href="http://handlebarsjs.com/">Handlebars.js</a></li>
            <p>上述这两个都是通过js制作html模版的好工具, 对于那种list列表页的生成有着极大的好处~ 很简单, 很方便. 有兴趣的可以前往官网了解一下~</p>
        </ul>
    </li>
    <li><strong>Web Tools</strong>
        <ul>
            <li><a href="https://chrome.google.com/webstore/detail/devtools-autosave/mlejngncgiocofkcbnnpaieapabmanfl?hl=en">Autosave</a></li>
            <li>Chrome/Firefox</li>
            <p>目前的主流浏览器本身也是极好的debug工具~ 通常大家使用的是chrome和firefox两个, 都非常完善~ 个人比较喜欢chrome, 但是firefox的responsive模式对于测试多个分辨率的这种要方便很多~ 而3D view的模式更是对于z-index有着极大的好处~有时候更容易帮助找到问题~</p>
            <p>值得说的还是Autosave这个工具, 作为一个插件, 这里只列出了chrome的地址, firefox应该也有, 不是很确认~ 这个东西最大的好处是可以自动记录你在chrome下的调试信息, 做出的css和js的修改会自动回馈到本地文件中, 对于测试极为方便, 不过这个工具需要node.js的支持, npm install autosave /g 后就可以在cmd下输入autosave就可以了~</p>
        </ul>
    </li>
</ul>
其实本视频最后的mobile部分更吸引我, 不过可惜的是chrome和anrdoid的联测着实麻烦, 还需要Android SDK, 远不如mac下直接一个xcode完事~ Mac现在对我是越来越有吸引力了... 穷啊...

