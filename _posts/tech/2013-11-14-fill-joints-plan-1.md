---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch计划-1-chardet以及matplotlib的几个问题
tags: [python,编码,chardet,matplotlib,Patch]
---

基于每天大量的Google, 而这些google得到的答案却在时间流逝中默默消失...甚是遗憾啊..故列一计划以记录这些成衣过程中的各个补丁, 名之:Patch计划.

Day 1 === 2013-11-14 === <a title="Matplotlib项目地址" href="http://matplotlib.org/" target="_blank">matplotlib</a>以及<a title="Chardet-项目所在" href="https://github.com/erikrose/chardet" target="_blank">chardet</a>
<ol>
	<li> 因为需要今天从Mysql数据库中抽取了不少数据, 结果发现print出来很多编码错误, 于是找到了chardet的工具, chardet有一个很好的功能函数为detect,可以用来探测对象的编码类型,用法为:

{% highlight python %}
import chardet
chardet.detect(待测变量)['encoding']
{% endhighlight %}

其实chardet.detect返回的是一个dict对象,里面有两个键值, 一个即encoding, 另一个则是confidence,代表了其探测的精度, 实际上也确实存在不准的可能~
关于chardet支持detect的编码类型大家可以去chardet的<a title="Chardet-项目所在" href="https://github.com/erikrose/chardet" target="_blank">官方地址</a>查看.
而在获取到encoding的方式后, 就可以利用().encoding("你探测到的编码方式").decode("utf-8")的方式转换编码类型到unicode了~</li>
	<li>同样是在处理从数据库中获得的数据, 第一次接触了<a href="http://matplotlib.org/" target="_blank">matplotlib</a>, 用的是pie_char的范例函数, 只是修改了其中labels和fragcs, 把它们作为参数传递, 另外类型都调整为list而不是原本的tuple(此种变化可直接进行, 不需要特殊处理);在处理过程中主要遇到的问题就是在redhat的环境下怎么也无法输出包含中文的图片...每次中文都会变为方块...可见是编码有误..通过google等各种方法, 最后试验许久找到的解决方案如下:
<ul>
<ul>
	<li>首先需要确保你的系统中有中文字体, 可以通过font_manager来探测一下:

{% highlight python %}
import matplotlib.font_manager as fm
fm.findSystemFonts()
{% endhighlight %}

如上会输出系统包含的字体, 如果其中有中文字体那么就可以进行下一步了, 如果没有的话, 则需要安装一下字体:

{% highlight python %}
# shell
cp 你的字体 /usr/share/fonts/你要放置的文件夹下
cd /usr/share/fonts/新字体所在
mkfontscale
mkfontdir
chkfontpath --add /usr/share/fonts/字体所在
service xfs reload #重载
{% endhighlight %}

以上完成后可以通过之前的findSystemFonts来验证下是否添加成功~~<a title="Ubuntu-Font_install" href="http://www.wikihow.com/Install-TrueType-Fonts-on-Ubuntu" target="_blank">Ubuntu下字体的添加方式可移步这里</a></li>
	<li>以上ok后,可以复制fm.findSystemFonts得到的字体地址记录下来,并通过font_manager来获取对饮字体的名称, 从而通过rcParams函数来修改~

{% highlight python %}
import matplotlib as mpl
import matplotlib.pyplot as plt
path = '/usr/share/fonts/truetype/msttcorefonts/Comic_Sans_MS.ttf' # 你的字体所在路径
prop = font_manager.FontProperties(fname=path)
mpl.rcParams['font.family'] = prop.get_name()
{% endhighlight %}

这是动态的解决方案, 也有静态的解决方案, 更适合一步到位, 就是去修改matplotlibrc这个配置文件,把里面的font_family和默认的字体中添加你要加入的中文字体~可查看matplotlib的官网有关customizing font的一节.</li>
	<li><strong>如果这里你遇到了 font ['你的字体名']not find的错误, 可以清理一下matplotlib的cache试试~name: fontList.cache</strong></li>
	<li>最后, 还需要确保输出结果也是unicode~此处我在处理的时候遇到了这一问题,每次savefig都是方块, 一直发现虽然将数据都encoding.decode到utf-8了, 还是需要我在每次使用list中的某个值时依然加unicode才能转为正常~</li>
</ul>
</ul>
到这里, 如果你的问题和我的一样, 应该就差不多正常了~</li>
	<li>matplotlib需要及时清理画幕~不然会造成数据污染, 我利用for循环来生成四张png, 结果发现前面的数据会带入到下一次的plot中去, 查询发现通过在每次savefig之后用clf()清屏一下就好了~</li>
</ol>
&nbsp;

今天就到这里了~再见~
