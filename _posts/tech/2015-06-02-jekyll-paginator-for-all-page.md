---
layout: post
title: Jekyll 添加翻页部分(包含分类页,标签页)
category: tech 
description: 随着写的博文逐渐增多, 也逐渐开始需要给博客添加一个翻页组件了. 不过因为 jekyll 目前默认的 paginator 只支持博客首页, 在其他页面都是无效的, 所以需要自己动手, 丰衣足食喽...
tags: [jekyll,ruby,paginator] 
series: jekyll-tips
author: taoalpha
---

## 缘起

随着博文数量正式达到15篇以上, 我寻思着也是时候给blog增加一个翻页的部分了.  首先当然是研究[jekyll的官方文档](http://jekyllrb.com/docs/pagination/), 然后再结合我们自己的需求进行修改. 因为考虑到blog的通常结构都会有category和tag, 而且昨天刚刚增加了[tag专属页]({{ site.baseurl }}{% post_url tech/2015-06-01-jekyll-tag-page %}), 所以就希望能够在category和tag页下都增加一个翻页的模块. 而目前jekyll的默认paginator尚无法支持这样的需求, 我们只能自己动手喽~

## jekyll paginator

### 开启翻页模块

jekyll有默认的paginator, 可以非常简单的开启. 只需要在_config.yml中加入下面这行行即可:
{% raw %}
    paginate: 2
{% endraw %}

这里的paginate表示是单页显示的博文条数. 这里设置2也是为了方便测试, 具体数值大家根据需要自行调整即可.

通过设定paginate后, 就可以重新build一下jekyll, 你就会发现在`_site/blog`路径下多出了一些`pageX`的文件夹了~ 这些就是生成的分页了.

### 添加翻页导航模块

开启翻页后, 就需要我们自行在页面上添加上翻页导航组件了. 这里需要借助`paginator`这个对象, 其包含了当前页面下分页的一些基本属性. 具体参照下面的代码即可.

{% raw %}
    {% if paginator.total_pages > 1 %}
    <div class="pagination">
      {% if paginator.previous_page %}
        <a href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}">&laquo; Prev</a>
      {% else %}
        <span>&laquo; Prev</span>
      {% endif %}
    
      {% for page in (1..paginator.total_pages) %}
        {% if page == paginator.page %}
          <em>{{ page }}</em>
        {% elsif page == 1 %}
          <a href="{{ '/' | replace: '//', '/' }}">{{ page }}</a>
        {% else %}
          <a href="{{ site.paginate_path | prepend: site.baseurl | replace: '//', '/' | replace: ':num', page }}">{{ page }}</a>
        {% endif %}
      {% endfor %}
    
      {% if paginator.next_page %}
        <a href="{{ paginator.next_page_path | prepend: site.baseurl | replace: '//', '/' }}">Next &raquo;</a>
      {% else %}
        <span>Next &raquo;</span>
      {% endif %}
    </div>
    {% endif %}
{% endraw %}

当然, 对应的页码显示样式就要看大家自己设定喽~

## 定制翻页插件

### 插件部分

如果只需要在首页开启翻页的话, 如此倒也是足够了. 但是如果想要在category以及tag分页上都加上翻页导航的话, 就需要在上述基础上自行定制了.

首先我们可以学习以下默认的pagination是如何做的, 这一点我们可以在[github上jekyll-paginate的主页](https://github.com/jekyll/jekyll-paginate/blob/master/lib/jekyll-paginate/pager.rb)查看其源码.

可以看到基本方法是完全可以通用的, 只是默认情况下的pager这个包含了翻页信息的对象只包含在了首页的创建上. 我们完全可以在生成tag页和category页的时候也同时生成一个对应的pager对象. 接下来我们就可以在原来的[jekyll生成tag页]({{ site.baseurl }}{% post_url tech/2015-06-01-jekyll-tag-page %})中的示例代码基础上加上pager.


{% highlight ruby %}
module Jekyll
  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tagpage.html')
      self.data['tag'] = tag
      tag_title_prefix = site.config['tag_title_prefix'] || 'Posts Tagged &ldquo;'
      tag_title_suffix = site.config['tag_title_suffix'] || '&rdquo;'
      self.data['title'] = "#{tag_title_prefix}#{tag}#{tag_title_suffix}"
      self.data['pname'] = "tag/#{tag}"
      // 自定义的一个页面标识, 同时也为了后面修改tag单页增加一个url前缀用的
    end
  end
  class TagGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'tagpage'
        dir = site.config['tag_dir'] || 'tag'
        site.tags.keys.each do |tag|
          write_tag_index(site, File.join(dir, tag), tag)
          #write_tag_index(site, File.join(dir, tag.split.map(&:capitalize).join("-")), tag.split.map(&:capitalize).join("-"))
        end
      end
    end
    def write_tag_index(site, dir, tag)
      // 下述代码有所修改, 注意!
      tag_posts = site.posts.find_all {|post| post.tags.include?(tag)}.sort_by {|post| -post.date.to_f}
      // 当前tag的所有post
      num_pages = TagPager.calculate_pages(tag_posts, site.config['paginate'].to_i)
      // 所有post分出的页数
      (1..num_pages).each do |page|
        pager = TagPager.new(site, page, tag_posts, tag, num_pages)
        index = TagIndex.new(site, site.source, dir, tag)
        index.pager = pager
        index.dir = dir
        if page != 1
          index.dir = File.join(dir, "page#{page}")
          // 生成page路径
        end
        index.render(site.layouts, site.site_payload)
        index.write(site.dest)
        site.pages << index
      end
    end
  end

  class TagPager < Jekyll::Paginate::Pager
    // 继承paginate::pager的类, 直接使用了
    attr_reader :tag

    def initialize(site, page, all_posts, tag, num_pages = nil)
      @tag = tag
      super site, page, all_posts, num_pages
    end

    alias_method :original_to_liquid, :to_liquid

    def to_liquid
      liquid = original_to_liquid
      liquid['tag'] = @tag
      liquid
    end
  end

end
{% endhighlight %}

如上, 基本插件部分就没啥事了~ 当然, category的部分几乎可以说是完全一样的, 只需要把对应tag的部分全部替换为category的相应属性就行啦. 这里就不占位的贴代码了.

### 页面导航组件显示部分

页面级的改动也不多, 因为我的category, 首页, tag页用的是同一个模板, 所以修改起来相对容易~ 只是针对不同的页码调整了以下翻页导航的url构成~ 如下:

{% raw %}
    {% if paginator.total_pages > 1 %}
    {% assign pname = page.pname %}
    {% if page.pname == "blog" %}
      {% assign pname = "" %}
    {% endif %}
    <!-- pname就是我之前插件中加入的那个用来表明所属页面属性的, 顺带也故意写成了方便添加url的路径格式, 且下面这些路径还需要根据具体情况自行调整~ -->
    <div class="pagination">
      {% if paginator.previous_page %}
        <a href="{{ paginator.previous_page_path | prepend: "/" | prepend: pname | prepend: "/" | prepend: site.baseurl | replace: '//', '/' }}">&laquo; Prev</a>
      {% else %}
        <span>&laquo; Prev</span>
      {% endif %}
    
      {% for page in (1..paginator.total_pages) %}
        {% if page == paginator.page %}
          <em>{{ page }}</em>
        {% elsif page == 1 %}
          <a href="{{ '/' | prepend: pname |prepend: "/"| prepend: site.baseurl | replace: '//', '/' }}">{{ page }}</a>
        {% else %}
          <a href="{{ site.paginate_path | prepend: "/" | prepend: pname | prepend: "/" | prepend: site.baseurl | replace: '//', '/' | replace: ':num', page }}">{{ page }}</a>
        {% endif %}
      {% endfor %}
    
      {% if paginator.next_page %}
        <a href="{{ paginator.next_page_path | prepend: "/" | prepend: pname | prepend: "/" | prepend: site.baseurl | replace: '//', '/' }}">Next &raquo;</a>
      {% else %}
        <span>Next &raquo;</span>
      {% endif %}
    </div>
    {% endif %}
{% endraw %}

恩, 完事! 剩下的就是大家根据自己的需要来赋予翻页组件合适的样式喽~

## 结论

本人的ruby属于初学, 所以代码基本是我参照源码和前人的经验修改而来的~ 也算是学习的过程, 基本参照对象都会列在下面的`参考资料`中~ 尽请翻看~

## 参考资料

- [jekyll-paginate github](https://github.com/jekyll/jekyll-paginate/)
- [nicoespeon category_pagination](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_plugins/category_pagination.rb)
- [jekyll pagination 官方说明](http://jekyllrb.com/docs/pagination/)

