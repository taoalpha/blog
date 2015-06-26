---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day43--jQuery学习笔记2
tags: [jquery,json,Patch]
---

从Allfeed进入1.4.0之后, 一直没有做太大的修改, 这两天看到一个RSS Feed Reader的插件...那叫做的一个好啊...太羞愧了...于是在感受了一下人家强大的功能之后, 我就再次针对allfeed做了一次新的修改, 具体的会在之后单独介绍~ 这篇主要说一下期间用到的一些jquery的技巧~

<ul>
    <li>JSON的合并
        <p>对于多个json数据, 如果想要合并的话, 有什么好方法呢? jquery有个简单的方法: $.extend()
            
{% highlight javascript %}

                a = {
                "abc":"def"
                }
                b ={
                "ghi":"jkl"
                }
                c = $.extend(a,b);
                ==>
                // c = {"abc":"def","ghi":"jkl"}
            
{% endhighlight %}

        </p>
    </li>
    <li>JSON单项的删除
        <p>这个不是jquery的, js本来就带有这个功能:
            
{% highlight javascript %}

                c = {"abc":"def","ghi":"jkl"}
                delete(c["abc"])
                ==>
                // b ={"ghi":"jkl"}
            
{% endhighlight %}

        </p>
    </li>
    <li>鼠标中键事件的绑定
        <p>喜欢新标签页打开的童鞋肯定知道鼠标中键的点击会自动新开页打开, 而且是后台打开~ 但是这样也造成了一个比较恶心的问题, 就是click时间不识别中键, 那么如何让中键的点击也触发click事件呢? 可以用mouseenter
            
{% highlight javascript %}

            $('div#content').on('mousedown','a',function(e){
            if((e.which == 1) || (e.which == 2)){
                // 1,2 分别是左键和中键, 3即代表了右键.
                // your code here
            }
            
{% endhighlight %}

        </p>
    </li>
    <li>html如何delay
        <p>用jQuery的童鞋都知道delay, 也经常会用到, 经常接着fadeIn(), fadeOut(), slideDown(), slideUp()等等, 但是如果接着html()这种函数, 就会发现delay()失效了, 那如何做呢? 可以用queue() 来间接实现.
            
{% highlight javascript %}

                $('div').delay(2000).slideUp().delay(2000).html("阿三大四的").slideDown(800)
                // 这种情况下, 你会发现html的变化会立刻发生, 而没有任何停顿.
                $('div').delay(2000).slideUp().delay(2000)
                    .queue(function(n){
                        $(this).html("asdasd");
                        n();
                        }).slideDown(800)
                // 通过queue就可以让html一定在slideup之后再等待2000才会执行, 然后再执行slideDown()
                // n()这里代表的是进入下一对列, 如果没有n(), 此处是无法实现的;
            
{% endhighlight %}

        </p>
    </li>
</ul>
其他的有些想不起来了... 带补充吧~~

