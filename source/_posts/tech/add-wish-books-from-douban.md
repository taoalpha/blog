date: 2015-06-10 4:00:00
title: 如何获取豆瓣图书的"想读"列表 
category: tech
description: 为博客添加豆瓣读书的"想读"书目, 效果请见[tipme](/blog/tipme).
tags: [javascript,api,douban] 
author: taoalpha
---

## 缘起

之前给博客增加了一个打赏页面, 也算是试图筹集资金做些小项目的途径之一. 今天丰富了以下[打赏页面](/blog/tipme), 增加了一个书目的模块, 您也可以给我买书或者把自己看过的我想看的二手书送给我 ^_^

本文则是主要介绍下如何利用豆瓣的图书API获取"想读"列表.

## 阅读豆瓣API文档

[豆瓣API](http://developers.douban.com/wiki/?title=api_v2)豆瓣作为UGC的大户, 其内容价值含量极高, 所以起API的呼声也极大, 而一直以来, 豆瓣的API都是很多其他产品的一大内容来源. 所以这次考虑在我的页面上加入书目列表时, 第一个想到的也是豆瓣! 

首先我们确定下思路, 如果我们想要拉取一个"愿望清单"一样的书目, 最好的方法应该是建立一个豆列, 然后在豆瓣维护这个豆列即可. 这应该也是最直接的方法, 可惜的是, 豆瓣目前尚未开放和豆列有关的API接口, 这样就让我们无法获取豆列的信息了. 

那么, 退而求其次, 如果拿不到特定豆列, 我们就只能从我的全部图书方面找突破了. 在众多的图书接口中, [获取某个用户的所有图书收藏信息](http://developers.douban.com/wiki/?title=book_v2#get_user_collections)这个接口可以说是最为接近的了, 而且它提供了status和tag的筛选, 这样就让我们近似模拟一个豆列成为可能.

如何做呢? 首先我们需要把本来计划添加到"愿望清单"豆列的书都放到我们的想读中(愿望清单嘛), 并加上一个特定, 比如"MyWish"的标签, 如此, 我们就可以利用这两个纬度对我们的书目进行过滤, 抽取到我们需要的东西.

## 构造API链接获取API数据

根据[获取某个用户的所有图书收藏信息](http://developers.douban.com/wiki/?title=book_v2#get_user_collections)的说明, 我们需要三个参数就能实现我们的目的:

- user id: 指定用户;
- status: wish - 代表"想读"
- tag: MyWish - 或者你指定的某个tag

如此我们的api接口地址就构造完成了: "https://api.douban.com/v2/book/user/129154019/collections?status=wish&tag=MyWish" - 就是我的"愿望清单"列表.

通过最简单的get请求就能获得这一json格式的数据了, 这里我们几乎可以完全复用 <a href="{% post_path tech-add-google-analytics-pageviews-to-jekyll-blog %}">给jekyll添加google analytics的pageview一文</a>的函数:

``` javascript
function showMyWishBooks(){
  var bookapi = "https://api.douban.com/v2/book/user/129154019/collections?status=wish&tag=MyWish";
  $.ajax({
    url: bookapi, 
    dataType: 'jsonp',
    timeout: 1000 * 3, // 3 sec
    success: function(data) {
      parseBookDatas(data.collections);
    },
    error: function() {
      // if fail to get up-to-date data from douban, get cached local version
      console.log('Failed to get pageview from Douban!');
        $.ajax({
          url: '/blog/doubanbooks.json',
          dataType: 'json',
          success: function(data) {
            console.log('Local mybooks.data backup file.');
            parseBookDatas(data.collections);
          }
        })
    }
  })
}
```

## 解析API数据以及展现

拿到数据后自然就要解析应用, 这部分的话主要是因人而异, 根据自己的设计方式来, 我目前也只是简单的列举出来, 加了简单的hover图层效果. 

``` javascript
function parseBookDatas(data){
  var template = "<li class='book_item'><a href='__book_url__' alt='__book_alt_title__'><img src='__book_img__'><span>__book_title__</span></a></li>"
  $.each(data,function(key,item){
    var bookitem = template.replace("__book_url__",item.book.alt).replace("__book_alt_title__",item.book.alt_title).replace("__book_title__",item.book.title).replace("__book_img__",item.book.images.large);
    $('.books').append(bookitem);
  });
}
```

上述采用静态模板替换的方式来构造每个条目, 如果你喜欢liquid tempalte的话, 想要用[Mustache](https://mustache.github.io/) 或者 [hanldrbars](http://handlebarsjs.com/)的话, 也是完全可以的~ 具体实现方法对应的官网都说的很清楚了, 我就不多说喽~


## 参考资料:

- [豆瓣API文档](http://developers.douban.com/wiki/?title=book_v2#get_user_collections)
