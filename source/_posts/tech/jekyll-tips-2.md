date: 2015-05-07 7:00:00
title: Jekyll 筛选 tag 的实现 
category: tech 
description: 主要介绍下如何实现不同category下tag的展现以及筛选的实现, 效果模拟简书的tag
tags: [jekyll tags,tips,jekyll,js]
author: taoalpha
---

对于blog而言, 利用categories和tags的筛选是非常方便的, 而在jekyll部署的静态博客中也能轻松的实现这一点的. 本文(也即本博客)中效果主要模仿[简书](http://jianshu.com).

## 展现categories以及tags

> 首先我们需要设定了tags的post... 这样你的`site.tags`才会有数据~ 具体的tags设定方法可以参照 <a href="{% post_path tech-jekyll-tips-1 %}">心得(1)</a>
> 接着就是如何展现tags数据了~ 以本文为例, 我总计有三个category, 因为要实现不同category下的tag只出现在自己的category页面下方, 所以在展现tags的时候需要做一个category的判定.

``` liquid
{% raw %}
{% assign tags = "all" %}
// 设置变量, 这里用all来表示默认的第一个tag, 代表全部tags的情况
{% for post in site.posts %}
    // 取所有的post出来逐一判定, 这里未来post很多的话, 会进行数量限制, 目前数量太少, 就糙着用啦
    {% for tag in post.tags %}
        // 取post自己的tags出来, 逐一进行判定是否已经在tags数组列表中了
        {% unless tags contains tag %}
            // 为了去掉重复的tag~
            {% capture tags %}{{ tags }}|{{ tag }}{% endcapture %}
            // 把所有不在tags数组中的tag都加到tags中
        {% endunless %}
    {% endfor %}
{% endfor %}
{% assign alltags = tags | split: '|' %}
// 生成一个新的数组, 似乎本身liquid中没有直接append数组的方法... 看到此处的朋友有知道的请不吝告知~
<ul class="tags">
{% for tag in alltags %}
// 展现tag
<a href="javascript:;" data-rel="{{ tag }}" class="filter tag {% if tag == 'all'  %}active{% endif %}" >{{ tag }}</a>
// 这里的data-rel是为了筛选做的准备, 后文会介绍
{% endfor %}
</ul>
{% endraw %}
```

如此基本就实现了tags在特定category下的展现.

## 根据tag进行筛选

有了tags之后, 就可以进一步做筛选了. 基本的思路是在不考虑分页的情况下, 筛选基本就是针对当前展现出来的文章列表做对应的展现隐藏控制.

> 利用`data-rel`(随意指定data后面的名称即可)存储要筛选的tag, 如上;
> 在post中加上tags的数据标签:

``` liquid
{% raw %}
<li class="post" data-filter="{{ post.tags|join:' ' }}">
// 因为post.tags本身就是一个array类型, 所以这里直接用空格链接填入一个`data-filter`中即可;
{% endraw %}
```

> 利用js实现点击筛选的控制:

``` javascript
$(".filter").on("click", function () {
    // 由tag点击事件出发
    var $this = $(this);
    if ( !$this.hasClass("active") ) {
        // 排除当前已选tag, 新tag标记active
        $(".filter").removeClass("active");
        $this.addClass("active"); // set the active tab
        var $filter = $this.data("rel"); 
        // 获得要筛选的tag名称
        $filter == 'all' ? 
            // 对all做单独判断, 基本就是全展现
            $(".post")
            .not(":visible")
            .fadeIn() 
        : // 否则的话, 利用filter进行tag匹配的判断
            $(".post")
            .fadeOut(0)
            .filter(function () {
                // 判断post中是否包含此tag, 这里用array来判断而不是直接文本判断就是为了防止出现类似tag和tags这种局部包含的误判
                return $(this).data("filter").split(" ").indexOf($filter)!=-1; 
            })
            .fadeIn(1000); 
    } // endif
}); // endon
```

这里都用的是fadeIn,fadeOut的动效, 你当然可以修改成自己的~ 这里的实现主要参照了[jQuery filter with fancybox](http://www.jqueryrain.com/?http://www.picssel.com/demos/fboxfilteredgallery.html), 不过原理其实很简单的~

## tags限制

随着post的增多, 你会发现自己的tags也越来越庞大, 如果全部展现的话, 一是太多, 二呢, 展现也不方便, 毕竟我目前的css样式只考虑了两行的情况, 所以呢, 还是需要对tags的展现做一些限制的.

有两种思路:

- 利用jekyll的plugin直接在生成层控制, 每次随机出一些tag就行了;

- 利用js在展现层控制, 所有tag都生成出来, 但是由js控制随机展现一部分;

最终我用的还是第二种思路, 第一种思路主要缺点是在编译生成的时候控制的话, 只有每次重新编译才会重新生成, 和我希望的访问随机需求不符合.

实现方法也很容易, 基本就是利用Math.random()来生成随机数即可.

``` javascript
function randomTags(){
    var originArray = $('ul.tags').find('a.tag')
    originArray.eq(0).show();
    // 确保 all 每次都展现
    for (i=0;i<10;i++){
        var index = Math.floor(Math.random()*originArray.length)+1
        // 没有做虑重处理, 所以很可能展现出来的tag没有10个; 想做的话也容易, 循环过程中加个是否显示了的判断即可, 这里就不做了~
        originArray.eq(index).show();
    }
}
```

如上, 对于jekyll的tags和categories的探索就先这样了~ 以后有什么更加有趣的想法或者发现了再补充~

See ya.

[TaoAlpha]:    http://zzgary.info "TaoAlpha"
