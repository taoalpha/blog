category: read
description: ''
date: 2014-11-17 3:00:00
title: 15 essential Sass mixins 
tags: [译系列,翻译文章,coding,Sass,Mixin]
---

<h4>Source:</h4>

<ul>
<li><a href="http://www.developerdrive.com/2014/11/15-essential-sass-mixins/">原文: 15 essential Sass Mixins</a></li>
</ul>

<h3>15 个必备的Sass mixins</h3>

<p>现在有很多成套的sass mixin库, 比如我个人很喜欢的 <a href="http://bourbon.io/">Bourbon</a>和非常流行的 <a href="http://compass-style.org/">Compass</a>. 但是有时候, 实际上是多数情况下, 可能从中选一些结合自己的mixin才是最适合自己的.</p>

<p>过于依赖一个工具总是不好的, 而且如果你想让sass的mixin通过@include来调用的话, 那么你就更应该试着写写自己的mixin了~</p>

<p>sass的mixin的应用范围是非常广泛的, 而以下这15个mixin则是每个开发者都应该有的:</p>

<p><strong>box-sizing</strong></p>

<p>sass就像所有的预处理器一样, 能够很好的处理浏览器前缀的. 下面这个mixin是用于处理box-sizing这个前缀的:</p>


``` css
@mixin box-sizing($type)
 {
 -webkit-box-sizing:$type;
 -moz-box-sizing:$type;
 box-sizing:$type;
 }
</code>
```


<p>用法很简单:</p>


``` css
div{
    @include box-sizing(border-box);
}
</code>
```


<p><strong>Opacity</strong>
除了浏览器前缀之外, 还让人无比反感但又经常使用的就是透明度的问题了, 尤其是老版本的IE. 下面这个mixin则可以帮助你解决这个问题:</p>


``` css
@mixin opacity($opacity) {
    opacity: $opacity;
    filter: alpha(opacity=($opacity * 100));
 }
</code>
```


<p>用法也很简单:</p>


``` css
div {
@include opacity(0.5);
}
</code>
```


<strong>column-width</strong>
<p>这又是一个mixin处理浏览器前缀的极好例子:</p>

``` css
@mixin column-width ( $value: 150px ) {
 -webkit-column-width: $value;
  -moz-column-width: $value;
  column-width: $value;
 }
```

<p>用法很简单:</p>

``` css
div{
 @include column-width(150px);
 }
```


<strong><span>circle</span></strong>
<p>一旦你为 <em>border-radius</em>做了mixin后, 你就可以在其他的mixin中使用它了, 下例就是典型:</p>

``` css
@mixin circle
 {
 @include border-radius(100%);
 }
```

<p>用法很简单:</p>

``` css
div {
 @include circle();
 }
```


<strong>font-size</strong>
<p><span>Mixin对于边试边调是极好的, 下例的font-size的mixin就可以通过简单的修改rem来调整字体大小了, 而rem也仅会在支持它的浏览器中起作用.</span></p>

``` css
@mixin font-size($size) {
 font-size:$size;
 font-size: ($size / 16px) * 1rem;
 }
```

<p>用法很简单:</p>

``` css
div {
 @include font-size(14px);
 }
```


<strong>box-shadow</strong>
<p><span>同样还是处理浏览器前缀问题的:</span></p>

``` css
@mixin box-shadow( $h: 10px , $v: 10px , $b: 0px , $s: 0px , $c: #000000 ) {
  -webkit-box-shadow: $h $v $b $s $c;
  -moz-box-shadow: $h $v $b $s $c;
  box-shadow: $h $v $b $s $c;
}
```

<p><span>用法很简单:</span></p>

``` css
div {
 @include box-shadow(8px, 8px);
 }
```


<strong>xPos</strong>
<p><span>你还可以使用mixin来简化代码, 下面例子就是让你把元素沿横轴定位时使用:</span></p>

``` css
@mixin xPos($x){
 -webkit-transform:translateX($x);
 -moz-transform:translateX($x);
 -ms-transform:translateX($x);
 transform:translateX($x);
 }
```

<p><span>用法很简单:</span></p>

``` css
div {
 @include xPos(50px);
 }
```


<strong><span>vertical-align</span></strong>
<p><span>纵向居中一个元素是很费劲的一件事, 不过下面这个mixin则可以给你很大的帮助:</span></p>

``` css
@mixin vertical-align {
 position: relative;
 top: 50%;
 -webkit-transform: translateY(-50%);
 -ms-transform: translateY(-50%);
 transform: translateY(-50%);
 }
```

<p><span>用法很简单:</span></p>

``` css
div {
 @include vertical-align();
 }
```


<strong><span>flexbox</span></strong>
<p><span>mixin在处理类似flexbox的问题时非常有效: .</span></p>

``` css
@mixin flexbox{
 display:-webkit-box; // old
 display:-moz-box; // old
 display:-ms-flexbox; // ie
 display:-webkit-flex; // new
 display:flex; // new
 }
```

<p><span>用法很简单:</span></p>

``` css
div {
 @include flexbox();
 }
```


<strong>flex</strong>
<p><span>一旦通过mixin设定 <em>display</em> 属性为 <em>flex,</em> 那么你就也需要一个mixin来设定 <em>flex</em> 属性了:</span></p>

``` css
@mixin flex($values) {
 -webkit-box-flex: $values;
 -moz-box-flex: $values;
 -ms-flex: $values;
 -webkit-flex: $values;
 flex: $values;
 }
```

<p>用法很简单:</p>

``` css
div {
 @include flex(1, 2);
 }
```


<strong><span>flex-order</span></strong>
<p><span>再加一个设定order的:</span></p>

``` css
@mixin flex-order($order){
 -webkit-box-ordinal-group: $order; // old
 -moz-box-ordinal-group: $order; // old
 -ms-flex-order: $order; // ie
 -webkit-order: $order; // new
 order: $order; // new
 }
```

<p><span>用法很简单:</span></p>

``` css
div {
 @include flex-order(3);
 }
```


<strong><span>flex-direction</span></strong>
<p><span>mixin也是支持sass中的 <em>@if</em>, <em>@else if,</em> 以及 <em>@else</em> 等语句的, 可以用来把2个不同的mixin合并到一起:</span></p>

``` css
@mixin flex-direction($direction){
 @if $direction == column
 {
 -webkit-flex-direction:vertical;
 -moz-flex-direction:vertical;
 -ms-flex-direction:column;
 -webkit-flex-direction:column;
 flex-direction:column;
 }
 @else
 {
 -webkit-flex-direction:horizontal;
 -moz-flex-direction:horizontal;
 -ms-flex-direction:row;
 -webkit-flex-direction:row;
 flex-direction:row;
 }
 }
```

<p>用法很简单:</p>

``` css
div {
 @include flex-direction(column);
 }
```


<strong><span>gradient</span></strong>
<p><span>代码尽量要简单, 不过在必要的时候, mixin比较臃肿也是情有可原的.下面这个例子是为不同浏览器设定渐变效果的mixin, 只需要3个参数就能实现很好的渐变效果:</span></p>

``` css
@mixin gradient($start-color, $end-color, $orientation){
 background: $start-color;
 @if $orientation == vertical
 {
 // vertical
 background: -moz-linear-gradient(top, $start-color 0%, $end-color 100%);
 background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,$start-color), color-stop(100%,$end-color));
 background: -webkit-linear-gradient(top, $start-color 0%,$end-color 100%);
 background: -o-linear-gradient(top, $start-color 0%,$end-color 100%);
 background: -ms-linear-gradient(top, $start-color 0%,$end-color 100%);
 background: linear-gradient(to bottom, $start-color 0%,$end-color 100%);
 filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='$start-color', endColorstr='$end-color',GradientType=0 );
 }
 @else if $orientation == horizontal
 {
 // horizontal
 background: -moz-linear-gradient(left, $start-color 0%, $end-color 100%);
 background: -webkit-gradient(linear, left top, right top, color-stop(0%,$start-color), color-stop(100%,$end-color));
 background: -webkit-linear-gradient(left, $start-color 0%,$end-color 100%);
 background: -o-linear-gradient(left, $start-color 0%,$end-color 100%);
 background: -ms-linear-gradient(left, $start-color 0%,$end-color 100%);
 background: linear-gradient(to right, $start-color 0%,$end-color 100%);
 filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='$start-color', endColorstr='$end-color',GradientType=1 );
 }
 @else
 {
 // radial
 background: -moz-radial-gradient(center, ellipse cover, $start-color 0%, $end-color 100%);
 background: -webkit-gradient(radial, center center, 0px, center center, 100%, color-stop(0%,$start-color), color-stop(100%,$end-color));
 background: -webkit-radial-gradient(center, ellipse cover, $start-color 0%,$end-color 100%);
 background: -o-radial-gradient(center, ellipse cover, $start-color 0%,$end-color 100%);
 background: -ms-radial-gradient(center, ellipse cover, $start-color 0%,$end-color 100%);
 background: radial-gradient(ellipse at center, $start-color 0%,$end-color 100%);
 filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='$start-color', endColorstr='$end-color',GradientType=1 );
 }
 }
```

<p>用法很简单:</p>

``` css
div {
 @include gradient(#ff00ff, #ff00cc, vertical);
 }
```


<strong><span>ghost-button</span></strong>
<p><span>如果你想要紧随潮流的话, 你可以利用下面这个mixin来创建一个 <a href="http://www.developerdrive.com/2014/10/how-to-make-a-ghost-button-in-css3/">ghost button</a>, 上面的例子是我们几周前做的. 通过 <em>&amp;:hover</em> 属性可以让我们指定其hover的状态:</span></p>

``` css
@mixin ghost-button($font, $font-size, $font-color, $border-size, $border-color, $padding, $transition-speed, $hover-color){
 display:inline-block;
 text-decoration:none;
 text-transform:uppercase;
 font-family: $font;
 font-size: $font-size;
 color:$font-color;
 border:$border-size solid $border-color;
 padding:$padding;
 -webkit-transition: color $transition-speed, background $transition-speed;
 transition: color $transition-speed, background $transition-speed;
 &amp;:hover
 {
 background:$border-color;
 color:$hover-color;
 }
 }
```

<p><span>用法很简单:</span></p>

``` css
div {
 @include ghost-button(“Trebuchet”, 12px, #ffffff, 5px, #34dec6, 4px, 300ms, #000000 );
 }
```

<strong><span>break-point</span></strong>
<p><span>通过使用 </span><em>@content</em> 语句, 我们甚至可以把内容也加入include中去, 在此基础上建立断点. 当然你不应该仅仅根据设备尺寸来设定断点, 不过下面的例子中还是简单的分为了PC和手机端:</p>

``` css
@mixin break-point($point)
 {
 @if $point == desktop{
 @media only screen and (max-width:50em)
 {
 @content;
 }
 }
 @else if $point == mobile{
 @media only screen and (max-width:20em)
 {
 @content;
 }
 }
 }
```

<p>用法很简单:</p>

``` css
div {
 margin:5em;
 @include break-point(mobile)
 {
 margin:2em;
 }
 }
```

