---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: 关于sublime出现decode error错误
tags: [python,sublime,Patch]
---

本篇本来想合并在之前的patch里, 后来觉得还是单开的了~ 毕竟这个问题还是比较典型的~

因为python3之后才把默认编码类型改成了utf-8, 所以3以前经常会出现各种的编码问题...烦不胜烦..

在使用sublime来编译python的时候, 经常会出现decode error的错误, 提示"[Decode error - output not utf-8]"~

通过google, 在sublime的官方论坛上看到了一个非常便捷的解决方案:

修改 Packages/Python/Python.sublime-build 这一文件, 在最后加上encoding的参数:


{% highlight python %}

{
   "cmd": ["python", "-u", "$file"],
   "file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)",
   "selector": "source.python",
   "encoding": "utf-8"
}

{% endhighlight %}


<del datetime="2014-01-16T11:29:26+00:00">简单吧~哈哈</del>

后续又出现了一堆类似的错误但是完全无法解决了...我用繁杂无比的decode,encode都无法解决....FK!
