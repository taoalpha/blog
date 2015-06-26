---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day23-python抓取遇到的access denied
tags: [python,headers,access denied,访问受限,Patch]
---

为了dailyinfo的数据库能实时更新以及扩大,所以总共选取了6个infographic的站点进行抓取~其中就遇到了一个站对于直接抓取会报错,所有的请求都会直接转到access denied的提示页面上,因为很久之前遇到过类似的问题,所以猜测应该是headers的问题,在google的过程也发现有类似问题,说到了user-agent的原因: <a href="https://github.com/mrkipling/maraschino/pull/320" target="_blank">here!</a>(正好遇到的就是CloudFlare error 1010的错误,也是首次听说了这个服务,貌似很牛逼啊~)

回归正题, 于是将urllib库替换为urllib2,因为前者不支持设置headers...直接上代码吧:

{% highlight python %}

user_agent = "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1588.0 Safari/537.36"
headers = { 'User-Agent' : user_agent }
# 我用的是从F12中获取的我自己的chrome浏览器自己的user-agent~
req = urllib2.Request(url=url,headers=headers)
html = urllib2.urlopen(req).read()
# 请求的时候指定将headers传给headers,url传给url的参数就可以了

{% endhighlight %}

如此就可以正常的访问获取网站数据了~
