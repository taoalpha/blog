---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day45–用CSS实现jQuery中的一些效果
tags: [CS,Patch]
---

经常用google搜索css技巧的人会发现很多css爱好者们喜欢用这样一个组合: pure css.

对, 很多人喜欢纯css去实现一些功能, 不参杂任何的js代码. 本人可以算是半个css爱好者, 所以这里就简单列举一些用纯css去实现一些原本只能用js去实现的效果~

<ul>
    <li>css禁止元素默认的事件
        <p>在js中, 只需要一个preventDefault就可以阻止当前标签的默认触发事件, 比如a标签的跳转, 那么在css中如何做到呢?

{% highlight python %}

a{
    pointer-events:none;
}

{% endhighlight %}

        很简单, 利用pointer-events的属性, 我们就可以去重新定义当前元素的一些触发事件, 从而重写元素原本的默认事件.
        </p>
    </li>
    <li>css来实现动态变化
        <p>这个范围比较大, 但核心只有一个, 就是伪类, 通过css3中的伪类, 就可以实现很多种的动态效果, 下面以hover和nth-chidl为例:

{% highlight python %}

===html===
<div>
    <ul>
        <li><a href="">asdasd</a><span>asdadsa</span></li>
        <li><a href="">asdasd</a><span>asdadsa</span></li>
        <li><a href="">asdasd</a><span>asdadsa</span></li>
        <li><a href="">asdasd</a><span>asdadsa</span></li>
    </ul>
</div>
// :hover
===css-1===
span{
    display:none;
}
a:hover + span{
    display:block;
}
// 通过:hover伪类和+选择符实现a标签hover后span标签显示的效果, 同理, 你只需要定义颜色等等就可以实现对应的变化;
// :nth-child
span{
    display:none;
}
li:nth-child(2n):hover +li span{
    display:block;
}
// 如上, 就会导致每次hover到偶数位的li元素时, 下一个里元素的span元素就会显示出来~

{% endhighlight %}

        利用多种伪类, css可以做到了很多以前只能通过js才能实现的东西~ 有兴趣可以在这里了解更多: <a href="http://css-tricks.com/pseudo-class-selectors/" target="_blank">css中的众多伪类</a></p>
    </li>
    <li>CSS自有的animations
        <p>这也是css3之后才有的一些属性, 可以在不使用js的情况下达到一些动态的效果, 比如:

{% highlight python %}

div
{
width:100px;
height:100px;
background:red;
animation:myfirst 5s;
-webkit-animation:myfirst 5s; /* Safari and Chrome */
}

@keyframes myfirst
{
from {background:red;}
to {background:yellow;}
}

@-webkit-keyframes myfirst /* Safari and Chrome */
{
from {background:red;}
to {background:yellow;}
}
// 这是一个div背景色缓变的效果~
// 除了from to之外, 你也可以用百分比来设定变化的节奏:

@-webkit-keyframes myfirst /* Safari and Chrome */
{
0%   {background:red;}
25%  {background:yellow;}
50%  {background:blue;}
100% {background:green;}
}

// 而结合位置的变化, 你就可以得到一个由纯css实现的动效了~
div
{
width:100px;
height:100px;
background:red;
position:relative;
animation-name:myfirst;
animation-duration:5s;
animation-timing-function:linear;
animation-delay:2s;
animation-iteration-count:infinite;
animation-direction:alternate;
animation-play-state:running;
/* Safari and Chrome: */
-webkit-animation-name:myfirst;
-webkit-animation-duration:5s;
-webkit-animation-timing-function:linear;
-webkit-animation-delay:2s;
-webkit-animation-iteration-count:infinite;
-webkit-animation-direction:alternate;
-webkit-animation-play-state:running;
}

@keyframes myfirst
{
0%   {background:red; left:0px; top:0px;}
25%  {background:yellow; left:200px; top:0px;}
50%  {background:blue; left:200px; top:200px;}
75%  {background:green; left:0px; top:200px;}
100% {background:red; left:0px; top:0px;}
}

@-webkit-keyframes myfirst /* Safari and Chrome */
{
0%   {background:red; left:0px; top:0px;}
25%  {background:yellow; left:200px; top:0px;}
50%  {background:blue; left:200px; top:200px;}
75%  {background:green; left:0px; top:200px;}
100% {background:red; left:0px; top:0px;}
}
// 以上直接摘自w3c的example~ 已经解释的非常清楚了~

{% endhighlight %}

        </p>
    </li>
</ul>

随着scss以及less等的尝试, css也在逐渐的开始变得越来月强大, 随着variables的引入, 想来mixin的引入也只是个时间问题了~ 而这些伪类和animations的出现, 更是给css带入了新的活力~ 可惜浏览器的问题一直是制约css的一大病因.. 却不是那么好解决的啊...

