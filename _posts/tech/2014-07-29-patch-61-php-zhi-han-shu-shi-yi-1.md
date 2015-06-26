---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-61-php之函数拾遗(1)
tags: [coding,Patch,explode,implode,array,php]
---

php的function很多, 有很多非常有用的函数值得推荐~ 我会在以后把遇到的有趣的函数分成多个一组, 每组一文的形式记录分享给大家~

今天是第一篇, 主要说一下addslashes, array_map, implode, explode, array_unique几个函数~

<ul>
	<li>
		<h3>addslashes</h3>
		<p>经常要用php向mysql传数据的同学应该都遇到过很多符号转义的问题, 最开始我是沿用了python和js中的的方法, 用replace来做简单的转义替换, 后来发现php有专门的函数来做这个, 就是addslashes(), 通过addslashes()可以将string中的单引号, 双引号, 反斜杠(/)以及NUL符号(空值);
		
{% highlight python %}

		<?php
		$str = "Is your name O'reilly?";

		// Outputs: Is your name O\'reilly?
		echo addslashes($str);
		?>
		// Is your name O\'reilly?
		
{% endhighlight %}

		</p>
		<p>有没有更好的方法呢? 其实php还有几个函数, 是针对几个主流的DB的, 比如mysqli的real_escape_string(),针对的符号有:NUL (ASCII 0), \n, \r, \, ', ", 和 Control-Z; 再比如针对postgreSQL的pg_escape_literal()或者pg_escape_string()也有同样的效果;</p>
	</li>
	<li>
		<h3>array_map</h3>
		<p>这是一个非常优质的函数, 在你想要针对一个array的每个元素都做某种处理时, 就可以使用这个函数了~ 用法也简单, array_map ( callable $callback , array $array1), 定义好自己的函数, 然后就能获得一个处理后的新数组了~</p>
	</li>
	<li>
		<h3>implode 和 explode</h3>
		<p>我们经常会遇到数组到string或者string到数组的情况, 而implode和explode就是为此而出现的~ 
		
{% highlight python %}

			<?php
				$array = array('lastname', 'email', 'phone');
				$comma_separated = implode(",", $array);

				echo $comma_separated; 
				// lastname,email,phone

				// Empty string when using an empty array:
				var_dump(implode('hello', array())); // string(0) ""

				// Example 1
				$pizza  = "piece1 piece2 piece3 piece4 piece5 piece6";
				$pieces = explode(" ", $pizza);
				echo $pieces[0]; // piece1
				echo $pieces[1]; // piece2
				?>
		
{% endhighlight %}

		如此直观的例子我就不多说神马了~
		</p>
	</li>
	<li>
		<h3>array_unique</h3>
		<p>还记得写python的时候知道了set()后瞬间觉得list的去重都弱爆了有木有!! php中也有非常完美的函数, array_unique(), 名字也非常清楚的传达了函数的功能~ 直接传入要去重的数组即可~</p>
	</li>
</ul>

哈哈, 函数本身可能没啥特别的, 或者惊喜之处, 记录这些主要是为了记录一些比较频繁会用到的php函数, 以防以后查询还有个地儿可查~
