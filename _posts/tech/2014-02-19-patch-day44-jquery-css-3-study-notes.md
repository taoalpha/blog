---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day44–jQuery&CSS学习笔记3
tags: [jquery,CSS,Patch]
---

嗯, 本来计划publish了allfeed之后就暂时告一段落这部分~ 没想到又出了一些逻辑的bug, 另外有个设计师朋友也愿意帮我优化一下界面~ 所以就断断续续又更新了两个版本~ 具体细节之后单独来介绍~ 这里主要是总结一下这几天的jQuery部分~

<ul>
    <li>jQuery干预css的几种方式
        <ul>
            <li>效果类函数
                <p>类似hide(),show(),slideDown()等, 其实内部核心都是注入css, 比如hide和show就是注入display项~ 对于希望实现最基础的效果和逻辑来说完全足够;</p>
            </li>
            <li>css的直接注入
                <p>这算是更进一步, 因为可以通过css()直接灌入任何css的属性, 用{"name","value"}的这种key-value方式来赋值即可;</p>
            </li>
            <li>对class等操作来间接修改
                <p>这是另一种方式, 就是通过jquery对class等的操作, 来实现对应元素的css的变化, 而这种情况有很多个好处:
                        <ol>
                            <li>首先, js中对css的干扰很少, css部分基本都存在于css文件之中, 整体逻辑清楚;</li>
                            <li>其次, 对于css而言, 修改和调整也会很方便, 且容易成体系, 用多class的方式, 更容易让css代码复用;</li>
                            <li>最后, 消除css起来也容易, 因为前两种的方式对于css的灌入都是属于element style级别的, 基本上除非消除这部分的css或者用其他的important等方式才能去除或者覆盖掉, 像hide(), 一旦出现, 那么当前元素就会被设置到display:none的属性, 而且不会随着hide()的结束而结束, 这个时候如果想要恢复就一定要对这一元素设置display:block或者其他才行, 但是class的方式就会容易很多, 因为只需要addClass或者removeClass就行, 更简单, toggleClass也行~</li>
                        </ol>
                        个人比较喜欢这种方式~ 也推荐大家使用这种方式~
                </p>
            </li>
            <li>居中的几种实现方式
                <p>这里按照类型来区分一下:</p>
                <ul>
                    <li>文本的居中
                        <p>文本的居中最为简单, 无论是垂直还是水平~
                            <ol>
                                <li>水平: text-align:center; 即可, 因为是现成的属性, 直接用在母元素上就行;</li>
                                <li>垂直: 通过设置line-height等于当前元素的height就可以实现;</li>
                            </ol>
                            当然两种居中都有很多方式, 这里就不一一列举了, 就再只介绍一种:
                            vertical-align:middle; 这个属性是存在的, 但是不能直接拿来用, 为什么呢? 因为这个属性针对的对象不是inline的, 需要设置当前的text元素的母元素为table-cell才行, 即要结合 display:table-cell;

{% highlight javascript %}

.hori{
    text-align:center;
}
.vert1{
    height:30px;
    line-height:30px;
}
.vert2{
    display:table-cell;
    vertical-align:middle;
}
-----html----
<div class="hori">asd</div>
<div class="vert1">asdasd</div>
<div class="vert2">
    <p>sad</p>
</div>

{% endhighlight %}

                        </p>
                    </li>
                    <li>block元素的居中
                        <p>
                            <ol>
                                <li>水平: margin-left:auto; margin-right:auto; 这两个auto的设定就能让浏览器自动把这一block元素居中了, 因为始终会保持左右的margin相等~</li>
                                <li>垂直: position:relative; top:50%;这是一个显而易见的方法, 只需要设置母元素的position不是static就可以了~</li>
                            </ol>
                            同样, 块级垂直的居中也不只一种, 比如上面说过的table-cell结合vertical-align也是一种很有效的方式, 在display可以重新定义元素的类型的情况下,这些方法都是可以互通的;
                            舍此之外, 还有种方法可以同时横向竖向居中, 同样也是利用position的方式:

{% highlight javascript %}

.Absolute-Center {
  margin: auto;
  position: absolute;
  top: 0; left: 0; bottom: 0; right: 0;
}

{% endhighlight %}

                        </p>
                    </li>
                </ul>
            </li>
        </ul>
    </li>
    <li>jQuery中进行Oauth验证的方法:
        <p>这部分其实挺简单, 因为多数Oauth的核心就是获取到access token, 所以一旦获取到access token之后就能通过post来获取api的入门钥匙了:
            以delicious为例, 首先需要在delicious上注册, 并建立一个app, 获取到appid, 然后通过post请求, 向验证接口发送请求来获取对应的access token, 一旦拿到access token后就可以同样利用post来使用api接口了~
        </p>
    </li>
</ul>

本来应该还有一些, 但是确实想不起来了~ 嗯, 这次给allfeed增加了collection的部分, 以后就可以收藏那些google到的优质结果了~ 也方便自己总结~哈
