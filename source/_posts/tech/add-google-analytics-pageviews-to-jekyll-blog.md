date: 2015-06-07 6:00:00
title: 如何给 Jekyll 博文添加阅读数显示 
category: tech 
description: 继续折腾Jekyll, 这次我们来给blog的文章列表页增加 Google Analytics 统计的pageview 数据.
tags: [jekyll,Google Analytics,pageview,GAE] 
series: Playing with Google Analytics
author: taoalpha
---

## 缘起

受[羡辙杂俎](http://zhangwenli.com/blog/)启发, 看到她的页面上有着pageviews的显示, 于是就果断看了下对应的代码, 发现是从google的appspot下拿到的json数据, 于是就开始Google了以下GA的api, 然后就看到了这个[superProxy](https://developers.google.com/analytics/solutions/google-analytics-super-proxy), 下面的事情就非常顺理成章了~

## 无插件实现方法

亦如之前, 我们还是从无插件方法说起, 大体思路为:

- 通过Google App Engine搭建superProxy, 开启其GA权限;
- 设置对应查询query以及更新频率;
- 获取json结果生成地址;
- 通过js请求获取json数据, 解析展现;
- 加入本地pageview文件备份容错;

那我们一步步来:

### 在GAP上创建App

- 首先, 你需要一个Google帐号... 哈哈(恩.. 更前提的是你能够[科学上网](http://www.jianshu.com/collection/b6b16295fc83));
- 接下来, 在[App Engine Administration Console](https://appengine.google.com)上创建app, 因为主要用来放置superProxy, 所以名字上随便起, 基本也没什么直接访问的可能;
- 在[Services pane](https://code.google.com/apis/console/#:services)中开启Google Analytics的权限, 搜索到GA然后enable即可;
- 在[API Access pane](https://code.google.com/apis/console/#:access)中创建一个OAuth验证, 如果你有多个app, 选择用来放superProxy的那个, 其中`Authorized Redirect URIs`中填写上"http://your-app-id.appspot.com/admin/auth", 如果你需要本地测试的话, 也加上"http://localhost:8080/admin/auth"即可, 如此创建后即可获得一个Client ID和Secret Key了;

### 安装superProxy

- 首先你需要安装GAE的SDK, 用python版本即可, 所以请确保环境中有python 2.7以上~ [Python - GAE SDK](https://developers.google.com/appengine/downloads#Google_App_Engine_SDK_for_Python);
- 在[Google Analytics superProxy - Github](https://github.com/googleanalytics/google-analytics-super-proxy)上download整个源代码, 你直接`clone`以下就行;
- 修改`src`路径下`app.yaml`文件, 将对应的your-app-id填入: `application: your-application-id`;
- 还是在`src`中, 修改`config.py`, 将上一环节生成的`OAUTH_CLIENT_ID`, `OAUTH_CLIENT_SECRET`, 以及对应的`OAUTH_REDIRECT_URI`都填入进去(如果本地测试的话, 就用localhost的那个);
- 安装下载好的GAE SDK, 再提示安装命令行工具的时候选择`安装`;
- 在`src`路径下, 使用`appcfg.py`命令将我们的代码发布到GAE上, 如果你要本地测试, 请用`dev_appserver.py`;

### 设置Query以及更新频率并获取json地址

- 在我们成功deploy我们的superProxy后, 就可以通过`http://your-app-id.appspot.com`来访问了, 不过第一步请先访问`https://your-app-id.appspot.com/admin`, 登录授权完成验证;
- 成功验证后你就能看到一个有着"Google Analytics superProxy"大标题的页面啦, 点击`Create Query`即创建你的Query了, 当然, 这里直接填写的就是query, 如果你不知道如何写, 可以在[Google Analytics Query Explorer](http://ga-dev-tools.appspot.com/explorer/)中进行测试, 然后复制贴回来就行;
- 创建后会提示你设定更新的频率, 视情况设定即可, 然后你就可以看到对应的`formats`里面看到支持的众多输出格式了, 默认的公共地址就是json的, 获取其他格式也是利用`&format=`, 所以这里我们使用公共地址即可;

###并添加本地获取代码

恩, 说了半天都没说到jekyll呢哈哈, 因为需要向appspot发请求获取数据, 所以这里肯定就使用js了~ 代码如下:

``` javascript

// Load pageview counts from Google Analytics
function getPageViewCount(dataurl){
  if (dataurl === undefined) {
    dataurl = 'https://taoalpha-github-page.appspot.com/query?id=ahZzfnRhb2FscGhhLWdpdGh1Yi1wYWdlchULEghBcGlRdWVyeRiAgICAgICACgw'
  }
  // 防止我们有时候需要更换url, 这里给了一个url作为参数, 不过默认给了当前的;
  $.ajax({
    url: dataurl,
    dataType: 'jsonp',
    timeout: 1000 * 3, // 3 sec
    success: function(data) {
      parsePageViewData(data.rows);
      // 解析数据部分, 见下
    },
    error: function() {
      // 容错环节, 如果失败的话, 就获取本地数据, 这个数据基本每次push的时候会更新一次~ 写到Rakefile里哈
      console.log('Failed to get pageview from GAE!');
        $.ajax({
          url: '/blog/pageview.json',
          dataType: 'json',
          success: function(data) {
            console.log('Local page view backup file.');
            parsePageViewData(data.rows);
          }
        })
      }
  })
}
```

### 解析json数据,展示pv数据

解析部分主要要结合获取的数据来写, 因为我们url的使用有时候不够规范, 所以会出现不同条目同一url的现象, 所以这里需要做简单的统一.

``` javascript
function parsePageViewData(rows){
  if (rows === undefined) {
    return;
  }
  $('.post').each(function() {
    // 遍历我们的文章列表
    var myPath = $(this).children('h2').children('a').attr('href');
    // 获取我们文章页的url
    if (myPath) {
      //myPath = myPath.slice('http://taoalpha.github.io'.length);
      // 这里根据具体情况, 如果你的href中包含了baseurl的话, 这里要记得去掉baseurl;
      var pageview = 0;
      for (var i = 0; i < rows.length; ++i) {
        var gPath = rows[i][0];
        var hashIndex = gPath.indexOf('#');
        var gPathFilter = hashIndex > -1 ? gPath.slice(0,hashIndex) : gPath;
        // 因为当前post有哥大纲, 所以会出现#menuID2的尾缀, 这种也需要合并到该博文的统计中
        // 暂时没涉及到文章详情页的阅读数展示, 所以这里可以先这么处理着哈哈
        if (gPath === myPath || myPath === mainPath + 'index.html' || gPathFilter === myPath) {
            pageview += parseInt(rows[i][1]);
        }
      }
      if (pageview){
        // 只对有pv数据的博文显示阅读书, 虽然目前有数据也基本是我点的哈哈哈
        $(this).find('span.viewcount').html('<i class="fa fa-eye"></i>'+pageview);
      }
    }
  });
}
```


如上, 只需要在对应的页面调用`getPageViewCount()`即可~ 效果可见[blog首页](/blog)

## Jekyll-GA插件

不用插件虽然也能解决, 不过如果有现成插件的话, 自然能够事半功倍嘛~ 在Github上一搜就找到了: [developmentseed/jekyll-ga - Github](https://github.com/developmentseed/jekyll-ga)~ 

看了下, 发现原理其实差不多, 不过与其创建app间接获取GA数据, 这个插件直接使用了`google-api-client`这个ruby插件从而直接在插件层面获取数据了~ 具体的方法等, `readme`里面也都写的很详细, 大家可以按部就班使用喽~


## 参考资料

- [Google Analytics superProxy](https://developers.google.com/analytics/solutions/google-analytics-super-proxy) 
- [Google Analytics superProxy - Github](https://github.com/googleanalytics/google-analytics-super-proxy)
- [A plugin for loading Google Analytics data into Jekyll](http://developmentseed.org/blog/google-analytics-jekyll-plugin/)
- [Pageview from Google Analytics for Your Blog](http://zhangwenli.com/blog/2014/08/05/page-view-from-google-analytics-for-your-blog/)

说了也有趣, 我是从[WenLi](http://zhangwenli.com/blog)代码中获取的灵感, 然后google折腾出的解决方案, 结果写到一半就发现她也有一篇相近的博文哈哈
