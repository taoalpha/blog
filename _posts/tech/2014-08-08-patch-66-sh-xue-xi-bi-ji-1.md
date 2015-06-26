---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-66-sh学习笔记(1)
tags: [shell,coding,Patch]
---

最近在研究从github上<a href="https://github.com/addyosmani/dotfiles" title="addyosmani 的dotfiles" target="_blank">addyosmani</a>那里fork来的一个dotfiles,主要是用来初始化新机器的, 利用shell定制了很多命令, 如此就可以快速的部署新机的环境, 让自己更有效率的工作. 以及一些比较实用的shell文件, 比如dropbox uploader等等~ 于是博主瞬间对shell有了更多的喜爱... 准备研究研究, 做个自己的~~ 本系列会主要总结shell的命令, 是博主学习过程中的总结~ 


<ul>
	<li>如何检查文件的读写等权限以及类型?
		<p>很多时候, 我们需要用sh来读写文件, 此种情况为了避免一些错误, 我们需要先check一下文件的读写权限是否开放了, 或者预先判断下文件的类型, 下例就是shell中如何检查文件权限和类型的例子:
		
{% highlight python %}

#!/bin/sh
file="your file name with path"
# read permission
if [ -r $file ]
then
   echo "File has read access"
else
   echo "File does not have read access"
fi
# write permission
[ -w $file ]

# execute permission
[ -x $file ]

# ordinary file type
[ -f $file ]

# directory check
[ -d $file ]

# file size check -- true means zero.
[ -s $file ]

# file exist check
[ -e $file ]
		
{% endhighlight %}

		</p>
	</li>
	<li>比较运算符
		<p>我们经常需要比对一些类型的变量, 比如数字大小比较, 字符串长度和有效性判断等等, 都需要用到比较运算符.
		
{% highlight python %}

#!/bin/sh
# interger comparison

# equal 
-eq || if [ "$a" -eq "$b" ]
# not equal
-ne || if [ "$a" -ne "$b" ]
# greater than
-gt || if [ "$a" -gt "$b" ]
# greater than or equal to
-ge || if [ "$a" -ge "$b" ]
# less than
-lt || if [ "$a" -lt "$b" ]
# less than or equal to 
-le || if [ "$a" -le "$b" ]
# less than 
< || (("$a" < "$b"))
# less than or equal to 
<= || (("$a" <= "$b"))
# greater than
> || (("$a" > "$b"))
# greater than or equal to
>= || (("$a" >= "$b"))

# string Comparison

# equal 
= || if [ "$a" = "$b" ]
# not equal
!= || if [ "$a" != "$b" ]
# greater than
> || if [[ "$a" > "$b" ]] || if [ "$a" \> "$b" ]
# less than
< || if [[ "$a" < "$b" ]] || if [ "$a" \< "$b" ]

// above compare with ASCII alphabetical order

# string is null has zero length
-z || [ -z "$String" ]
# string is not null
-n || [ -n "$String" ]


#compound comparison

# logic and
-a || exp1 -a exp2
# logic or
-o || exp1 -o exp2 

{% endhighlight %}

		</p>
	</li>
</ul>

先就这些吧... 这几天搞一个gitbookreader的app, 所以sh这边暂时就先不理会啦~ 之前的dotfiles我也已经定制了一下, 希望有机会实施一下哈~~
