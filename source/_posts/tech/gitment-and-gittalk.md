date: 2020-06-30 14:30:00
title: Gitment and Gitalk
category: tech
description: 多说停止维护了, 作为静态网站来说, 用什么取代多说呢 ?
tags: [javascript,duoshuo,gitment,gitalk,comment]
language: zh
author: taoalpha
---

wow 又是两年没写博客了... :( 最近被家属激励, 准备再次复活这个博客! 希望这次能坚持!

也是因为好久没用了, 发现了博客上好多部件都没法用了... 花了点时间更新了一下, 把失效的部分都替换了一下, 其中就有评论组件, 之前一直用的多说, 不过很可惜多说差不多从 17 年就关闭了: [知乎: 如何评价「多说」即将关闭？有什么替代方案？](https://www.zhihu.com/question/57426274)

既然是博客, 没有评论感觉还是少了点什么的, 本来是准备直接切换 disqus, 因为一开始支持多说的时候就同时支持了 disqus, 只需要替换就好了, 不过简单搜索了一下, 看到了 gitment 和 gitalk 这两个选择, 很有意思的利用 git issues 的解决思路, 于是准备试试.

## Gitment

[Gitment Repo](https://github.com/imsun/gitment) 似乎是一个华人程序员写的, 哦, 好像就是上面的知乎最高答的作者, 很不错的一个实现, 使用起来很简单, 花了我不到十分钟就集成好了, 在此感谢一下作者!

## Gitalk

[Gitalk Repo](https://github.com/gitalk/gitalk) 和 gitment 很像, 起始于 2017 年 6  
月, 比 Gitment 晚了三个多月开始的吧. 不过看 commits 的话感觉似乎比 Gitment 还要更活跃一点.

两个项目的 API 基本一模一样, 差不多可以无缝替换, 需要稍微调整一下初始化参数, 也是因此, 我干脆就把两个的集成都在我自用的 hexo 主题里都加上了, 可以根据自己需求来选择 :)

试用了一下, 最大的问题可能就是需要 issue repo 的所有者来初始化留言才行, 考虑到我准备 archive 所有旧文, 我就不打算再手动慢慢初始化每个文章啦, 新文章的话, 我都会每个初始化的!

如果想要看看具体的 code, 可以看看这个 [commit](https://github.com/taoalpha/hexo-theme-tao/commit/5fd24b7bf011516cfa39c72dbb27cddc845d65b2) :) 