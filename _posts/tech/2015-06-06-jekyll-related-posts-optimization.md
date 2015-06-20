---
layout: post
title: 优化 Jekyll 的相关文章列表 
category: tech 
description: Jekyll 虽然有默认的 related_post , 但是其产出结果的相关性非常差, 所以这里介绍以下如何优化相关文章这个模块.
tags: [jekyll,ruby,related post] 
series: Jekyll Boost
author: taoalpha
---

## 缘起

相关文章这个模块一直算是博客的一个标配组件之一, jekyll默认也是有着`site.related_posts`这个函数的, 可以调用jekyll帮助你生成的相关博文列表. 不过其准确性和相关性都很让人不放心... 从其[源码](https://github.com/jekyll/jekyll/blob/master/lib/jekyll/related_posts.rb)来看, 在默认关闭`lsi`的情况下, related_post产出的其实就是简单的最近文章列表... 

这样当然不可以! 于是, 本文就是我在针对`related_post`这部分做了一些优化后的产物~ 请君品鉴 ^_^

## 无插件方法

首先当然是希望能在不使用插件的情况下实现, 于是就看到了[Jekyll Related Posts without Plugin - 羡辙杂俎](http://zhangwenli.com/blog/2014/07/15/jekyll-related-posts-without-plugin/) 这个大神级妹子的博文~ 很有启发性嘛 基本上我要做的她都做过啦...哈哈

不过我稍微简化了以下代码以及结构, 所以可能会更易懂一些喽~哈

{% highlight liquid %}
{% raw %}

{% comment %} 利用split 来形成一个空数组, 这里主要是我不知道liquid如何直接写array... {% endcomment %} 
{% assign postsAfterFilter = '-' | split: "-" %}
{% for post in site.related_posts %}
  {% assign commonTagCount = 0 %}
  {% if post.title != page.title and post.series != page.series %}
    {% for tag in post.tags %} 
      {% if page.tags contains tag %}

        {% comment %} 统计共同的tag的数目, 用来后面的筛选以及排序用 {% endcomment %} 
        {% assign commonTagCount = commonTagCount | plus: 1 %}
      {% endif %}
    {% endfor %}
    {% if commonTagCount > 0 %}

      {% comment %} 将符合条件的post放入一个新的数组之中 {% endcomment %} 
      {% assign postsAfterFilter = postsAfterFilter | push: post %}
    {% endif %}
  {% endif %}
{% endfor %}

{% comment %} 容错判断, 确保有相关文章的时候再展示相关文章 {% endcomment %} 
{% if postsAfterFilter.size > 0 %}
<div class="relatedposts">
  <h2>Related Posts:</h2>
  <ul class="article-list">
  {% for post in postsAfterFilter limit: 5 %}
    <li><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
  </ul>
</div>
{% endif %}
{% endraw %}
{% endhighlight %}

思路很简单, 确保其具有共同tag, 在无相关文章的情况下就不展示此模块了. 因为本身liquid的语法非常有限, 不借助插件的情况下, 想要实现更多功能的话, 就比较麻烦了. 如果有哪位XDJM有不借助插件的排序, 求务必告知我哦~

<blockquote class="special update" markdown="1">

### Update

哈哈, 和朋友@小田讨论了下, 终于想到一个不用插件实现排序的方法了~ 代码如下:

{% highlight liquid %}
{% raw %}
{% comment %} 一致到获取postsAfterFilter以及tagCountEachPost的部分都没有变化{% endcomment %}
{% comment %} 下面则使用了一个叠加for循环来逐次寻找最大的tagcount, 然后同步输出对应postsAfterFilter的值{% endcomment %}
{% if postsAfterFilter.size > 0 %}
<div class="relatedposts">
  <h2>Related Posts:</h2>
  <ul class="article-list">
{% assign j = tagCountEachPost | size | minus: 1 %}
{% assign maxIndex = 0 %}
{% assign getFirstNumber = true %}
{% assign selectedIndex = "-"|split: "-" %}
{% for p in (0..j) %}
  {% for i in (0..j) %}
    {% unless selectedIndex contains i %}
      {% if getFirstNumber %}
        {% assign firstNumber = tagCountEachPost[i] %}
        {% assign getFirstNumber = false %}
      {% endif %}
      {% if tagCountEachPost[i] >= firstNumber %}
        {% assign firstNumber = tagCountEachPost[i] %}
        {% assign maxIndex = i %}
      {% endif %}
    {% endunless %}
  {% endfor %}
  {% assign getFirstNumber = true %}
  {% assign selectedIndex = selectedIndex | push: maxIndex %}
  {% if selectedIndex.size < 6 %}
    <li><a href="{{ site.baseurl }}{{ postsAfterFilter[maxIndex]['url'] }}">{{ postsAfterFilter[maxIndex]['title'] }}</a></li>
  {% endif %}
{% endfor %}
</ul>
</div>
{% endif %}
{% endraw %}
{% endhighlight %}

思路也很简单, 就是利用for循环写出一个找最大元素的方法, 然后每次记录下最大元素的index, 就能同步输出对应的post了~ 需要注意的就是**为了保证index的一一对应, 需要单独保存每次找到的最大值的index, 然后在下一次遍历中跳过**

赞!
</blockquote>

## 有插件下增加排序功能

### liquid 部分

在上面的基础上(在update之前的基础上), 首先我们需要在liquid中添加几行代码:

{% highlight liquid %}
{% raw %}
{% comment %} 首先需要定义一个新的变量, 用来记录共同的tag数目 {% endcomment %} 
{% assign tagCountEachPost = '-' | split: "-" %}

{% comment %} 在这一步类似添加的post的方式, 把对应的共同tag数目也组成一个结构一样的对应数组{% endcomment %} 
{% if commonTagCount > 0 %}
  {% assign postsAfterFilter = postsAfterFilter | push: post %}
  {% assign tagCountEachPost = tagCountEachPost | push: commonTagCount %}
{% endif %}

{% comment %} 这里对文章进行对应的筛选, 需要借助我们自定义的filter实现 {% endcomment %} 
{% assign postsAfterFilter = postsAfterFilter | sort_by_array: {{tagCountEachPost}} %}
      
{% endraw %}
{% endhighlight %}

下面就是插件环节~

### 插件部分

Jekyll 的插件都是`.rb`结尾的文件, 放在`_plugins`路径下即可. 这里`filters.rb`是我用来专门放置我自己定制的filter的:

{% highlight ruby %}
# filters.rb
module Jekyll
  module CustomizeFilter
    def sort_by_array(fArray,sArray)
      newObj = {}
      newArray = []
      sArray.each_index do |x|
        newObj[x] = sArray[x]
      end
      newObj.sort_by{|_key, value| value }.each do |x,y|
        newArray.push(fArray[x])
      end
      newArray.reverse!
    end

  end
end

Liquid::Template.register_filter(Jekyll::CustomizeFilter)
{% endhighlight %}

如此基本就算搞定啦~

## 参考资料

- [Jekyll Related Posts without Plugin - 羡辙杂俎 ](http://zhangwenli.com/blog/2014/07/15/jekyll-related-posts-without-plugin/)
- [Custom Jekyll filter for tags](http://melandri.net/Custom-Jekyll-filter-for-tags/)
- [How to sort a Ruby Hash by number value?](http://stackoverflow.com/questions/2540435/how-to-sort-a-ruby-hash-by-number-value)
