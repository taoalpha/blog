---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day38-jquery之事件绑定-补充
tags: [jquery,事件绑定,coding,Patch]
---

在之前37的时候有说过一些关于jQuery中event绑定的问题, 但是后来实际使用过程中, 发现还有很多问题~ 虽然之前说的也不能完全算错, 但是确实有一些地方有不小的漏洞~

针对事件绑定而言, 除了clone函数会接受true,false参数来直接表明本身复制的时候携带不携带函数以外, 我们通常还会用到append, prepend等函数来直接添加htnl片段, 这种情况下也会经常出现类似的问题, 就是新增的html函数片段对原有函数的不继承.

如下:

{% highlight javascript %}

//html part
<!-- <div class="container">
    <div class="box">
        <p>Example</p>
        <span class="close">X</span>
    </div>
</div> -->

// jQuery part

$('.container').append("<div class=box><p>Example</p><span class=close></span>X</div>");
$('span.close').on('click',function(){
    alert("ss");
})

{% endhighlight %}

上述例子中, 原有的span中X点击会触发alert函数, 但是通过append添加的后者就不会触发.

那么, 如何做呢?

其实也很简单, 可以利用on函数本身的参数来实现, 因为on函数接受多个参数, 其中很重要的一个就是指定的目标, 比如:

{% highlight javascript %}

$('span.close').on('click','xx',function(){
    alert("ss");
})

{% endhighlight %}

即代表span.close下的xx元素被点击的时候要触发后续动作~ 那么, 是不是只要修改最开始的代码为如下形式就行了呢?

{% highlight javascript %}

// jQuery part

$('.container').append("<div class=box><p>Example</p><span class=close></span>X</div>");
$('.box').on('click','span.close',function(){
    alert("ss");
})

{% endhighlight %}

不行, 为什么? 很简单, 因为box也是你添加的, 这个时候初始选择器一定要指定一个原本已存在的的元素, 如此才能每次都把事件绑定到旗下所有元素中~

{% highlight javascript %}

// jQuery part

$('.container').append("<div class=box><p>Example</p><span class=close></span>X</div>");
$('.container').on('click','span.close',function(){
    alert("ss");
})

{% endhighlight %}

如上就行了, 当然, 如果你本身就是向根元素append子节点, 可以直接用 body ~ 也是没问题的~
