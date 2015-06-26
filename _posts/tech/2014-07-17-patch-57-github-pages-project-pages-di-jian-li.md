---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-57-Github pages--Project pages的建立
tags: [github pages,project pages,Patch]
---

最近因为申请原因认识不少HCI的朋友, 在准备自己作品集以及帮助朋友的同时, 顺带学习了一下github pages中的project pages相关的问题~ 特发文分享一下.

首先, 什么是project pages呢? 对于github而言, 你有很多的repo, 你希望做些页面来分别介绍这些project, 而且还希望放在github pages上. 那么这种情况下, 无需你直接在你的github pages的repo中去捣鼓折腾, 你可以用很方便的方法来生成project pages, 这些pages会自动出现在相应的projectname路径下, 比如: 

你的project是: hellokitty

你的github域名是: kitty.github.io

那么, 你的hellokitty这个project pages生成后就会出现在 kitty.github.io/hellokitty

瞬间有兴趣了有木有~~

闲话少说, github 提供了主要2两种方式来创建project pages, 分别是自动创建和手动创建, 这里主要介绍手动方式:

<ul>
	<li>自动创建
    <p>github的每个repo的settings中都有一个自动创建project pages的选项, 全称为: Automatic page generator, 点击后根据提示走就行了; 如果你创建过了, 会提示你overwrite的~</p>
	</li>
	<li>手动创建
  <p>其实说白了project pags就是一个特殊的branch, 所以一旦我们架设好github pages后, 只要在对应project的repo中, 建立一个新的分支(branch), 命名为gh-pages, 然后在这个分支下建立对应的html相关文件, 然后push上去就行了~ 嘿嘿, 简单吧~</p>
		</li>
</ul>

重头戏:


如果你非常顺利的完成了上述过程, 那么后面的东东就和你没啥大关系了... 但是... 如果你不幸的在push的时候遇到了error提示.. 那么请无比看下去:


{% highlight python %}

// ERROR INFORMATION

! [rejected]        gh-pages -> gh-pages (non-fast-forward)
error: failed to push some refs to 'your repo'
To prevent you from losing history, non-fast-forward updates were rejected
Merge the remote changes (e.g. 'git pull') before pushing again.  See the
'Note about fast-forwards' section of 'git push --help' for details.


{% endhighlight %}


so, 如何解决?

简单...粗暴...的方法就是:

force push...

 
{% highlight python %}

git push -f origin gh-pages


{% endhighlight %}


那么不简单粗暴的方法呢?.... 都没生效...:(


<strong>Related Links:</strong>

<ul>
<li><a href="https://github.com/regebro/die-git-die/blob/master/README.md"> Force 解决问题的来源</a></li>
<li><a href="https://help.github.com/articles/creating-project-pages-manually"> Project pages 手动官网教程</a></li>
<li><a href="https://help.github.com/articles/creating-pages-with-the-automatic-generator"> Project pages 自动官网教程</a></li>
  
</ul>
