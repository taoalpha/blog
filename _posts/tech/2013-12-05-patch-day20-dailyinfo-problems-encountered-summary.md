---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day20-Dailyinfo所遇问题总结
tags: [jquery,Patch,js]
---

花了不少时间...终于算是全部搭起来了~<del datetime="2013-12-07T01:23:36+00:00">目前除了search的请求还没有做完以及search完的页面还不确定如何进行之外, 就只剩下编辑框的制作了~还有一些小细节的修正就不计算了~</del>
[DailyInfo](http://zzgary.info/djangoblog/dailyinfo/)
基本算是完成了,search会发给同样的页面,只是替换内容为search后的结果数据~编辑框比较糙...准备进一步隐藏作为option的功能来提供~
search有个隐藏的shortkey哈~ctrl~本来想搞双ctrl...不过考虑到我一直对数字公司的xxxxx,我就不直接抄袭了...^_^

整个过程遇到无数的问题啊.....主要是jquery的...

所以就记录一下,以方便以后查看备忘~

- 如何把数字转为string?
**A: **简单啊, 其实是js的内置函数,toString()就可以了~比如:

{% highlight javascript %}

kk = 8;
tt = kk.toString();
>> string, "8"

{% endhighlight %}

- 如何阻止元素原有的回车事件?
**A: **因为希望设定回车直接搜索, 所以原本的回车换行事件就需要被替换掉~而通过jquery来实现这一点会非常容易~

{% highlight javascript %}

$('yourtextarea').keydown(function(e) {
	if(e.which== 13) {
		e.preventDefault();
    }
});

{% endhighlight %}

- 如何阻止母元素的点击或者hover事件?
**A: **同样是因为浮层,因为涉及到点击其他地方后会触发隐藏的事件,但是编辑框部分的点击是正常的,所以,就需要在编辑区域的点击不触发母框架的点击事件~其实和上面的阻止事件发生的方式基本一致;

{% highlight javascript %}

$('yourarea').click(function(e){
	e.stopPropagation();
});

{% endhighlight %}
</li>

-  如何获取接收get到的数据?
**A: **我使用array的方式重新push成一个数组,然后再针对数组调用,比较麻烦, 没有找到很好的方法~

{% highlight javascript %}
{% raw %}

var tarray = [];
var uarray = [];
{% for t,j in results %}
	tarray.push("{{t|escape}}");
	uarray.push("{{j|escape}}");
{%endfor%}
# 这样就把传回的结果存储到tarray,uarray的数组之中了

{% endraw %}
{% endhighlight %}

  如果有更好的方法,求赐教啊!!!

- 如何利用jquery来修改或者获得常见的属性呢?
**  A: **这得分几块来说~
  
	- css,这个最为常用,也最简单:

{% highlight javascript %}

$('your_target').css('width',wd-10);
# 针对对应的属性,采用"property",value的方式赋值就行, 如果是同时赋值多个属性,就需要用{}的形式来同时赋值:
# 支持多种形式,可以直接传一个字典进去也行~
var styles = {
backgroundColor : "#ddd",
fontWeight: ""
};
$( 'your_target' ).css( styles );
#当然也可以直接把styles的内容写进去~

{% endhighlight %}

针对width数值型的value,也是支持用计算公式的,比如+=,-=如此来递增递减,本次用zoom的时候就使用了这个方法~省了不少事~
基本上,针对样式的修改都可以使用.css()的函数来实现~  </li>

	- html,这个也很常用,而且很简单,就是把一个节点下的东西都替换为html()中的东西~

{% highlight javascript %}

$( "#xxxx" ).html();
// 这是获得id=xxxx的这个tag的html文本;
$( "#xxxx" ).html( "<p>All new content. <em>You bet!</em></p>" );
// 如此,就会把id=xxxx的tag下的html全部变为后面的内容,以xxxx是div为例:
<div id=xxxx>
<p>All new content. <em>You bet!</em></p>
</div>
{% endhighlight %}

  - val以及attr,这两个主要是为了获取一些特殊的属性使用,其中val就是获取比如input,textarea,option等这些本身就有value属性的value值,而attr则主要是获取处在tag之中那些属性,比如a标签的href,img的src,title,alt等等~ 

{% highlight javascript %}

<img id="greatphoto" src="brush-seller.jpg" alt="brush seller">
$( "#greatphoto" ).attr( "alt", "Beijing Brush Seller" );
// 如上就是典型的attr常见用法,直接从jquey的doc上截取的例子~
// 也是支持多个值的:
$( "#greatphoto" ).attr({
  alt: "Beijing Brush Seller",
  title: "photo by Kelly Clark"
});
<input type="text" value="some text" id="ss">
$( "#ss" ).val();
// 就可以获得input的value值了~

{% endhighlight %}

- 响应式初探~
**  A: **很糙啊~哈,核心东西是几个常量值的获取以及resize的调用~~

{% highlight javascript %}
 
var wd = $(window).width();
var hh = $(document).height();
// 同法可以获得对应的宽高;

{% endhighlight %}

  接下来就是如何针对resize函数调节不同的布局了~有兴趣的可以去dailyinfo页面自行了解~代码都在html里了~</li>

断断续续弄了几天,目前算是把dailyinfo的页面完善了下,整个逻辑也都打通了,目前基本不影响使用了~欢迎鼓掌~哈哈
