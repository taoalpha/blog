date: 2015-06-01 1:00:00
title: Jekyll 添加 tag 专属页面
category: tech 
description: 随着写的博文逐渐增多, 使用的 tag 也越来越多, 单纯的页面 tag 随机筛选就变的不够用了, 于是今天就顺带的开启了 tag 的单页展示.
tags: [jekyll,ruby,jekyll tags] 
series: Jekyll Boost
author: taoalpha
---

## Tag的运用

Tag可以算是blog的标配了, 借用tag我们才能够让blog更好的归档, 既丰富了博客的内容体系, 也更便于筛选.而jekyll默认虽然给了tag的域, 但是却并不会自动开启tag的专属页面, 这个页面还需要我们自己来创建的. 建立tag专属页面的方法也有几种, 考虑到很多人都用github page作为自己jekyll的博客, 那么这里就按照有无插件辅助来区分以下方法吧(github page不支持插件~ 想要了解<a href="{% post_path tech-use-jekyll-plugin-with-github-page %}">如何在github page中使用jekyll插件</a>?)


## 无插件实现方法

如果不使用插件的话, 其实基本思路就和之前不使用插件建立[tech](/blog/tech), [dandp](/blog/dandp)两个分类页是一样的, 通过创建对应的tagpage template, 以及对应的tag单页引用相应的模板即可.

### 创建tagpage template

首先我们需要根据具体的需求创建一个tag页面的模板, 以我自己的为例:

``` liquid
{% raw %}
---
layout: home_base
---

<nav id="bread">
  <h2><a href="/blog">All Posts</a> >> Posts with tag: {{ page.tag }}</h2>
</nav>
{% assign cposts = site.tags[page.tag] %}
<article>
  <ul class="article-list">
    {% for post in cposts %}
    ... <!-- 填充展示内容 -->
    {% endfor %}
  </ul>
</article>
{% endraw %}
```

上述就创建了一个非常简单的tag单页模板.

### 创建tagpage 单页

留意上述的模板代码, 你就会发现我们是通过`site.tags`来筛选所有博文, 从而实现筛出特定tag的博文的目的的. 那么如果我们需要创建tag的专属页, 我们就需要在单页上指定tag, 所以单页的内容很简单:

``` liquid
{% raw %}
---
layout: tagpage
tag: jekyll
---
{% endraw %}
```

如此就创建了一个jekyll的tag单页, 那么访问路径设定呢? 有两种方法(都以`/tag/jekyll`为例):

- 通过新建文件夹tag, 然后在其中再新建jekyll文件夹, 在jekyll文件夹下创建index.html或者index.md文件, 填写上述代码即可;
- 在根目录下创建jekyll.md文件, 然后在上述代码的基础上加上`permalink: /tag/jekyll`即可;

如此就算是实现了不用插件的情况下对特定tag创建的tag专属页了.

<blockquote class="special update" markdown="1" data-flag="gotsomeupdateshere">
## Update

更新一种无插件创建tag页的方法: 思路是展现全部post在一个页面, 加上tag属性, 然后通过js借助url的parameter来实现过滤tag的功能;

### 创建全部post的单页

这一点基本和上述模板一致, 只需要将`site.tags.TAGNAME`换成`site.posts`就行, 然后将`post.tags`数据写到对应的li的class或者`data-`中. 这一点类似我之前<a href="{% post_path tech-jekyll-tips-2 %}">给目录页加tag筛选功能</a>的做法. 只是控制部分转移到url的参数了.


### 筛选过滤

接下来就是获取url参数以及控制筛选的过程了.

``` javascript

function getUrlParameter(sParam)
{
  // 默认你是通过"xxxx?tag=xxx"的结构传递tag的, 当然你可以根据具体的情况(比如#)修改
  // location.search可以自动返回?及之后的字串
  var rParams= window.location.search.substring(1);
  var aParams = rParams.split('&');
  for (var i = 0; i < aParams.length; i++) 
  {
    var sParameterName = aParams[i].split('=');
    if (sParameterName[0] == sParam) 
    {
      return sParameterName[1];
    }
  }
} 

```

获取后则是针对所有posts的一个遍历筛选了. 当然如果你前期模板建立的时候就按照tag把blog聚合成块的话, 那么此时筛选甚至可以做的更简单一些, 如下:

``` javascript

window.onload = function() {
  var tag = getUrlParameter('tag');
  if (tag && document.getElementById('tag-' + tag)) {
    document.getElementById('tag-' + tag).style.display = 'block';
    document.getElementById('tagTitle').innerHTML = tag;
  } else {
    document.getElementById('tagTitle').innerHTML = 'Illegal Tag Query';
  }
};
// 如上需要你模板定义是按照tag将博文提前聚合成块~

```

Inspired by: [Wenli Zhang - Jekyll Tag Searching ](http://zhangwenli.com/blog/2014/05/18/jekyll-tag-searching/)

</blockquote>

## 插件自动生成

不用插件的方法的劣势显而易见. 而引入插件就是帮助我们客服这种缺点的. 既然我们不想要手动的去维护tag数据, 而是希望比较一劳永逸的每次build时自动创建. 那么如何操作呢? 其实也很简单:

首先我们需要以下几个材料:

- `_plugins`文件夹, 位于根目录下;
- tagpage template文件, 同无插件法;

有了上述基本材料, 我们就可以开始写我们的标签页生成插件了.

jekyll是基于ruby的, 所以jekyll的插件也都是ruby来写的, 有兴趣的朋友可以自行学习以下, 没兴趣的朋友可以直接那我下面的代码用, 按照我备注的部分修改下即可:
``` ruby
module Jekyll
  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tagpage.html')
      // _layouts和tagpage.html即是我们的tagpage template所在了
      self.data['tag'] = tag
      tag_title_prefix = site.config['tag_title_prefix'] || 'Posts Tagged &ldquo;'
      tag_title_suffix = site.config['tag_title_suffix'] || '&rdquo;'
      // 写在单页里面title域的部分
      self.data['title'] = "#{tag_title_prefix}#{tag}#{tag_title_suffix}"
    end
  end
  class TagGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'tagpage'
      // 如果你用的模板名称不是"tagpage.html"的话, 记得修改这里的名字
        dir = site.config['tag_dir'] || 'tag'
        // 如果你想要自己定义tag单页存储的路径, 或者说是访问路径中的tag前缀, 可以在config里面设定 tag_dir 的值, 或者是直接改这里也行~
        site.tags.keys.each do |tag|
          write_tag_index(site, File.join(dir, tag), tag)
        end
      end
    end
    def write_tag_index(site, dir, tag)
      index = TagIndex.new(site, site.source, dir, tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end

end
```

上述的插件就可以帮助你自行给每一个tag都创建一个目录和对应的`index.html`文件, 你就可以通过对应的路径访问了.

## 总结

ruby的插件体系真的很赞啊! 哈哈 上述就是如何折腾出tag专属页的方法啦, 你可以通过点击我blog首页每条博文下方的标签就能查看效果了~

## 参考资料

- [Separate pages per tag/category with Jekyll (without plugins)](http://christianspecht.de/2014/10/25/separate-pages-per-tag-category-with-jekyll-without-plugins/)
- [charliepark tag_gen.rb](https://github.com/charliepark/charliepark.github.com/blob/master/_plugins/tag_gen.rb)

