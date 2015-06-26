---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day46-php拾遗一
tags: [php,coding,Patch]
---

这是第二次正式的接触php, 之前那些针对wordpress模版的小打小闹都算不上...上次还是在做<a href="http://zzgary.info/wordquotes/" target="_blank">wordquotes</a>的时候简单用到了php来查询和接收对应word的quotes...这一次也主要是和mysql的交互, 但相比上次多了很多php本身的应用, 着实收获不少, 下面就简单总结一下:

<ul>
    <li>urlencode来处理url中的中文
        <p>这也是在处理allfeed中search跨域请求的时候遇到的, 因为做了中转, 希望由server上的php来作为中转站对两个feed搜索引擎发请求, 但是测试中发现会出现中文搜索词返回空结果, 而实际上我直接用中文作为query在浏览器中访问的时候是可以看到结果的...这里就需要用urlencode对中文进行处理, 将中文转为url中接受的类型: 比如中国--\u4E2D\u56FD(js传递)--%E4%B8%AD%E5%9B%BD(urlencode转换).</p>
    </li>
    <li>mysql中的concat和ifnull
        <p>这一次因为php的原因对mysql也有了不少新的认识, concat和ifnull就是两个非常典型的~ 一个是用来合并数据的, 一个是判断是否为空的, 因为在allfeed的数据库中, feed和user表的联系就是通过最初的原始输入来链接的, 而原始输入会通过分号链接存储在一个字段之中, 这就需要每次更新的时候将新的值衔接在尾巴后面, 如此就需要用concat了~ 而针对当前为空的值和不为空的值添加方式如果不同的话, 就需要用ifnull函数来判断一下,ifnull($name,'or sth else') ~</p>
    </li>
    <li>php中的explode
        <p>同样是因为分号链接的原因, 我需要通过分号作为分隔符来将string打散成数组, 如此一来就需要用到explode函数, explode(';',$string)--而如果要针对获得的array进行去重, 就可以用array_unique()来实现了~</p>
    </li>
    <li>php中对html和xml的数据请求
        <p>在php中有很多种获取html或者xml数据的方式, 无论是dom, 还是curl以及最简单的file_get_contents()都是可行的办法, 本次因为设计到html和xml两个格式, 所以就分别用了dom的loadHTMLFile和file_get_contents两个函数, 而后又利用simpleXMLElement处理了xml的数据, 用DomXpath来处理html部分~</p>
    </li>
    <li>php的strpos
        <p>php中如何判断string的包含呢? 就可以用strpos函数, 顾名思义, 是获取stringA在stringB的位置的, 本次主要用在判断小说章节名上了~</p>
    </li>
    <li>php和mysql
        <p>本次php中的绝大部分代码都是用于和mysql交互之中了... 所以也是好好的温习以及学习了一下这部分的知识~ 和其他所有语言都一样, 首先需要链接mysql, 然后就是sql语句的执行以及对结果的处理了, 针对mysql的执行结果, php也可以指定获取格式, 比如mysql_fetch_array和mysql_fetch_row以及mysql_fetch_object, 这些大家试一下就知道了~ 其他的也就没啥区别了~ 一般来说, 拿到array来处理还是最为方便的~</p>
    </li>
    <li>php的global
        <p>和很多语言一样, php中也是可以申明全局变量的, 只需要在前面加上global就行, 尤其是在函数中, 如果不想用传参来实现, 就可以用global, 这样就不用在函数调用的时候传递那么多的参数了;~</p>
    </li>
    <li>php的var_dump和echo
        <p>php中存在几种输出方式, 主要是var_dump和echo, 其中echo最为简单, 而习惯shell的人也比较熟悉, 对于string等类型, 这个是最为简单的~ 而对于array和object的输出, 单纯的echo就不行了, 会导致输出array或者object的, 就需要用到var_dump来完整的输出数据的结构和内容;</p>
    </li>
</ul>
如上, 下次再见~
