---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day35-xpath以及python的beautifulsoup
tags: [bs4,python,beautifulsoup,xpath,Patch]
---

好久不说python了~ ^_^

今天主要说两方面的内容,  一是简单说下最近初步学习xpath的心得~ 还有就是关于最新的BeautifulSoup的一些流弊之处！

<ul>
    <li>xpath:
        xpath的语法规则很简单, 很实用, 而且非常高效, 在解析html或者xml上都有着非常广泛的应用~ 更是W3C推荐使用的~ 其规则符号如下：
    </li>
  </ul>
<a href="http://callmet.zzgary.info/wp-content/uploads/2014/01/xpath.png"><img src="http://callmet.zzgary.info/wp-content/uploads/2014/01/xpath.png" alt="xpath syntax" width="840" height="735" class="size-full wp-image-1180" /></a>
  使用方法是： axisname::nodetest[predicate]
<ul>
    <li>接着主要说说BS4：
        因为目前最新版的BS4已经改版的非常强大了, 所以我就直接介绍一下Bs4了~ 而且今天说的也是解析,  所以也就主要说一下bs4的find_all()函数：
        <strong>Signature: find_all(name, attrs, recursive, text, limit, **kwargs)</strong>
        从原有的findAll到新的find_all, 不只是名字发生了改变, 其功能更是有了大幅度的提升, 不记得以前是不是支持css的解析, 但是现在是支持了, 而且函数中name参数支持的类型有了极大的提升和丰富：string, list, re(正则), 函数!, bool判断~
        分别举例如下:
        
{% highlight python %}

            // soup = bs4.BeautifulSoup(html)
            // name域
            soup.find_all("a", class_="sister")
            soup.find_all(id='link2')
            soup.find_all(href=re.compile("elsie"))
            soup.find_all(id=True)
            soup.find_all(href=re.compile("elsie"), id='link1')
            data_soup.find_all(data-foo="value")
            soup.find_all(class_=re.compile("itl"))
            '''
            def has_six_characters():
                // defined your function
            '''
            soup.find_all(class_=has_six_characters)
            css_soup.find_all("p", class_="body strikeout")
            //支持这种精确查找~ 这一点很赞, 因为在以前的版本中是不支持的!

            //更流弊的是:text域
            soup.find_all(text="Elsie")
            soup.find_all(text=["Tillie", "Elsie", "Lacie"])
            soup.find_all(text=re.compile("Dormouse"))
            def is_the_only_string_within_a_tag(s):
                //define the function
            soup.find_all(text=is_the_only_string_within_a_tag)
            //你可以匹配text而不是tag了!!!

            //limit域
            soup.find_all("a", limit=2)
            //限制返回结果数目;

            //recursive域
            soup.mytag.find_all("title")
            //限定在mytag下匹配,但是会递归查找mytag下的所有子元素, 而如果设置recursive=false, 就会只查找直接子元素;
            soup.html.find_all("title", recursive=False)
        
{% endhighlight %}

        震惊吧! 至少我在看到的时候着实惊了一把! 这让bs一下变得实用起来, 远超之前的实用啊!更遑论还有那么多的find_parent(),find_next_siblings()等等实用的函数在!

        同时, bs3默认的parser是SGMLParser, 但这个库在python3.0中取消了, bs4修改为了html.parser~ 当然也可以更换为lxml或者html5lib~ 这个根据自己的熟悉程度选择即可~
        三者的区别如下:
    </li>
  </ul>
<a href="http://callmet.zzgary.info/wp-content/uploads/2014/01/bs4-parser.png"><img src="http://callmet.zzgary.info/wp-content/uploads/2014/01/bs4-parser-1024x370.png" alt="bs4-parser对比" width="680" height="245" class="size-large wp-image-1181" /></a>
