---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day25-WP下禁止部分资源请求来提升加载速度
tags: [google字体请求,wordpress,加速,Patch]
---

以前一致没觉得blog很慢, 最近在家里进blog调试,发现有时候会出现文本不显示的情况...一致在发themes.googleusercontent.com的请求....于是在代码层查了一下,发现是google-fonts的请求,可能是因为在国内,所以不开goagent的时候请求经常挂掉...而对于这种字体性的请求,禁掉也是不会影响到内容展示的~

但不知道这个请求是在哪个文件中加入的...

于是先在主题文件夹下,cat | grep了一下,找到文件所在:

{% highlight python %}

cd /xxx/wp-content/themes/yourtheme/
cat * | grep "fonts.googleapis.com"
# 找到包含的文件是functions.php
vim functions.php
# 注释掉相应的行即可;
 // wp_enqueue_style( 'corpo-fonts', add_query_arg($query_args, "$protocol://fonts.googleapis.com/css" ),array(), null );
#本例中就是上述行;

{% endhighlight %}


通过注释掉这个最耗加载时间的请求,会发现你的blog加载速度瞬间提升啊~

PS: 不得不说,利用chrome或者firefox这种可以调试的浏览器来寻找相应的加载问题绝对是个非常快捷的路径~
