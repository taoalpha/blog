---
layout: post
category: tech
series: MySQL Shortcuts
description: ''
title: Patch-Day14-mysql的常用语句收集(1)
tags: [sql,Patch]
---

今天利用django的app写了个小项目, 通过修改以前的爬虫脚本,将百度图片的"信息图"下图片以及其它一些信息图的网站的图片链接抓取下来,存储到数据库之中~然后再django中展示,关于django的app和mysql的交互中的各种问题则放在之后来说~

django 作为python下最知名的网络框架之一, 可以说极大的方便了很多Python开发者们转变为web developer~哈哈

- 主要分一下几个方面:
 - 如何修改table的默认字符编码类型?
 ** A:** 因为本次抓取数据既包含中文站点的数据也包含很多国外的英文站点,所以选用utf8的编码类型比较合适,而默认是latin的编码类型,可以在create table的时候直接指定,也可以通过之后修改得到:
 
{% highlight mysql %}

CREATE TABLE tbl_name (column_list)
    [[DEFAULT] CHARACTER SET charset_name]
## CREATE TABLE t1 ( ... ) CHARACTER SET utf8;
ALTER TABLE tbl_name
    [[DEFAULT] CHARACTER SET charset_name]
## ALTER TABLE t1 ( ... ) CHARACTER SET utf8;

{% endhighlight %}

 - 如何修改表结构增减列?
 **A: ** 同样是Alter的方式,在表已经建立后也可以对表进行增减列的操作~

{% highlight mysql %}

ALTER TABLE `table` DROP `id`;
## 从表中删除id列;
ALTER TABLE `table` ADD `id` int(8);
## 从表中增加id列;

{% endhighlight %}

 - 如何重置id列(自增)?

 **A:**这是一个很有意思的用法,因为一些原因,在建表的时候设定自增的id会在使用过程中出现很多的空白段,因为只要是sql的insert语句执行就会计算id,即便插入失败或者删除,也不会影响到id的后续自增;所以你有时候会发现自己表中所有的数据才几千行,但id已经增加到几万了..

{% highlight mysql%}

ALTER TABLE `table` DROP `id`;
## 删除id列;
ALTER TABLE `table` AUTO_INCREMENT = 1;
## 设置表自增;这个可有可无..
ALTER TABLE `table` ADD `id` int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
## 插入新列,自增,并设置为primary key(这个根据自己的需要);

{% endhighlight %}

 - 如何防止重复数据呢?

 **A: **这是一个很实用的功能,google的时候也发现很多种方法,但实际上有一个最简单的方法就是利用unique属性(感谢开发大神!)~通过把重要的区分性字段设置为unique,就可以在插入的时候通过重复冲突而插入失败;

{% highlight mysql %}

ALTER TABLE t_name ADD UNIQUE (column_name)
## 多个的话需要用逗号间隔开即可;

{% endhighlight %}

 - 如何更新某个数据?

 **A: **这也是一个非常常用的sql语句~

{% highlight mysql %}

UPDATE table_name SET field1=new-value1, field2=new-value2 [WHERE Clause]
## where的从句主要是为了筛选;

{% endhighlight %}


本次就到这里了~以后实际应用sql的时候有好的积累再继续哈~
