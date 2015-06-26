---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-62-隐藏blog顶部的admin菜单
tags: [admin,php,coding,Patch]
---

这两天看到几个很好的blog, 首先是<a href="http://hzlzh.io" title="自力博客" target="_blank">自力博客--hzlzh</a>~ 头像很赞! 分享了很多的干货~ 更是Alfred的作者大大! 最近新作<a href="http://hzlzh.io/timeline-about-yunshouyi/" title="云受益" target="_blank">云受益-app</a>也已经上线啦~ 恭喜! 也是从自力博主这里看到了<a href="http://immmmm.com/" title="木木" target="_blank">木木童鞋的blog</a>~ 也是超多的干货啊!!!

首先就是从木木博主这里学习如何隐藏blog顶部的admin菜单, 木木博主的源码如下:


{% highlight python %}

add_action('get_header', 'remove_admin_bar_style');
add_action( 'wp_head', 'diy_admin_bar_style' );
function remove_admin_bar_style() {
    remove_action('wp_head', 'wp_admin_bar_header');
    remove_action('wp_head', '_admin_bar_bump_cb');
}
function diy_admin_bar_style() {
  echo '
  <style type="text/css">
    #wpadminbar{position:absolute;background:transparent;}
    #wp-toolbar ul>li{display:none;}
    #wp-toolbar li#wp-admin-bar-wp-logo,#wp-toolbar:hover ul>li{display:block;}
    #wpadminbar .ab-top-secondary{float:left}
  </style>';
}

{% endhighlight %}


因为个人需要定制化了一下, 主要是修改了插入的新css部分:

{% highlight python %}

function diy_admin_bar_style() {
  echo '
  <style type="text/css">
    #wpadminbar{position:fixed;background:transparent;}
	// 透明化背景色; fixed主要是为了随时进入管理后台;
    #wp-toolbar ul>li{display:none;}
	// 隐藏菜单项;
    #wp-toolbar li#wp-admin-bar-wp-logo{display:block;}
	//只保留显示W标志;
    #wpadminbar:hover{background:#222;}
	// hover后恢复背景色;
	#wpadminbar .ab-top-secondary{float:left}
	// 移动等处和账户头像到左侧
    #wpadminbar:hover div,#wpadminbar:hover ul>li{display:block;}
	// 对整个顶部框做hover效果, 增大hover面积, 提升hover易操作性;
  </style>';
}

{% endhighlight %}


近期也准备基于现在的corpo主题定制化一个属于自己的主题呢~~
