---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day8-Nginx下Subdomain配置以及Phabricator搭建
tags: [Phabricator,二级域名,子目录,Patch,Nginx,Subdomain]
---

一直以来都用的是subdirectories的方式,本来还ok,后来觉得还是二级域名比较酷炫一些~所以就折腾了一下, 本来觉得很容易的事情,结果弄的好麻烦才搞定...算起来竟然足足搞了一个多星期...
为了以后不要在走那么多弯路...今天特意记录在此...以后遇到同样的问题就有据可查了~

分两部分说吧, 首先是subdomain的问题:
<ol>
<ol>
	<li>多个server block监听80端口造成nginx无法启动...
==&gt;解决方案是调整server_names_hash_bucket_size的大小, 因为根据nginx的log来看,是提示此处限制太小...这一块也给了我一个很大的教训...一定要根据错误日志来追查问题!!!效率更高,思路也才对...</li>
	<li>切换某个subdirectories到subdomain需要用到rewrite:
==&gt;以本次调整此blog的域名时用到的就是:

{% highlight python %}
rewrite /callmet/(.*) http://callmet.zzgary.info/$1 permanent;
{% endhighlight %}

如此就把之前的/callmet子目录跳转到callmet.zzgary.info的二级域名下了~</li>
	<li>对于wordpress,切换后链接如何处理?
==&gt;针对重写的server,基本按照第一个server block写就可以了, 写完后基本可以保证首页是正常的了~但文章页的链接会错误,因为这个时候所有posts的链接都是原来的/callme/*,而且这个链接是存储在数据库中的,所以需要将这些都重写一下~有多种方法:
<ul>
	<li>简单的是直接去mysql下的对应数据库里把wp_posts下的所有guid中的旧链接都替换为新连接~</li>
	<li>另一种方法就是通过phpmyadmin去替换,相当于在可视化界面操作,会容易很多,当然前提是你装了phpmyadmin...</li>
	<li>还有一种方法则是利用searchreplacedb这个工具来实现,很简单,很方便~<a href="http://interconnectit.com/products/search-and-replace-for-wordpress-databases/" target="_blank">地址在此</a>(BTW:页面做的很不错~)</li>
</ul>
</li>
	<li>经过上述的修改,基本上文章页的链接也都ok了~这个时候会发现登陆页出问题了...输入但不跳转...无法登陆..
==&gt;细看一下url就会发现登陆的url还是旧的url,所以还需要在数据库里替换一下...这个简单,只有两处修改,同样是上述的三种方法, 去替换一下wp_options的表中siteurl和blogurl两个地址,都是从旧链接改为新连接即可~</li>
</ol>
</ol>
经过上面的所有过程,就可以看到现在这个状态了~已经完全都转为了新的二级域名方式~

接下来主要说下phabricator的配置问题...其实也不怎么说了, 主要参考了网上一个很棒的教程级的文章看的, 中间的一些问题也基本都是个人操作的问题了...<a href="http://popozhu.github.io/" target="_blank">请猛击这里</a>

注意事项吧,因为需要监听端口9000(这里应该也可以修改吧...没试)才可以正常的访问,所以可能需要修改破坏p-fpm的配置,让它listen这个端口~

由此造成的问题就是....我的django挂掉了....于是...明天再搞吧...

=================分界线================

本来想简单看下...没想到很快找到了问题...就是因为template等很多相关的脚本和进程都用的是绝对路径,所以这一次动二级域名,改了路径后很多地方都不能用了~已经正常了~
