---
layout: post
title: Jekyll 简介
category: tech 
description: 正式开始使用Jekyll, 记录下使用过程中的心得
tags: [jekyll,jekyll tags,tips]
author: taoalpha
---

## 环境部署

 Jekyll作为静态博客, 以简单易部署而出名, 尤其是随着github对于静态博客的支持, 更是发展势头极为良好, 很多人都从大而繁杂的wordpress转移到了小而轻巧的Jekyll, 也有很多人选择了另一款小而精的静态博客:[hexo](https://hexo.io/), 至于他们之间的好坏, 孰优孰劣, 可以参考[知乎原文:arBox、Jekyll、Octopress、ghost、marboo、Hexo、Medium、Logdown、prose.io，这些博客程序有什么特点？](http://www.zhihu.com/question/21981094).

 这里就简单介绍下github下如何部署Jekyll.

> - 首先, 你得有个github帐号...(废话)... 然后你需要新建一个yourname.github.com(或者io结尾也可以)的repo, 并且在设置中开启github pages;
> - 接下来就是组织Jekyll的文件结构了, 这部分推荐在本地环境中操作, 因为你可以在本地的jekyll环境下随时测试预览调整, 不用每次都上传到github上在线查看; 一般来说, 你不需要完全从头进行的, 完全可以在[jekyll的示例网站](https://github.com/jekyll/jekyll/wiki/Sites)中寻找自己喜欢的主题样式, 然后clone到本地后, 在其基础上修改完成, 比如我现在这个就是在我自己的设定基础上融合了[beiyuu](http://beiyuu.com)的一些结构和设置, 然后参照[简书](http://www.jianshu.com/)修改的;
> - Jekyll是基于Ruby的, 所以如果想要搭建本地环境, 请确保你已经安装了Ruby~ 有了Ruby后, 你就可以参照[官网的安装指南](http://jekyllrb.com/docs/installation/)一步步操作了;
> - 在本地测试通过后, 你只需要push到github中, github就会自动帮你编译, 你就可以通过你的github page网址进行访问了;

## 文件结构关系

 Jekyll的文档结构是非常简单的, Jekyll是基于Ruby的, 所以如果想要搭建本地环境, 请确保你已经安装了Ruby~ 有了Ruby后, 你就可以参照[官网的安装指南](http://jekyllrb.com/docs/installation/)一步步操作了;

    .
    ├── _config.yml
    ├── _drafts
    |   ├── begin-with-the-crazy-ideas.textile
    |   └── on-simplicity-in-technology.markdown
    ├── _includes
    |   ├── footer.html
    |   └── header.html
    ├── _layouts
    |   ├── default.html
    |   └── post.html
    ├── _posts
    |   ├── 2007-10-29-why-every-programmer-should-play-nethack.textile
    |   └── 2009-04-26-barcamp-boston-4-roundup.textile
    ├── _data
    |   └── members.yml
    ├── _site
    ├── .jekyll-metadata
    └── index.html   
    // from Jekyll documentation

> - 如上, 一个完整而又基础的jekyll文档结构基本就是这样了. 其中`_config.yml`是全局的配置文件, 你可以在这里配置你的固定链接, 插件, 高亮以及设定很多的默认值等等;
> - `_drafts和`_posts`文件夹都是博文所在地, 区别在于`_drafts`是存放草稿的地方, 除非在测试环境下加上`--watch`的参数是不会出现在blog中的;
> - `_layouts`以及`_includes`分别是模板以及复用代码块所在, 基本上重复性代码都可以视情况放在这两个当中, 整页性的复用(模板)就放在`_layouts`中, 块结构的复用则放在`_includes`中;
> - `_site`基本不用管, 因为它是jekyll编译后的产物, 也基本就是你所看到的网站的正常版本;
> - `_data`, 这个涉及比较高端的用法... 我目前都没有开始接触, 所以放在以后的系列中介绍吧;
> - index.html, 作为blog的首页;

需要注意的事情是:

> - 和正常的网站文件结构类似, jekyll对文件夹的解析也是类似的, 我们可以在根目录下随意的建立文件夹, 从而创造二级路径;
> - 如果你像我一样把blog整个放到二级路径下, 建立一个独立的首页的话, 请注意记得在`_config.yml`中配好你的post页面地址(如果你希望所有的post页面都在你的`yoursite/blog/your-post`的话), 且把`_posts`转移到blog文件夹中, 但是诸如`_layouts`等则不需要调整;


## Tags 以及 Categories

 作为blog, 即便是简单的静态博客, 如果没有category和tag系统的, 也绝对不能算是一个好的博客系统,jekyll当然是一个好的博客系统啦~

> - **Categories:** Jekyll的category关键字是内置的, 只需要在post的顶部定义号对应的category关键字, 多个的话用array的方式定义即可, 比如category: [cat1,cat2], 而在liquid语法中, 则完全可以通过 `site.categories.cat1` 来访问对应的分类;
> - **Tags:** 基本和categories一样, 关键字是tags, 同样可以支持多个tag, 一样使用`site.tags.tagname`来访问; 

## Liquid语法

 Liquid Template Language是一种非常常用的模板语言, 它的语法很有特点, 粗糙理解的话, 就是一种简单的替换语法, 识别特定的结构和模式, 做特定的行为.

 Liquid 来自于shopify, 其代码也是由[Shopify在github上维护](https://github.com/Shopify/liquid)的, 如果想要详细了解其中的语法和用法, 以及Liquid目前的广泛用途, 都可以前往[其github上的wiki](https://github.com/Shopify/liquid/wiki)查看.

 一些常用的语法:
{% highlight liquid %}
{% raw %}
if : {% if statement %} {% elsif %} {% endif %}
for : {% for statement %} {% endfor %}
unless : {% unless statement %} {% endunless %}
assign : {% assign statement %} (赋值)
capture : {% capture %} {% endcapture %} (捕获赋值)
case : {% case condition %} {% when 1 %} {% when 2 or 3 %} {% else %} {% endcase %}
comment : {% comment %} {% endcomment %}
raw : {% raw %} 以及 endraw
{% endraw %}
{% endhighlight %}

 常用的管道用法:

{% highlight liquid %}
{% raw %}
变量引用符号 : {{ variable_name }}
大|小|首字母大写 : {{ v_name | upcase | downcase | capitalize }}
排序|连接|切分|替换 : {{ v_name | sort | join:"join-symbol" | split: "split-symbol" | replace: "replace-char" }}
{% endraw %}
{% endhighlight %}


[TaoAlpha]:    http://zzgary.info "TaoAlpha"
