---
layout: post
title: 给你的 Jekyll 博客添加日志汇总展示页面
category: tech
description: Goaccess 是一个非常简单而有齐全的日志分析工具, 其生成的html页面非常精细全面, 可以让你更好的查看日志, 今天就利用上次获取PV的方法来介绍下如何给 Jekyll 添加一个类似goaccess的日志页面.
tags: [Google Analytics,log] 
series: Playing with Google Analytics
author: taoalpha
---

## 简介

[Goaccess](http://goaccess.io) 是一个非常简单而有齐全的日志分析工具, 其[生成的html页面](http://goaccess.io/goaccess_html_report.html?201507052200)非常精细全面, 可以让你更好的查看日志, 今天就利用上次获取PV的方法来介绍下如何给 Jekyll 添加一个类似goaccess的日志页面.

## 准备工作

如果你了解[ google-analytics-super-proxy ](https://github.com/googleanalytics/google-analytics-super-proxy) 或者你看过我之前写的[如何给jekyll博文添加阅读数]({{ site.baseurl }} {% post_url tech/2015-06-07-add-google-analytics-pageviews-to-jekyll-blog %}), 那么你就可以进行下面的准备工作了, 如果没有的话, 请先阅读相关内容后再继续 ^_^

- 在[GA Query Explorer](https://ga-dev-tools.appspot.com/query-explorer)中测试构建你需要的Query API, 比如我根据Goaccess的日志内容和GA本身的统计情况选取了: `ga:fullReferrer`,`ga:browser`,`ga:operatingSystem`,`ga:country`,`ga:pagePath`作为我的dimensions, 然后将`ga:pageviews`和`ga:uniquePageviews`作为我的metrics, 而且因为之前测试没有关闭ga, 所以存在一些干扰数据, 可以通过filters中设置`ga:hostname!~127*`来过滤掉;
- 在我们建立好的GAE上添加一个新的Query, 并设定其更新频率;

## 解析和展示

### 获取json

这一步和[如何给jekyll博文添加阅读数]({{ site.baseurl }} {% post_url tech/2015-06-07-add-google-analytics-pageviews-to-jekyll-blog %})基本一样, 区别的就在于我们这次不是直接处理`responseData.rows`了, 我们直接把`responseData`传给解析函数, 因为我们需要除了rows以外的一些属性.

### 解析展示

主要的目的是模拟Goaccess的形式展示访客在浏览器, refer, 国家, 系统以及访问页面几个纬度的分布情况; 主要思路就是通过解析返回的数据, 然后根据各个纬度的属性将对应的pv,uv加以统计后展示出来即可.

js解析部分的代码如下(展示部分我主要参照了goaccess自身的样式设计, 这里就直接略过了~ 有兴趣的可以[点此查看效果]({{site.baseurl}}/galog/)):

{% highlight coffeescript %}
@parseGALog = (data) ->
  overalldata = {}
  overalldata.tpv = data["totalsForAllResults"]["ga:pageviews"]
  overalldata.tuv = data["totalsForAllResults"]["ga:uniquePageviews"]
  overalldata.datasize = parseFloat(JSON.stringify(data).length/16/1024).toFixed(2)
  overalldata.referer = []
  overalldata['404'] = 0

  requestdata = {}
  refererdata = {}
  osdata = {}
  browserdata = {}
  countrydata = {}

  temp_data = data.rows
  $.each temp_data,(k,v) ->
    overalldata.referer.push(v[0]) if v[0] not in overalldata.referer
    overalldata['404'] += parseInt(v[7]) if v[5] == "/blog/404"

    if !requestdata[v[5]]
      requestdata[v[5]] = {}
      requestdata[v[5]]["pv"] = parseInt(v[7])
      requestdata[v[5]]["uv"] = parseInt v[8]
    else
      requestdata[v[5]]["pv"] += parseInt v[7]
      requestdata[v[5]]["uv"] += parseInt v[8]

    if !countrydata[v[3]]
      countrydata[v[3]] = {}
      countrydata[v[3]]["pv"] = parseInt v[7]
      countrydata[v[3]]["uv"] = parseInt v[8]
    else
      countrydata[v[3]]["pv"] += parseInt v[7]
      countrydata[v[3]]["uv"] += parseInt v[8]

    if !refererdata[v[0]]
      refererdata[v[0]] = {}
      refererdata[v[0]]["pv"] = parseInt v[7]
      refererdata[v[0]]["uv"] = parseInt v[8]
    else
      refererdata[v[0]]["pv"] += parseInt v[7]
      refererdata[v[0]]["uv"] += parseInt v[8]

    if !osdata[v[2]]
      osdata[v[2]] = {}
      osdata[v[2]]["pv"] = parseInt v[7]
      osdata[v[2]]["uv"] = parseInt v[8]
    else
      osdata[v[2]]["pv"] += parseInt v[7]
      osdata[v[2]]["uv"] += parseInt v[8]

    if !browserdata[v[1]]
      browserdata[v[1]] = {}
      browserdata[v[1]]["pv"] = parseInt v[7]
      browserdata[v[1]]["uv"] = parseInt v[8]
    else
      browserdata[v[1]]["pv"] += parseInt v[7]
      browserdata[v[1]]["uv"] += parseInt v[8]

  # render overall part
  $('li.overall').find('summary').html "<ul><li><span class='itemname'><i class='fa fa-bar-chart'></i>total pageviews</span> <span class='count'>#{overalldata.tpv}</span></li><li><span class='itemname'><i class='fa fa-bar-chart'></i>total unique visitors</span> <span class='count'>#{overalldata.tuv}</span></li><li><span class='itemname'><i class='fa fa-bar-chart'></i>referrers</span> <span class='count'>#{overalldata.referer.length}</span></li><li><span class='itemname'><i class='fa fa-bar-chart'></i>total 404</span> <span class='count'>#{overalldata['404']}</span></li><li><span class='itemname'><i class='fa fa-bar-chart'></i>log size</span> <span class='count'>#{overalldata.datasize}kb</span></li><li><span class='itemname'><i class='fa fa-bar-chart'></i>log source</span> <span class='count'>ga</span></li></ul>"

  showLogData(requestdata,parseInt(overalldata.tpv),parseInt(overalldata.tuv),'Path')
  showLogData(refererdata,parseInt(overalldata.tpv),parseInt(overalldata.tuv),'Referer')
  showLogData(osdata,parseInt(overalldata.tpv),parseInt(overalldata.tuv),'OS')
  showLogData(browserdata,parseInt(overalldata.tpv),parseInt(overalldata.tuv),'Browser')
  showLogData(countrydata,parseInt(overalldata.tpv),parseInt(overalldata.tuv),'Country')

@showLogData = (rq,ptotal,utotal,id) ->
  thead = "<tr><th>PageViews</th><th>%</th><th>Unique PageViews</th><th>%</th><th class=''>__title__<span onclick='if($(this).hasClass('expanded')){$(this).removeClass('expanded').closest('thead').next('tbody').find('tr:nth-of-type(n+10)').hide();}else{$(this).addClass('expanded').closest('thead').next('tbody').find('tr').show()}'><i class='fa fa-expand'></i></span></th></tr>"
  tbodyitem = "<tr class='root'><td class='num'>__value_1__</td><td>__value_2__</td><td class='num'>__value_3__</td><td>__value_4__</td><td>__value_5__</td></tr>"
  tbody = ''

  $.each rq, (k,v) ->
    tbody += tbodyitem.replace('__value_1__',v['pv']).replace('__value_2__',(v['pv']/ptotal*100).toFixed(2)).replace('__value_3__',v['uv']).replace('__value_4__',(v['uv']/utotal*100).toFixed(2)).replace('__value_5__',k)

  $('li.'+id).find('thead').html thead.replace('__title__',id)
  $('li.'+id).find('tbody').html tbody

{% endhighlight %}

## 总结

可能有人会说既然数据都是从GA获取的, 干嘛不直接去GA查看不就得了.. 何必多此一举呢?

恩... 其实确实是如此的... 只是一来我是熟悉下GA的接口和工具, 做出来练练手; 二来呢, 也是这样可以更好的聚合我想要看的数据, 方便我个人定制~ (当然, GA本身也有定制report并发送邮箱的功能~)
