date: 2015-05-21 3:00:00
title: Jekyll 中如何做中文字数统计
category: tech 
description: 如何利用已有的 Jekyll 过滤器做中文字数统计
tags: [jekyll]
series: Jekyll Boost
author: taoalpha
---

这两天又优化了以下blog, 首先是给天气部分加上了cookie和定位控制, 这样一方面能减少对openweather的请求次数, 同时优化加载的速度, 另一方面也能更加智能化的显示天气. 当然, 为了防止定位错误的问题, 我也同时增加了自定义位置的功能, 同样给予了cookie记录. 具体的实现方法, 这里就不多说了, 也很简单.

本文主要是介绍下jekyll中如何实现中文的字数统计. 为什么要做字数统计呢? 还是来源于[简书-文章页](http://www.jianshu.com/p/613916eea37f), 里面详细的记录了作者的信息以及当前文章的字数. 再加上一个实时统计的阅读次数, 当然对我而言, 这个实时阅读次数意义不大, 我就顺着字数统计改成了阅读时间估计. 恩, 没错, 又是模仿[medium](https://medium.com/)的~ ಥ_ಥ

## 字数统计方法

如何统计一段文本的字数是有很多种方法的, 但是因为语言文字的不同, 很多时候, 不同的方法对不同的语言文字适用性是不一样的. 目前来说, 通常有以下几种字数统计方案:

- 根据常规的一个中文字符等于两个英文字母的概念, 通过获取整个文本的长度(比如js中的length), 除以2就可以获得一个粗略的值了, 如果要精确些, 可以在上述方法的基础上加入`charCodeAt()`来判断字符属性是中文还是英文字母, 然后区分计算;
- 如果是纯英文, 通常统计的都是词数而非字数, 而英文天然的空格分词, 也让统计其词数非常容易, 只需要按照空格切分获取长度即可;
- 如果是纯中文, 我们统计的则多数是字数, 这种情况下, 因为中文缺少类似英文空格这种天然的切分符号, 就不能单纯的使用切分法来获取字数了, 可以借鉴第一种方法所述, 通过去除换行以及标签符号, 然后获取最后的数组大小来实现;
- 如果是中英文混杂, 那么同样可以使用上述方法获得粗略数值, 当然, 如果你需要精确的话, 也需要对文本字符属性做判断来区分处理;

### jekyll中的词数统计

`number_of_words`是jekyll中已有的一个词数统计过滤器, 可以很方便的统计出文本的英文词数, 但对中文就不适用了... 因为它本身是根据空格, 标点符号等来切分统计的, 有的时候甚至连英文都可能不准确... 

### 取巧的统计方式

jekyll支持的众多filter中, 有这么一个`size`, 是可以返回一个数组的大小的, 而且能够正确的理解类似中文GBK的编码的. 于是我们可以使用类似:

``` liquid
{% raw %}
Approximate number of English words: {{ text | split: " " | size }}
Approximate number of Chinese words: {{ text | split: "" | size }}
// 可以看到都是近似值~ 如果你对精度要求没那么高, 那么基本是够用了~
// 实际上, 因为本身size支持文本, 所以对中文这里可以不用split: ""的
{% endraw %}
```

那么回过头, 我们如果要统计content里面的中文字数就可以利用`size`这个方法了. 不过考虑到content里面有很多html的tag, 我们为了更加接近真实数值, 可以借用`strip_html`以及` strip_newlines`两个过滤器来去除所有的html tag和空行. 那么最终的代码就是:

``` liquid
{% raw %}
{ { content | strip_html | strip_newlines | size } }
{% endraw %}
```

其实在jekyll的github issue中有人已经问过类似的问题[jekyll的中文切分问题](https://github.com/jekyll/jekyll/issues/1921). 

## 阅读速度问题

既然获得了字数, 那么想要获得阅读时间就很容易了, 通常英文单词的阅读速度在350wpm(词每分钟), 而中文也是基本接近的350字每分钟左右. 那么这次利用`divided_by`以及`round`两个函数就可以获得一个大致的分钟数了:
(有兴趣的可以前往参考来源的第二条中看关于中文, 英文阅读速度的一篇文章)

``` liquid
{% raw %}
{ content | strip_html | strip_newlines | size | divided_by:350 | round}}
{% endraw %}
```

## 参考来源

- [jekyll的中文切分问题](https://github.com/jekyll/jekyll/issues/1921)
- [Which reads faster, Chinese or English?](http://persquaremile.com/2011/12/21/which-reads-faster-chinese-or-english/)


[TaoAlpha]:    http://zzgary.info "TaoAlpha"
