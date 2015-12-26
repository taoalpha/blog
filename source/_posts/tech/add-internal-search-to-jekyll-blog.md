date: 2015-06-21 6:00:00
title: 自建倒排, 为 Jekyll 博客添加搜索功能
category: tech 
description: 静态博客的一大缺陷就是无法实现一些复杂的功能, 比如搜索. 本文通过jieba分词以及自定义插件而实现在jekyll编译过程中内建倒排索引, 再利用js做简单的分词处理与倒排索引配合从而实现最粗糙的搜索功能.
tags: [jekyll,内置搜索,search engine,倒排] 
series: Jekyll Boost
author: taoalpha
---

## 缘起

作为博客, 搜索功能一般来说都算是标配之一了. 而Jekyll作为静态博客, 则很难实现这种动态的实时的搜索请求. 所以通常来说, Jekyll 博客想要添加搜索功能的话, 无外乎以下几种方法:

- Google/Baidu自定义搜索或者更简单的"site"限定域搜索, 简单易行, 一个链接搞定, 主要适用于内容较多,搜索引擎友好收录较多的站点;
- 接入第三方服务, 目前博主知道的做这种博客全文搜索服务的有两家: [IndexTank](http://www.searchify.com/documentation/api#searching) 以及 [Swiftype](https://swiftype.com/). 这两种的接入方式也略有不同, 后面我会分别介绍以下;
- 自建: 这种比较费力不讨好, 目前也没什么人用的感觉... 当然, 博主这次就简单尝试了下...


## 自建

想要给jekyll自建一个内部搜索的话, 需要先清楚以下几点:

- jekyll是静态博客, 静态就导致其所有页面都是编译好的, 没有复杂的数据库更没有和数据库交互的功能, 同时其一旦编译, 那么所有支持的功能都只能由JavaScript实现了;
- 搜索通常发生的几个环节为: 
  - 准备工作: 分词->索引->倒排索引
  - 查询过程: Query查询->Query分词->比对倒排->获取匹配结果->展示
- 因为静态的原因, 所以我计划的搜索的工作流为: 本地编译的过程中建立一份倒排索引, 前端查询则使用js, 根据query匹配倒排, 用js解析处理展示结果;

下面具体介绍下各个环节:

### 分词

分词可以说是搜索的根本, 没有好的分词, 一切都免谈. 目前流行的分词, 尤其是中文分词也有不少, 但考虑到我们需要结合jekyll使用, 所以尽量找有现成ruby的. 所幸在[RubyGems](http://rubygems.org)里面找到了"jieba_rb"模块, 正好"结巴分词"也可以说是目前开源中做的很不错的一个中文分词了~ [Jieba_Rb Github](https://github.com/altkatz/jieba_rb)是其项目所在地址, 有兴趣的可以围观之. 而且最好的是它不仅支持分词, 还支持关键字提取, 而这个对jekyll的自建搜索而言是至关重要的.

** 因为如果全文分词做倒排的话, 倒排文档会很庞大, 这样对于js前端处理倒排的时候压力就会很大, 所以如果每个博文都只用其关键字来做倒排, 那么就能在保证一定的质量的同时, 确保不会产生太大的性能问题. **

安装`jieba_rb`是非常容易的, 你可以根据自己的情况利用`bundle`或者`gem`直接安装~

### 倒排索引

选好的分词库, 我们就可以正式开始制作倒排了, 有了 <a href="{% post_path tech-jekyll-tag-page %}">建立Tag专属页</a>的经验, 我们可以采用类似的方法来创建一个建立search页的插件:

``` ruby
{% raw %}
# file: _plugins/search.rb
require "jieba_rb"
require "json"

# 引入'jieba_rb'和'json'两个库. 后者主要是为了将Hash值转为string的时候用的

module Jekyll
  class SearchPage < Page
    def initialize(site, base, dir,h,l)
      # 初始化page的设定, 因为考虑到写入json文件的二次请求, 不如直接写入到页面内, 这样可以保证搜索的速度, 同时文本本身请求压力比较小, 也就不用增加多次请求了.
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'search.html')
      self.data['title'] = "Internal Search"
      self.data['index'] = h.to_json
      self.data['worddict'] = l.join(",")
      # 将倒排索引和倒排词目录写入到page属性中, 从而可以在模板文件中直接写入到html页面中去.
    end
  end
  class SearchGenerator< Generator
    safe true
    def generate(site)
      # 类似tag页面, 这里也把search的这个页面放在了search目录下
      if site.layouts.key? 'search'
        dir = site.config['search_dir'] || 'search'
        write_search_index(site, File.join(dir, ''))
      end
    end
    def write_search_index(site, dir)
      h = Hash.new
      nh = Hash.new
      po = Hash.new
      # 三个hash值分别用来存储索引,倒排索引和博文文档信息
      tlist = []
      # 一个array用来存储倒排词表, 这个主要是用来给js做分词词典使用的
      keyword = JiebaRb::Keyword.new
      # 因为jibe的keyword模块, 因为只用到了关键字提取部分 
      site.posts.each do |post|
        # 逐文提取关键词
        alist = []
        keywords_weights = keyword.extract post.content,35
        # 目前只给了35的限制, 其实可以放的更宽些, 目前我20来篇的博文, 基本几秒内就建好了
        keywords_weights.each{|k,v|
          alist.push(k.downcase)
          # 将关键词归一化处理存放到列表中 
        }
        postdata = Hash.new
        # 存放post相关的信息
        postdata['post_id'] = post.id
        postdata['post_url'] = post.url
        postdata['post_title'] = post.title
        if post["language"] == "en"
          postdata['post_content'] = post.content[0...400].gsub!(/(<[^>]*>)|{%|%}|\s|\n|([#]+)|\t/) {" "}
        else
          postdata['post_content'] = post.content[0...200].gsub!(/(<[^>]*>)|{%|%}|\s|\n|([#]+)|\t/) {" "}
        end
        # 截断正文取摘要, 这里加了个中英文区分
        postdata['post_author'] = post["author"]
        postdata['post_category'] = post.categories
        postdata['post_tags'] = post.tags
        postdata['post_date'] = post.date
        h[post.url] = alist.uniq
        # 生成的索引h
        # 将关键词去重处理
        po[post.url] = postdata
        tlist = tlist | alist.uniq
      end

      # 创建倒排索引
      tlist.each{|k|
        klist = []
        h.each{|k2,v|
          if v.include? k
            klist.push(po[k2])
          end
        }
        nh[k] = klist
      }

      # 输出页面
      index = SearchPage.new(site, site.source, dir, nh, tlist)
      index.dir = dir
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end

end
{% endraw %}
```

在我们将生成的倒排索引和倒排词表输出到页面后, 就可以着手写页面模板了.

``` jekyll
{% raw %}
---
layout: home_base
function: search
---

<nav id="bread">
  <h2><a href="/blog">All Posts</a> >> Search: </h2>
</nav>

<p style="display:none;" id="indexdata">{{ page.index }}</p>
<p style="display:none;" id="worddicts">{{ page.worddict }}</p>
{% comment %} 将插件中生成的倒排数据和倒排词表存放到隐藏p元素内, 加以id方便js提取 {% endcomment %}

<form action="" class="search">
<input id="search" type="text" placeholder="Enter to search.">
<button id="gosearch" type="button">Go</button>
</form>

<article>
  <ul class="article-list">
 </ul>
</article>

<script type="text/javascript" charset="utf-8">
  $('form.search').submit(function(e){
    e.preventDefault();
    e.stopPropagation();
    $('button#gosearch').trigger('click');
  })

  $('button#gosearch').on('click',function(){
    var query = $('input#search').val();
    search(query);
  })
</script>
{% endraw %}
```

模板的话, 主要根据自己的需要来设置了, 主要是为了将输出的倒排和倒排词表写入文档之中.

那么这一切做好了之后, 我们的**准备工作**部分算是基本完成了. 当你编译后去查看你的search页面时就能看到页面里面已经出现了类似:

``` json
"代码": [{
    "post_id": "/2015/05/06/new-blog",
    "post_url": "/2015/05/06/new-blog.html",
    "post_title": "My New Blog",
    "post_content": "在回国前最后一天的时候, 我在BBH列了下回国后要做的几件事, 其中之一就是迁移我的Blog中技术和HCI的部分到github page上来. 到今天终于算是做完了. 内容还没有完全迁移, 也可能不准备迁移内容了... 以后的技术更新和HCI的翻译等等都准备直接发到这里了.    这个blog的设计和结构主要借鉴了[简书](http://www.jianshu.com/), 代码是在我之前的那个b",
    "post_author": "taoalpha",
    "post_category": ["blog"],
    "post_tags": ["介绍"],
    "post_date": "2015-05-06 00:00:00 +0800"
}, {
    "post_id": "/2015/05/29/use-jekyll-plugin-with-github-page",
    "post_url": "/2015/05/29/use-jekyll-plugin-with-github-page.html",
    "post_title": "在 Github Pages 中使用Jekyll插件",
    "post_content": "  Github Page的jekyll      Github Page对jekyll的支持是很到位的, 唯一的不足可能也是其本身基于安全考虑而使得jekyll始终都是运行在safe模式, 目前[放开的插件列表非常有限], 所以很多jekyll的插件都无法使用. 当然, 单纯支持的几个插件或者不用插件也是完全可以做出很好的效果的, 不过个人比较喜欢折腾, 所以虽然目前只有一个可有可无的压缩需求",
    "post_author": "taoalpha",
    "post_category": ["tech"],
    "post_tags": ["jekyll", "plugin", "github page"],
    "post_date": "2015-05-29 00:00:00 +0800"
}, {
    "post_id": "/2015/06/11/javascript-callback-notes",
    "post_url": "/2015/06/11/javascript-callback-notes.html",
    "post_title": "JavaScript callback学习笔记",
    "post_content": "  缘起    今天帮朋友做一个网站, 涉及到js请求并且渲染数据. 因为js语言的特点使得其代码是由上至下依次执行的, 有一个比较恶心的问题在于这一执行顺序并不等同于其先后顺序, 如果中间有一步或者几步的后续执行比较耗费时间, js本身是不会等待其执行完再去执行下面的语句的. 如此就会出现一些因为执行时间而导致的问题, 尤其是请求和渲染数据的时候. 如果你分开来写, 顺次执行的时候, 请求这一",
    "post_author": "taoalpha",
    "post_category": ["tech"],
    "post_tags": ["js", "callback"],
    "post_date": "2015-06-11 00:00:00 +0800"
}]
```

上面这其实就是你的倒排文档啦~

### query分词

编译部分的工作做完后, 我们就需要开始进行查询部分了. 首当其冲的还是分词.

针对查询这部分的分词方法也有几种不同的方法:

- 借助第三方API, 目前博主知道的有[pullword](http://pullword.com/), [jieba-demo](http://jiebademo.ap01.aws.af.cm/), [SAE 搭建](http://simonfenci.sinaapp.com/index.php?key=simon&wd=你好世界). 上述三个博主都试了下... 结果无一例外遇到了跨域问题... 而三者都不是json格式返回, 所以常用的jsonp跨域无法解决...;
- 手写js实现: 有好有坏, 有的简单有的复杂, 视个人情况而定... 比如博主是因为也没别的法子了...

既然决定了自己写, 那么怎么写呢? 首先, 目前主流的中文的分词方法都是[字典法](http://www.cnblogs.com/flish/archive/2011/08/08/2131031.html), 匹配抽取即可; 也比较容易实现. 而正好我们拥有倒排词表(实际上正是因为要手写需要词典, 所以才导出倒排词表的), 所以可以将倒排词表作为词典文件来切词. 具体的做法简要概述即是:

**以倒排词表为词典, 对传入query进行逐个匹配抽取;**

我是采用简单的暴力抽取法:

``` javascript
function search(query){
  var inverted_index = JSON.parse($('p#indexdata').text());
  // 拿倒排并且恢复为json格式
  var result = [];
  var dict = $('p#worddicts').text().split(",");
  // 拿倒排词表,并且恢复为array
  query = query.toLowerCase().replace(/[(^\s+)(\s+$)]/g,"");
  // 归一化query... 绝对暴力归一化, 去除所有空格..
  var splitwords = [];
  $.each(dict,function(k,v){
    if(query.indexOf(v)>-1){
      splitwords.push(v);
    }
    // 逐个遍历, 不匹配的干掉, 匹配抽取
  })
  if(splitwords.length){
    // 准备合并倒排, 这里如果没有抽取出来关键词的话, 就直接pass返回无结果啦哈哈
    $.each(splitwords,function(k,v){
      result = result.concat(inverted_index[v]);
      // 合并倒排, 这里使用的是并集, 是因为目前博客文章不多, 所以取交集... 空结果太多..哈哈
    })
    showSearchResult(result.getObjectUnique('post_url'));
  }else{
    // 无结果提醒
    $('ul.article-list').empty().append('<li class="post"><h2>无结果, 请更换查询词</h2></li>');
  }
}

function showSearchResult(data){
  // 这里主要是沿用了我之前首页的结构~
  $('ul.article-list').empty();
  // 记得每次查询前要清掉上次查询结构哦~
  var template = '<li class="post"><h2><a href="__post_url__">__post_title__</a></h2><summary class="title-excerpt">__post_desc__</summary><div class="post-info"><span class="author"><i class="fa fa-user"></i><a href="__post_author_url__">__post_author__</a></span><span class="category"><i class="fa fa-briefcase"></i><a href="__post_category_url__">__post_category__</a></span><span class="postdate"><i class="fa fa-history"></i>__post_date__</span><span class="viewcount"></span></div></li>';
  $.each(data,function(k,v){
    var child = template.replace("__post_url__","/blog"+v.post_url).replace("__post_title__",v.post_title).replace("__post_desc__",v.post_content+"...").replace("__post_author_url__","/blog/author/"+v.post_author).replace("__post_author__",v.post_author).replace("__post_category_url__",v.post_category == "blog"? "/blog":"/blog/"+v.post_category).replace("__post_category__",v.post_category).replace("__post_date__",v.post_date.replace('00:00:00 +0800',''));
    $('ul.article-list').append(child);
  })
}
```

到此, 基本算是完事了~  如果你想要尝试下我的搜索效果, [请点此](/blog/search/)


## 第三方服务

第三方服务的话, 肯定都比我做的这个要精细多了哈哈. 因为博主只了解了下面两个提供此类服务的服务, 所以就简单介绍下这两个:[IndexTank](http://www.searchify.com/documentation/api#searching) 以及 [Swiftype](https://swiftype.com/). 

先说下共同点吧:

- 都是`full-text-search`, 不想我这种是关键词... 而且不一定准确...哈哈
- 省事, 都是宣称的实时收录~ 给力!
- 方便, 都是有现成的接口, 比如`IndexTank`有一个配套的jekyll插件, 可以直接安装调用; `swiftype`则是代码嵌入型的, 更省事;
- 都支持中文...

恩, 在介绍下不同点:

### IndexTank

- 开源: 赞! 应该是从被**linkedin**收购后就开源了, 名字也改成了searchify~哈哈
- 30天免费试用; 之后标配是$59/month, doc限制在50w份(写50w的blog也够牛逼了...);
- api齐全, [IndexTank API](http://www.searchify.com/documentation/api#searching), 定制性比较好;

### Swiftype

- 半开源: [Swiftype Github](https://github.com/swiftype), 基本都是其在各个语言下的支持库;
- 有免费服务: 只支持一个服务, 文档更新不如付费版本来的及时, 也不提供搜索数据分析等等, 不过, 绝对够用...
- 可少量定制: 可以做轻微的定制;
- 超省事儿: 基本可以说几行代码搞定的节奏...

从某种程度上说, swiftype算是个轻量级的Google CSE(自定义搜索引擎). 恩, Google的CSE其实可以算是博主知道的第三个...

PS. 这里有个使用了swiftype服务的hexo博客, 有兴趣的可以看看: [IIssNan's Notes](http://notes.iissnan.com/#stq=%E6%B5%8B%E8%AF%95&stp=1)

## 参考资料

- [jieba_rb Github](https://github.com/altkatz/jieba_rb)
- [JavaScript 实现简单的中文分词](http://my.oschina.net/goal/blog/201674) 很赞, 但是我没用.. 主要是我的太明显了.. 简单暴力就可以搞定了...
- [Lunr.js Github](https://github.com/olivernn/lunr.js) js搜索的前辈级产品, 可惜最后也没用
- [中文分词技术介绍](http://www.cnblogs.com/flish/archive/2011/08/08/2131031.html)
