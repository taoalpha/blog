---
layout: post
category: tech
series: MySQL Shortcuts
description: ''
title: Patch-Day18-mysql的常用语句收集(2)
tags: [sql语句,Patch,MySQL]
---

今天继续说一下Mysql的查询问题~

- 如何group之后针对计数来筛选?

**A: **group是判断重复信息的一个好方法,但是当库很大时,group之后的数据如果不能筛选就没有意义了...于是having在这个时候就非常有价值了~它可以针对group之后的数据进行,总数,总计数等等方面加以筛选~

{% highlight mysql %}

SELECT country_code, COUNT(*)
FROM orders_header
GROUP BY country_code
HAVING COUNT(*) = 1

{% endhighlight %}

- 如何复制一个表的结构?

**A: **很多时候我们会需要复制一个表的结构,这个时候就会用到like这个语法,可以在create的时候直接创建一个和现有表结构完全一致的表;

{% highlight mysql %}

create table new_table like table_name;

{% endhighlight %}


除此之外,还有两种变通的方法,一种是通过完全复制表但是导入0数据,如下:

{% highlight mysql %}

create table new_table select * from table_name limit 0;

{% endhighlight %}

另一种则是通过先打印出当前表的创建语句,然后复制一下:

{% highlight mysql %}

show create table table_name\G;
## 显示出当前表的sql语句;然后复制修改表名直接创建新表;

{% endhighlight %}

- 如何复制一个表的数据和结构?

**A: **如上所说,可以通过第二种方法来完全复制一个表:

{% highlight mysql %}

create table new_table select * from table_name;
## 没有limit的限制,从而将所有的数据都导入;

{% endhighlight %}

这也是最常见的一中方法, 同时你还可以通过where从句来限制复制的数据类型和筛选规则;
而针对特殊情况下的表, 比如已存在的表,且不能删除,那么可以用insert into的方式,同样加以select * from old_table来复制数据~一样支持数据where筛选.

- 如何导出数据到文件以及如何恢复?

**A: **很多时候我们需要把表数据甚至是数据库都导出到文件,然后可能会在另一个地方再导入重新生成对应的表,数据库再次使用,于是需要用到mysqldump以及source.

{% highlight mysql %}

shell>> mysqldump [options] db_name [tbl_name ...]
## 记得是在shell中运行,而不是在mysql中运行此命令;如果是导出数据库,那么就不要填写任何表名即可;
## 也可以使用如下命令导出全库:
mysqldump [options] --databases db_name ...
mysqldump [options] --all-databases

{% endhighlight %}

需要注意的就是上述的命令都没有指定输出文件,如果需要输出到文件则需要加上"> filename"来指定;
同样的,如果是从文件中恢复数据,有两种方法,第一是进入mysql之中,用source的方法来直接从文件之中恢复,还有种方法是通过命令行下:

{% highlight mysql %}

shell>> mysql -h hostname -u user --password=password databasename < filename
#或者使用:
mysql>> source file;

{% endhighlight %}

如上,今天关于mysql的整理到此结束~祝好,晚安~

