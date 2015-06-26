---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day37-jquery学习笔记1
tags: [jquery,coding,Patch]
---

这几天写novelfeed主要是对jquery有了一些更进一步的了解, 同时看tuts的教程也学到了不少的新东西~ 正好整理一下:

<ul>
    <li>jQuery中节点元素的判断
        <p>js中很多事件的触发和针对对象是一致的, 但是也有很多是不一致的, 这种情况下就需要通过当前的节点去查找目标节点, 在这一部分主要涉及到以下的几个function:
            <ul>
                <li>母节点(parent, parents, closest):
                    <p>其中parent表示直系的母元素, 血缘关系不超过一代, 而parents则可以追溯到祖宗十八代~ 而closest比较像parents, 但是只会追溯到最近的一个符合条件的目标~

{% highlight javascript %}

    <!-- html结构 -->
    <div>
        <div>
            <ul>
                <li>ss
                    <p><span>asdasd</span></p>
                </li>
            </ul>
        </div>
    </div>
    <!-- jquery -->
    $('span').parent();
    <!-- ==> [<p><span>asdasd</span></p>] -->
    $('span').parents();
    <!-- ==>[<p><span>asdasd</span></p>,<li>ss<p><span>asdasd</span></p></li>,<ul><li>ss<p><span>asdasd</span></p></li></ul>,<div><ul>...</ul></div>,<div><div>...</div></div>] -->
    $('span').closest('div');
    <!-- ==> [<div><ul>...</ul></div>] -->

{% endhighlight %}

                    </p>
                </li>
                <li>子节点(children, find)
                    <p>children即为直系子弟, 止于一代; 而find则是向下的无穷代, 有多少就可以找多少.

{% highlight javascript %}

    <!-- html结构 -->
    <div>
        <ul>
            <li>ss
                <p><span>asdasd</span></p>
            </li>
            <li>
                <p>sss</p>
            </li>
        </ul>
    </div>
    <!-- jquery -->
    $('ul').children();
    <!-- ==> [<li><p><span>...</span></p></li>,<li><p>...</p></li>] -->
    $('span').find('span');
    <!-- ==>[<span>asdasd</span>] -->

{% endhighlight %}

                    </p>
                </li>
                <li>兄弟节点(siblings, next,prev)
                    <p>
                        其中siblings就代表了除本身外同级别的各节点, next则表示紧接着的下一个节点, prev则是上一个~

{% highlight javascript %}

    <!-- html结构 -->
    <div>
        <span></span>
        <span></span>
        <p></p>
    </div>
     <!-- jquery -->
    $('span:nth-child(1)').siblings();
    <!-- ==>[<span></span>,<p></p>] -->
    $('span:nth-child(1)').next();
    <!-- ==>[<p></p>] -->
    $('span:nth-child(1)').prev();
    <!-- ==>[<span></span>] -->

{% endhighlight %}

                    </p>
                </li>
            </ul>
        </p>
    </li>
    <li>jQuery中clone函数的几点注意.
        <p>jQuery的clone()函数其实是非常好用的, 结合appendTo()函数就可以完整的按照节点复制html代码块~ 但是有几点需要注意~
        <ul>
            <li>clone(true)保留绑定事件
                <p>在使用过程中, 细心的人可能会发现对于clone()来的元素, 其绑定事件会丢失...比如本身元素绑定了click事件($('div').click(function(){});), 这个时候可以用clone(true)来保留事件的绑定; 当然对应的false参数就代表了只需要clone样式;</p>
            </li>
            <li>on函数保留clone事件
                <p>通过on函数替换click函数, 也可以让clone元素保留事件, 当然严格来说不是保留而是实时的重新绑定了~

{% highlight javascript %}

    $('yourelement').on('click','target element(option)',function(){});

{% endhighlight %}

                如此即便在clone的时候没有设置true也是可以的~
                </p>
            </li>
        </ul>
        </p>
    </li>
    <li>jQuery中end()函数来返回初始节点.
        <p>这个功能很有用, 不多说, 直接看例子:

{% highlight javascript %}

    $('div').on('click',function(){
        $(this).children('ul')
            .css('display','none')
            .end()
            .hide()
    });
    这里面第一个css的display:none是设置在了div元素的直系子元素ul上的, 而通过end(), 当前的object又回到了最初的div元素, 所以最后的hide()就是针对div而言的了~

{% endhighlight %}

        </p>
    </li>
</ul>


