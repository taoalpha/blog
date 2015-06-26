---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-58-Github pages转移jekyll blog到二级路径
tags: [github pages,Patch,Jekyll]
---

昨天刚把几个不涉及后端数据库和php的项目都开了project pages, 但猛然发现github pages首页还是blog, 没有向各个project引导的链接. 于是就想把jekyll blog也转移到二级blog路径下, 然后把之前个人站中的<a href="http://fun.zzgary.info">fun stuff首页</a>挪移过来. 下面简述一下操作过程和注意事项~


<ul>
	<li>首先在github pages根目录下新建目录: blog;</li>
  
<li>然后把除了_layouts, _includes,_config.yml之外的原jekyll文件全部转移至blog文件夹中;</li>
  <li>最后, 修改_layouts中的模板页面资源的链接位置(如果你是把header放入到了_includes, 就修改这里面的), 最好改为绝对路径"/blog/css/xx.css", 这样可以保证在blog正文页也不会出错;</li>
</ul>

如此之后, 就可以把新页面的index, js,css等放入到根目录中, push更新后就可以看到最新的首页和blog路径了~

以上的重点在于_config.yml和_layouts,_inlcudes等jekyll的环境组件必须放置在根目录下, 不然jekyll就无法编译了~

最后, 欢迎来访我的新首页:

<a href="http://zzgary.github.io">zzgary.github.io</a>
