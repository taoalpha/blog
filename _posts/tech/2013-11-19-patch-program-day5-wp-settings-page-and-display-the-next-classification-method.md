---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch计划-Day5-WP下设置页面及显示分类的方法
tags: [页面,wp,分类,模板,Patch]
---

因为是从之前SAE上迁移过来的, 之前曾经针对HCIBib翻译项目做过单独一个页面, 如今迁移之后主题的设置就都没有了, 所以需要重新开始...结果发现自己果断不会了....只能再次拿起google...
<ol>主要分两块吧
	<li>首先是首页不显示特定分类的内容如何做到? 这一块最简单, 其实只需要在page.php中添加一行代码就可以:

{% highlight php %}

<?php if ( have_posts() ) : query_posts($query_string .'&cat=-13,-26'); while ( have_posts() ) : the_post(); ?>

{% endhighlight %}

有一个插件也可以做到这一点:<a href="http://wordpress.org/plugins/advanced-category-excluder/" target="_blank">Advanced Category Excluder</a>
</li>
	<li>那么,如何在某个页面显示某些分类呢? 其实也很简单,也只需要加一行代码:(同样是在page.php或者其他的页面级模板中)

{% highlight php %}

<?php query_posts('showposts=5&cat=2'); ?> /* showposts顾名思义就是一页的posts数量,cat就是代表的categoryID,在dashboard里面的categories中可以看到(从url看)*/
<?php if (have_posts()) : ?> /*本行属于本来就有的 */

{% endhighlight %}

然后你只需要将这个新的页面模板另存个名字保存即可~~文件名随意, 但是模板名称需要定义在文件内的头部:

{% highlight php %}

<?php
/* Template Name: HCIBib*/
get_header();
?>

{% endhighlight %}

然后再新建页面,就会发现template里面出现一个HCIBib的选项,就可以选用了~
到此, 你的页面会出现你所选择的category的文章, 但是你会发现还存在一个问题,就是翻页功能要么没有,要么就是有但是不能用...
那么这种情况下, 你需要获取一下这个分类页的page信息, 通过将之前的一行代码修改如下:

{% highlight php %}

<?php
$limit = get_option('posts_per_page');
$paged = (get_query_var('paged')) ? get_query_var('paged') : 1;
query_posts('cat=2&showposts=' . $limit=5 . '&paged=' . $paged);
$wp_query->is_archive = true; $wp_query->is_home = false;
?>

{% endhighlight %}

如此就可以了~如果你此刻使用的是首页的模板,正常应该在底部会包含:

{% highlight php %}

<?php get_template_part('pagination'); ?>

{% endhighlight %}

如此,就可以调用主题自带的翻页功能了~
</li>
</ol>
以上~祝晚安~
