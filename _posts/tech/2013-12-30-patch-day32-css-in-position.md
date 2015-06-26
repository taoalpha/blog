---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day32-CSS中的Position
tags: [position,CSS,Patch]
---

在CSS里有一个属性是至关重要的, 就是position, 对于布局而言, 没有position的话, 你就无法做出灵活的布局变化, 对于HTML而言也就失去了非常多的乐趣~ 更何况, 对于实现一个现有的设计而言也就增加了无数难度~ 所以, 今天乘着需要设计新页面所以针对Position就重新认识了一遍, 也算真的了解了一下, 而不是以前那样自以为的使用了...

首先从position的value来说起: position有五个value值: static, absolute, relative, fixed, inherit.

<ul>
  	<li><strong>static:</strong>
      作为默认属性值, 它的含义和命名是非常一致的, 没有任何可变的地方, 此种情况top/left/right/bottom/z-index都对此元素无效. 只能通过margin以及padding来调整期布局, 同时相互之间的影响也是非常固定的, 不会存在忽略的情况;
  </li>
	<li><strong>absolute:</strong>
  	  绝对定位, 一旦此元素赋值absolute的话, 此元素就会跳出整体文档布局; 而根据父元素的整体位置来确定自己的位置, 此时其位置就可以利用top/left/right/bottom来调整了;
  </li>
	<li><strong>relative:</strong>
      相对定位, 顾名思义, 这是相对于绝对定位而言的, 此种情况下, top/left/right/bottom/z-index都是有效的, 但是与absolute区别的一点就是此时元素并不完全脱离文档流, 其位置只是相对于static下的原始位置而言;  
  </li>
	<li><strong>fixed:</strong>
      fixed和absolute比较像, 一旦定义就会脱离文档流, 但是不同的是, fixed会始终停留在当前文档流定位的地方, 即不随滚动而有所变化, absolute则不是.  
  </li>
	<li><strong>inherit:</strong>
      因为position本身是不支持继承属性的, 所以通过inherit就可以让position从父元素中继承;  
  </li>
</ul>
上述算是非常准确的定义, 但是只看文字的定义来说确实不直观, 所以下面直接用代码示例下:
<div style="margin:10px 10px 10px 10px;width: 80%;height:30px;background-color:gray;color:white;">
		<div style="margin:5px 10px 10px 10px;width: 40%;height:20px;background-color:black;">position:static</div>
	</div>
	<div style="margin:10px 10px 10px 10px;width: 80%;height:30px;background-color:gray;color:white;">
		<div style="margin:5px 10px 10px 10px;width: 40%;height:20px;background-color:black; position:relative;">position:relative-no-top/left</div>
	</div>
	<div style="margin:10px 10px 10px 10px;width: 80%;height:30px;background-color:gray;color:white;">
		<div style="margin:5px 10px 10px 10px;width: 40%;height:20px;background-color:black; position:relative;top:10px;left:20px;">position:relative+top/left</div>
	</div>
	<div style="margin:10px;width:80%;height:50px;border:1px solid;position:relative;">
	<div style="margin:10px 10px 10px 10px;width: 80%;height:30px;background-color:gray;color:white;">
		<div style="margin:5px 10px 10px 10px;width: 40%;height:20px;background-color:pink; position:absolute;">position:absolute-no-top/right..)</div>
	</div>
      </div>
	<div style="margin:10px;width:80%;height:50px;border:1px solid;position:relative;">
	<div style="margin:10px 10px 10px 10px;width: 80%;height:30px;background-color:gray;color:white;">
		<div style="margin:5px 10px 10px 10px;width: 40%;height:20px;background-color:pink; position:absolute;right:0px;">position:absolute+right</div>
	</div>
      </div>
	<div>fixed,as you have already see it float on the page...</div>
		<div style="color:white;margin:5px 10px 10px 10px;width: 40%;height:20px;background-color:black;position:fixed;top:200px;">position:fixed+top(200px)--just for demonstration...</div>

以上就是对应position下的example~

PS. 在使用absolute的时候会发现div跳出当前文档流后并不是直接使用parent元素的width来计算百分比的width, 而是按照屏幕的宽度(本例中)来计算了~ 这里一定要注意~ 如果需要让div元素按照母元素的width来作为参考基准, 就需要在母元素上加入position:relative来限制, 所以其实div此时是寻找最近的一个position不是static的母元素来参考~ (之所以用relative是因为relative和static最为接近, 不会影响到整体文档的结构~)

而fixed则不会有此规则, fixed完全按照当前页面来定位, 不会受到母元素position的影响;

主要参考资料:

<a href="http://css-tricks.com/almanac/properties/p/position/" target="_blank">CSS-trick: The Positioning!</a>

<a href="http://www.barelyfitz.com/screencast/html-training/css/positioning/" target="_blank">10 steps learn position(虽然有些过时, 没有fixed..但总的来说还是挺不错的~尤其是各种position的结合讲解和示例不错~)</a>

