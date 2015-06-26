---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day9-关于Nginx和Php-fpm以及mediawiki的迁移
tags: [php-fpm,mediawiki,Patch,Nginx]
---

从上次迁移callmet到二级域名后,逐步的开始了各分站到二级域名的迁移,昨天也直接将phabricator部署到了二级域名之下, 本来一切正常,但今天突发问题, 先是mysql莫名的挂掉...而且无法重启..试了很多方法都不行...<strong style="color: red;">(待解决)</strong>,最后一怒之下就重启了server...果然ok了...不过发现blog不能访问了...502的经典错误..在通过google后找到原因如下:
<ul>
	<li>错误提示为: "connect() to unix:/var/run/php5-fpm.sock failed (2: No such file or directory)";</li>
	<li>==>解决方案: 我的php5-fpm的www.conf文件中listen的端口在昨天因为phabricator设置为了9000,于是php5-fpm.sock就无法解析了...修改回来后就正常了~</li>
</ul>
解决了这个问题后, 我就着手把为hci建立的mediawiki迁移到二级域名<a href="http://wiki.zzgary.info/" target="_blank">wiki.zzgary.info</a>,整个过程可以分为以下几步:

<ol>
	<li>先是在DNS下配了新的A记录:wiki,如此让wiki的二级域名得以解析.</li>


	<li>接着把mediawiki文件夹从原始的根目录下拷出, 此处主要目的是为了让网站结构更好看...不迁移也是可以的~只需要在nginx下设置对应的server block的root目录就可以了;</li>
 	<li> 再接着就是配置nginx下的server block;这里注意root路径以及server_name写为wiki.yourdomain.xxx即可,其他的照搬原始的block即可;</li>
	<li>最重要的一步就是修改localsettings.php文件了~将里面的几处配置略作修改:
  
{% highlight php %}

$wgScriptPath = ""; //取消即可,以前是二级文件夹名称,本次为二级域名的root,所以就没有了~
$wgScriptExtension = ".php";//这里不用改
## The protocol and server name to use in fully-qualified URLs
$wgServer = "http://wiki.zzgary.info";//这里需要改为你使用的二级域名地址;

{% endhighlight %}
</li>
	<li>最后一步就是讲原始的二级文件夹路径全部重定向至新的二级域名:
    
{% highlight php %}

location ~ ^/mediawiki/(.*)$ {
	rewrite ^/mediawiki/(.*)$ http://wiki.zzgary.info/$1 redirect;
}

{% endhighlight %}

  </li>
  如此即可~重启相关的服务就可以看到效果了~
</ol>



