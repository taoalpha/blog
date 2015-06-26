---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch计划-Day2-WP中excerpt(摘要)的设置和Python的pyyaml
tags: [python,excerpt,Patch,补缝,wp,ConfigParser]
---

<h4>今天主要遇到的问题是wordpress的excerpt问题以及python中pyyaml的问题~</h4>
<ol>
	<li>wp中的excerpt,也就是摘要部分, 一直很不尽如人意, 首先是沿用英文的默认设置, 字数上就不能完全满足中文的需要, 其次是不支持html标签, 所以摘要都是一大段堆在一起的文字..很是费劲..如果读者连摘要都看的不舒服..又如何产生进一步了解的欲望呢...
于是,自定义excerpt以及很多wp针对excerpt的插件都出现了, 用了一个easy custom excerpt,觉得并不能满足我的需要, 于是就寻找一个比较好的自定义方式,找到了如下的方法:(来自<a title="Excerpt自定义" href="http://www.5ihs.cn/show-22-6925-1.html" target="_blank">桃城科技</a>)

{% highlight php %}

remove_filter('get_the_excerpt', 'wp_trim_excerpt');
add_filter('get_the_excerpt', 'improved_trim_excerpt');
function improved_trim_excerpt($text) {
        global $post;
        if ( '' == $text ) {
                $text = get_the_content('');
                $text = apply_filters('the_content', $text);
                $text = str_replace(']]>', ']]&gt;', $text);
                $text = preg_replace('@<script[^>]*?>.*?</script>@si', '', $text);
                $text = strip_tags($text, '<p>');
                $excerpt_length = 80;
                $words = explode(' ', $text, $excerpt_length + 1);
                if (count($words)> $excerpt_length) {
                        array_pop($words);
                        array_push($words, '[...]');
                        $text = implode(' ', $words);
                }
        }
        return $text;
}

{% endhighlight %}

把这段代码加入你的主题对应的function.php中的excerpt部分就可以了~我稍微定制了一下read more的部分, 修改为了:

{% highlight php %}
array_push($words, '... <a            
     class="more" href="' . get_permalink($post->ID) . '">' .
     __('Continue reading &rarr;', 'corpo') . '</a>');
{% endhighlight %}

同时在包含的html标签中加入了img,code,pre等标签用来显示图片和代码:

{% highlight php %}

$text = strip_tags($text,                     
     '<p><img><blockquote><code><pre>');
 $excerpt_length = 20;
{% endhighlight %}

其中pre标签主要是因为使用了一个code highlight的插件~
</li>
<li>
本来想用ConfigParser,后来发现pyyaml更加简单实用, 整个过程中没啥大问题~遇到一个Mapping Values are not allowed here!的error,简单搜索了一下才知道, yaml的语法中每一个"="后面都需要加上一个空格;
</li>
</ol>
