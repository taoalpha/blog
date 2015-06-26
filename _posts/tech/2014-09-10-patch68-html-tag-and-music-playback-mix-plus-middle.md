---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch68-大杂烩之html-tag处理以及音乐播放加纵向居中处理
tags: [CSS3,Patch,coding,php,js]
---

好久没写Patch系列了, 倒不是没货写.. 而是积累的东西都凑不到一块去.. 今天正好乘着兴致还在, 就把做WordCard和RNhelper两个小项目中的三个大问题说下吧...

恩..题目很长.. 主要是防止下次搜索的时候比较容易搜出来...

<ul>
	<li>HTML-Tag的处理
  其实在之前写<a href="http://callmet.zzgary.info/2014/09/10/recommended-produced-by-the-combination-of-readability-and-markdown-online-reading-notes/" title="结合了readability和markdown写的一个小工具型网站" target="_blank">RNhelper过程的文章</a>中介绍了下思路, 不过实现方式还没怎么认真研究, 不过对于所有不想重新造轮子的朋友, 请直接使用readability的算法即可. 相应的有很多版本, 适应了不同的平台和语法~ 包含php的,python的,nodejs的等等~ 请github之~
</li>
	<li>点击播放音乐的方法
我们在网上查词典的时候应该经常能看到那个发音的按钮吧~ 点击或者hover后会播放对应的单词读音~ 我在wordcard上也加上这一功能~ 本来是觉得需要对现有的1.5w词重新抓取下对应的读音链接才行, 没想到youdao非常厚道的提供了一个极为完美的音频地址格式~<code>dict.youdao.com/dictvoice?audio=单词&type=2</code> 其中type是英音和美音~ 于是我就直接用了~ 哈, 不在摧残我的vps了... 那么怎么实现点击播放呢?


{% highlight javascript %}

// 主要借用audio这个标签以及其autoplay的属性即可.
$("#mp3trash").html("<audio src='"+url+"' autoplay=autoplay></audio>")})
// 我们现在html中创建一个隐藏的id为mp3trash的div~ 内部为空即可.
// 然后每次要播放前, 把链接拼好, 绑在audio的src上, 然后加上autoplay的属性, 插入进去即可~
// 因为插入后相当于初次加载, 会自动播放的~ 而每次新进入的页面则没有audio标签, 则不会播放~

{% endhighlight %}

</li>
	<li>元素纵向居中的方式
因为wordcard的界面非常简单, 就是个单纯的卡片, 然后卡片翻转, 正反面分别是英文单词+英文解释和汉语意思~ 而为了实现在各个平台下的纵向居中, 又不想写js判断屏幕长宽, 就在css-tricks里查找到了<a href="http://css-tricks.com/centering-in-the-unknown/" title="一个很有创意的居中方式" target="_blank">一个很有创意的css实现方式,</a> 非常有创意!
<img src="http://cdn.css-tricks.com/wp-content/uploads/2011/10/ghost.png" width="570" height="490" alt="非常创意的居中方式" class />
思路就是通过伪类before创建一个虚假的元素然后设置其和需要居中的元素都为vertical-align:middle; 就可以轻松的实现垂直居中了~

{% highlight javascript %}

/* This parent can be any width and height */
.block {
  text-align: center;
}
 
/* The ghost, nudged to maintain perfect centering */
.block:before {
  content: '';
  display: inline-block;
  height: 100%;
  vertical-align: middle;
  margin-right: -0.25em; /* Adjusts for spacing */
}

/* The element to be centered, can
   also be of any width and height */ 
.centered {
  display: inline-block;
  vertical-align: middle;
  width: 300px;
}

{% endhighlight %}

当然只能说这是一个非常有创意的方法, 但不是最简单, 最简单的其实是利用display:table-cell;当作表格处理了~哈, 不过, 谁让咱是不折腾会死星人呢~

附赠一个<a href="http://css-tricks.com/centering-css-complete-guide/" title="各种居中方式大全" target="_blank">css-tricks关于居中方式的总结文</a>
</li>
