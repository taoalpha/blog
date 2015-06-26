---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day24-python中datetime格式转换
tags: [python,日期格式,Patch,strptime,datetime]
---

在使用python抓取或者解析页面时,经常会遇到日期的问题,因为页面信息中的时间信息是非常不确定的,比较好运的情况下会是比较规则的可以直接拿来用的时间格式,但绝大多数情况下都是需要转换才能使用的格式,比如:
<ul>
	<li>November 12, 2013</li>
	<li>Nov 12 2013</li>
 	<li>Tuesday Nov 12 2013</li> 
</ul>
针对这些,都需要用到datetime.strptime()的函数,来把格式转换为标准格式~于是就有了如下的格式代号表(见后)

{% highlight python %}

ll = "November 12, 2013"
print ll
print datetime.datetime.strptime(ll, '%B %d, %Y')
# 要注意后面的格式务必和原文本的格式一致,尤其是标点符号.
ll = "Tuesday Nov 12 2013"
print ll
print datetime.datetime.strptime(ll, '%A %b %d %Y')
# 对于同一个元素而言,简称和全程的符号是一致的,只是大小写不同而已

{% endhighlight %}

以下摘自<a href="http://docs.python.org/2/library/datetime.html" target="_blank">python的datetime官方文档</a>:
<table border="1" class="docutils">
<colgroup>
<col width="15%">
<col width="43%">
<col width="32%">
<col width="9%">
</colgroup>
<thead valign="bottom">
<tr><th class="head">Directive</th>
<th class="head">Meaning</th>
<th class="head">Example</th>
<th class="head">Notes</th>
</tr>
</thead>
<tbody valign="top">
<tr><td><tt class="docutils literal"><span class="pre">%a</span></tt></td>
<td>Weekday as locale’s
abbreviated name.</td>
<td><div class="first last line-block">
<div class="line">Sun, Mon, ..., Sat
(en_US);</div>
<div class="line">So, Mo, ..., Sa
(de_DE)</div>
</div>
</td>
<td>(1)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%A</span></tt></td>
<td>Weekday as locale’s full name.</td>
<td><div class="first last line-block">
<div class="line">Sunday, Monday, ...,
Saturday (en_US);</div>
<div class="line">Sonntag, Montag, ...,
Samstag (de_DE)</div>
</div>
</td>
<td>(1)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%w</span></tt></td>
<td>Weekday as a decimal number,
where 0 is Sunday and 6 is
Saturday.</td>
<td>0, 1, ..., 6</td>
<td>&nbsp;</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%d</span></tt></td>
<td>Day of the month as a
zero-padded decimal number.</td>
<td>01, 02, ..., 31</td>
<td>&nbsp;</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%b</span></tt></td>
<td>Month as locale’s abbreviated
name.</td>
<td><div class="first last line-block">
<div class="line">Jan, Feb, ..., Dec
(en_US);</div>
<div class="line">Jan, Feb, ..., Dez
(de_DE)</div>
</div>
</td>
<td>(1)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%B</span></tt></td>
<td>Month as locale’s full name.</td>
<td><div class="first last line-block">
<div class="line">January, February,
..., December (en_US);</div>
<div class="line">Januar, Februar, ...,
Dezember (de_DE)</div>
</div>
</td>
<td>(1)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%m</span></tt></td>
<td>Month as a zero-padded
decimal number.</td>
<td>01, 02, ..., 12</td>
<td>&nbsp;</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%y</span></tt></td>
<td>Year without century as a
zero-padded decimal number.</td>
<td>00, 01, ..., 99</td>
<td>&nbsp;</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%Y</span></tt></td>
<td>Year with century as a decimal
number.</td>
<td>1970, 1988, 2001, 2013</td>
<td>&nbsp;</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%H</span></tt></td>
<td>Hour (24-hour clock) as a
zero-padded decimal number.</td>
<td>00, 01, ..., 23</td>
<td>&nbsp;</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%I</span></tt></td>
<td>Hour (12-hour clock) as a
zero-padded decimal number.</td>
<td>01, 02, ..., 12</td>
<td>&nbsp;</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%p</span></tt></td>
<td>Locale’s equivalent of either
AM or PM.</td>
<td><div class="first last line-block">
<div class="line">AM, PM (en_US);</div>
<div class="line">am, pm (de_DE)</div>
</div>
</td>
<td>(1),
(2)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%M</span></tt></td>
<td>Minute as a zero-padded
decimal number.</td>
<td>00, 01, ..., 59</td>
<td>&nbsp;</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%S</span></tt></td>
<td>Second as a zero-padded
decimal number.</td>
<td>00, 01, ..., 59</td>
<td>(3)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%f</span></tt></td>
<td>Microsecond as a decimal
number, zero-padded on the
left.</td>
<td>000000, 000001, ...,
999999</td>
<td>(4)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%z</span></tt></td>
<td>UTC offset in the form +HHMM
or -HHMM (empty string if the
the object is naive).</td>
<td>(empty), +0000, -0400,
+1030</td>
<td>(5)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%Z</span></tt></td>
<td>Time zone name (empty string
if the object is naive).</td>
<td>(empty), UTC, EST, CST</td>
<td>&nbsp;</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%j</span></tt></td>
<td>Day of the year as a
zero-padded decimal number.</td>
<td>001, 002, ..., 366</td>
<td>&nbsp;</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%U</span></tt></td>
<td>Week number of the year
(Sunday as the first day of
the week) as a zero padded
decimal number. All days in a
new year preceding the first
Sunday are considered to be in
week 0.</td>
<td>00, 01, ..., 53</td>
<td>(6)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%W</span></tt></td>
<td>Week number of the year
(Monday as the first day of
the week) as a decimal number.
All days in a new year
preceding the first Monday
are considered to be in
week 0.</td>
<td>00, 01, ..., 53</td>
<td>(6)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%c</span></tt></td>
<td>Locale’s appropriate date and
time representation.</td>
<td><div class="first last line-block">
<div class="line">Tue Aug 16 21:30:00
1988 (en_US);</div>
<div class="line">Di 16 Aug 21:30:00
1988 (de_DE)</div>
</div>
</td>
<td>(1)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%x</span></tt></td>
<td>Locale’s appropriate date
representation.</td>
<td><div class="first last line-block">
<div class="line">08/16/88 (None);</div>
<div class="line">08/16/1988 (en_US);</div>
<div class="line">16.08.1988 (de_DE)</div>
</div>
</td>
<td>(1)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%X</span></tt></td>
<td>Locale’s appropriate time
representation.</td>
<td><div class="first last line-block">
<div class="line">21:30:00 (en_US);</div>
<div class="line">21:30:00 (de_DE)</div>
</div>
</td>
<td>(1)</td>
</tr>
<tr><td><tt class="docutils literal"><span class="pre">%%</span></tt></td>
<td>A literal <tt class="docutils literal"><span class="pre">'%'</span></tt> character.</td>
<td>%</td>
<td>&nbsp;</td>
</tr>
</tbody>
</table>
<ol class="arabic">
<li><p class="first">Because the format depends on the current locale, care should be taken when
making assumptions about the output value. Field orderings will vary (for
example, “month/day/year” versus “day/month/year”), and the output may
contain Unicode characters encoded using the locale’s default encoding (for
example, if the current locale is <tt class="docutils literal"><span class="pre">ja_JP</span></tt>, the default encoding could be
any one of <tt class="docutils literal"><span class="pre">eucJP</span></tt>, <tt class="docutils literal"><span class="pre">SJIS</span></tt>, or <tt class="docutils literal"><span class="pre">utf-8</span></tt>; use <a class="reference internal" href="locale.html#locale.getlocale" title="locale.getlocale"><tt class="xref py py-meth docutils literal"><span class="pre">locale.getlocale()</span></tt></a>
to determine the current locale’s encoding).</p>
</li>
<li><p class="first">When used with the <tt class="xref py py-meth docutils literal"><span class="pre">strptime()</span></tt> method, the <tt class="docutils literal"><span class="pre">%p</span></tt> directive only affects
the output hour field if the <tt class="docutils literal"><span class="pre">%I</span></tt> directive is used to parse the hour.</p>
</li>
<li><p class="first">Unlike the <a class="reference internal" href="time.html#module-time" title="time: Time access and conversions."><tt class="xref py py-mod docutils literal"><span class="pre">time</span></tt></a> module, the <a class="reference internal" href="#module-datetime" title="datetime: Basic date and time types."><tt class="xref py py-mod docutils literal"><span class="pre">datetime</span></tt></a> module does not support
leap seconds.</p>
</li>
<li><p class="first"><tt class="docutils literal"><span class="pre">%f</span></tt> is an extension to the set of format characters in the C standard
(but implemented separately in datetime objects, and therefore always
available).  When used with the <tt class="xref py py-meth docutils literal"><span class="pre">strptime()</span></tt> method, the <tt class="docutils literal"><span class="pre">%f</span></tt>
directive accepts from one to six digits and zero pads on the right.</p>
<p class="versionadded">
<span class="versionmodified">New in version 2.6.</span></p>
</li>
<li><p class="first">For a naive object, the <tt class="docutils literal"><span class="pre">%z</span></tt> and <tt class="docutils literal"><span class="pre">%Z</span></tt> format codes are replaced by empty
strings.</p>
<p>For an aware object:</p>
<dl class="docutils">
<dt><tt class="docutils literal"><span class="pre">%z</span></tt></dt>
<dd><p class="first last"><tt class="xref py py-meth docutils literal"><span class="pre">utcoffset()</span></tt> is transformed into a 5-character string of the form
+HHMM or -HHMM, where HH is a 2-digit string giving the number of UTC
offset hours, and MM is a 2-digit string giving the number of UTC offset
minutes.  For example, if <tt class="xref py py-meth docutils literal"><span class="pre">utcoffset()</span></tt> returns
<tt class="docutils literal"><span class="pre">timedelta(hours=-3,</span> <span class="pre">minutes=-30)</span></tt>, <tt class="docutils literal"><span class="pre">%z</span></tt> is replaced with the string
<tt class="docutils literal"><span class="pre">'-0330'</span></tt>.</p>
</dd>
<dt><tt class="docutils literal"><span class="pre">%Z</span></tt></dt>
<dd><p class="first last">If <tt class="xref py py-meth docutils literal"><span class="pre">tzname()</span></tt> returns <tt class="xref docutils literal"><span class="pre">None</span></tt>, <tt class="docutils literal"><span class="pre">%Z</span></tt> is replaced by an empty
string.  Otherwise <tt class="docutils literal"><span class="pre">%Z</span></tt> is replaced by the returned value, which must
be a string.</p>
</dd>
</dl>
</li>
<li><p class="first">When used with the <tt class="xref py py-meth docutils literal"><span class="pre">strptime()</span></tt> method, <tt class="docutils literal"><span class="pre">%U</span></tt> and <tt class="docutils literal"><span class="pre">%W</span></tt> are only used
in calculations when the day of the week and the year are specified.</p>
</li>
</ol>

