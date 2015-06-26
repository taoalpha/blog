---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day41-nginx中的重定向
tags: [Nginx,rewrite,homepage,Patch]
---

好久没折腾nginx了... 因为准备作品集, 准备把所有链接都整理一下, 首先就是需要把大域名重定向到同一个page, 另外也计划把首页彻底重置为作品集的首页~ 于是呼, 就需要和nginx的重定向好好较量一番了~

通过万能的google我非常粗略的了解了一下rewrite, 然后首先将www的域名冲向到没有www的域名之上, 即将www的二级域名全部消除掉, 这一步很简单:

{% highlight python %}

server {
    listen 80;
    server_name www.zzgary.info;
    return 301 $scheme://zzgary.info/$request_uri;
}

{% endhighlight %}

通过$request_uri 就可以将www开头的后续部分全部承接到母域名之后.

接着需要将zzgary.com的homepage重定向到djangoblog的portfolio之中, 这一步比较恶心, 因为原本构思的原因, 我是把djangoblog建在了zzgary的二级路径下, 而如果把zzgary直接全部替换为djangoblog的话, 那么同在二级目录下的那些小项目就会失效, 或者需要用django来重新定向一下, 就很麻烦了~ 于是就需要找一种方法能够只重定向首页~

首先是通过regex来之名是首页: <b>^/&</b>, 接着做相应的rewrite规则:

{% highlight python %}

rewrite ^/$ /djangoblog/portfolio_n break;

{% endhighlight %}

把这一行加在nginx之中, 就可以对相应的首页进行跳转了~

以下为查询资源, 请参考~
<ul>RESOURCE:
    <li><a href="http://stackoverflow.com/questions/15489919/nginx-static-index-redirect">首页跳转的方式(赞!)</a></li>
    <li><a href="http://www.cyberciti.biz/faq/unix-linux-bsd-nginx-rewrite-old-domain-to-new-domain/">常规的301重定向</a></li>
    <li><a href="http://wiki.nginx.org/HttpRewriteModule">Nginx的官方rewrite模块介绍</a></li>
</ul>

