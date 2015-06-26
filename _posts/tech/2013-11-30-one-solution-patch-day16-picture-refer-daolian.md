---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day16-图片refer盗链的一种解决办法
tags: [Refer盗链,Patch]
---

同样还是infographic的小项目,在展示图片的时候发现本来好好的图片全部都变成盗链图片了...这...怎么可以...奇怪的是如果直接在浏览器中去打开这个图片链接的话,又是正常的...

google了很久,有很多说法,不过首先可以确认的是这应该是对方站点或者图片存储的服务器设置了refer的防盗链~

如何解决呢? 我是采用了iframe的方式来转嫁refer,因为iframe嵌套可以重置refer,而绝大多数的图片存储服务器都会为了能够在直接浏览器中打开图片而设置了空refer是可以接受的,所以这种方式就比较可行了~

{% highlight python %}

<script> 
	window.sc="<img style='max-height:1000px;width:auto;' src='{{ j }}'>";
</script>
<iframe style="border:0px;overflow:hidden;width:4;height:8;display:none;" src="javascript:parent.sc"></iframe>

{% endhighlight %}

如此你就会发现你请求到的图片是没有refer的~这样，你的图片就可以正常的显示了~不过如此做似乎在ie下是不可行的。。。看上去全是一溜叉号...

以下还有几个google的方法,不过因为时间关系尚没有验证~大家也可以拿来参考下~

{% highlight python %}

function showImg( url ) {
        var frameid = 'frameimg' + Math.random();
        window.img = '<img id="img" src=\''+url+'?'+Math.random()+'\' /><script>window.onload = function() { parent.document.getElementById(\''+frameid+'\').height = document.getElementById(\'img\').height+\'px\'; }<'+'/script>';
        document.write('<iframe id="'+frameid+'" src="javascript:parent.img;" frameBorder="0" scrolling="no" width="100%"></iframe>');
}
<!-- 调用方法:-->
showImg('图片地址');

{% endhighlight %}


目前来说,基本算是解决了盗链的问题~在webkit下~因为本工具是比较私人化使用的,所以也就没打算再怎么细化了~能使唤就行~
有兴趣的童鞋可以用chrome访问:http://zzgary.info/djangoblog/dailyinfo/ (随机推荐)
或者: http://zzgary.info/djangoblog/dailyinfo/search/ (搜索)

祝好~晚安~
