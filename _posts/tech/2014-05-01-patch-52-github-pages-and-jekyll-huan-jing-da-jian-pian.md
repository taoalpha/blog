---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-52-github pages and jekyll(环境搭建篇)
tags: [github pages,Patch,Jekyll]
---

Github Pages最开始是为了让developer们自定义项目主页而出现的, 后来因为其灵活的应用而逐渐演化为很多developer的blog所在, 而且因为Github本身的稳定性, 颇受赞誉. 对于很多想要低成本的建立自己的blog的童鞋, Github pages绝对是个不错的选择.

本次主要借着自己想要体验一把Github pages和jekyll的blog流所以在windows上搭建了一下jekyll的环境~ 就介绍下整个过程~~

其实很简单, 主要可以分为两部分:

<ul>
    <li>
        <strong>Git环境配置</strong>
        <p>首先是需要一个能够支持git的环境, 在windows下, 可以直接下载相应的git版本就可以了. <a href="http://git-scm.com/downloads" target="_blank">地址在这里.</a> <br />需要说明的是安装完git后, 需要设置一下, 从而方便之后commit等, 方法也很简单:

{% highlight python %}

$ git config --global user.name "你的名字"
$ git config --global user.email "your_email@youremail.com"
// 设置相应的账户属性, 方便commit
$ ssh-keygen -t rsa -C "邮件地址@youremail.com"
// 生成sshkey, 如此才能连上github.
// 生成后, 需要将sshkey添加到你自己github帐号的account setting中去, 只需要把生成的id_rsa.pub的内容复制进去就可以了(如果你没有修改保存地址的话~)

// 这些都在git bash中操作即可;

{% endhighlight %}

        </p>
    </li>
    <li>
        <strong>Jekyll环境配置</strong>
        <p>配置好git后, 就可以通过安装ruby来配置Jekyll了, 首先是去安装ruby, 下载对应的rubyinstaller就可以了, 一路安装完成后(记得选择把ruby路径自动添加到path中), 就可以直接安装jekyll了:

{% highlight python %}

$ gem install jekyll
// 完事

{% endhighlight %}

接下来就是通过jekyll来写blog啦.

首先是建立一个repository, 可以命名为: yourname.zzgary.com
然后clone到本地环境下, 然后用jekyll初始化:

{% highlight python %}

$ jekyll new xxx
// 然后把所有子文件都复制到父文件夹中就行了.
// 当然你可以直接clone线程的blog代码, 然后一边借鉴一边学习一边修改~

{% endhighlight %}

在所有都准备就绪后, 就可以直接用

{% highlight python %}

$ jekyll server

{% endhighlight %}

来运行server, 在本地环境中查看效果了: 地址是: http://localhost:4000
        </p>
    </li>
</ul>

嗯, 环境很好配置. 等我好好研究下jekyll后再补上jekyll的心得哈~

<strong>links:</strong>
<a href="http://beiyuu.com/github-pages/" title="一篇非常详细的教程!赞作者" target="_blank">一篇非常详细的教程!赞作者</a>
