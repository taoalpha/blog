---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day30-mediawiki垃圾信息处理总结篇
tags: [mediawiki,防垃圾,Patch]
---

好久没看wiki...只知道邮件里收到很多无法送到的提示...今天终于抽空整了一下...顿时吓了一跳...

因为wiki最初设定的就是public的, 当初主要是为了编辑的方便. 没想到会出现这么多的垃圾用户和信息...于是第一时间禁止了新用户创建和未注册用户的编辑:

{% highlight php %}

# 防止新用户注册，除非是sysops
$wgGroupPermissions['*']['createaccount'] = false;
# 未登陆用户可浏览页面
$wgGroupPermissions['*']['read']            = true;
# 未登陆用户不可浏览页面
$wgGroupPermissions['*']['read']            = false;
# 未登录用户不可编辑;
$wgGroupPermissions['*']['edit']            = false;

{% endhighlight %}

其中*代表了所有包含匿名用户在内的用户组,administrator并不在任何用户组内~ 不用担心这一点~

如此之后, 就可以开始着手处理垃圾信息了~ (上述是为了垃圾信息不再新增...因为发现垃圾信息在不断的增加..)

首先是可以通过Special:Version页面看到你自己已装的所有插件, 如果其中有Nuke, 那么你就不用再安装~否则需要去官网下载安装一下~ <a href="https://www.mediawiki.org/wiki/Extension:Nuke" target="_blank">地址在这里</a> ~

有了nuke之后就可以批量删除一些页面了~ 主要有两种匹配模式, 一种是通过用户名或者IP, 批量删除此用户或者此IP在一定时间内创建的所有页面;

还可以通过模式匹配来确定一系列的页面, 格式类似mysql语句中的like: 比如%User% 就是所有标题包含USer的页面.

筛选后就可以选择删除了~

当然这是一种办法, 但是不能说是一个特别好的办法, 尤其是我当时面临的情况: 几千的垃圾页面....

再加上针对用户级别的block....更是几乎需要一个个用户的添加....

于是最后我决定还是直接通过操作数据库来清理数据了...

有两种方法:

<ol>
  	<li>phpmyadmin--可视化界面操作数据库, 你不需要会mysql语句~ 操作起来也能减少误差, 但是比较繁琐, 一次能操作的数据有限, 且整个操作过程比较繁琐;</li>
  	<li>Mysql: 需要用sql语句操作数据库, 简单, 高效快速, 但是相应的很容易出现误操作..且不可恢复...几乎..</li>
</ol>

因为垃圾信息量级确实很大, 所以我最后还是用的第二种方法, 通过时间和id进行区分, 删除掉所有非我的用户以及页面...

{% highlight php %}

Delete from "User_table_name" where user_id > 10 and date_touched > 20131127000000; 
delete from "Page_table_name" where page_id > 20;

{% endhighlight %}


不可避免的是肯定出现了不少的误操作, 尤其是这里的date_touched是最近一次编辑的时间...所以我的不少页面也被删除了...

但总的来说, 对于垃圾信息的清除还是比较彻底的~ 基本上可以说是完全清完了~

结束了吗? 当然没有...这样只能是治标不治本...再次开放后还是会有大量的垃圾信息灌入...

于是查找了一下, 找到了一个ConfirmAccount的插件, 是在用户申请注册后加一个环节, 就是管理员审批环节~ 如此就可以保证很多垃圾用户不会通过申请了~ <a href="https://www.mediawiki.org/wiki/Extension:ConfirmAccount" target="_blank">地址在此</a> ~ 很简单的设置~

经测试上述插件完全可以保证用户不经审批就不会成为正式用户, 而经过审批后的用户会受到确认邮件,其中包含用户名和密码~

和Account一样, 还有一个插件是ConfirmEdit, 但与审核不同, 这个是通过增加验证码环节来阻止垃圾信息的添加~

与ConfirmAccount的安装方式一样~ 设置也在<a href="https://www.mediawiki.org/wiki/Extension:ConfirmEdit" target="_blank">介绍页面</a>上详细说明了~ 值得一说的就是验证码可以有多种模式来选择～这个挺不错的～哈

在LocalSettings.php中需要设置一下, 同时补充不同群组的权限:

{% highlight php %}

 require_once( "$IP/extensions/ConfirmEdit/ConfirmEdit.php" );
 require_once( "$IP/extensions/ConfirmEdit/QuestyCaptcha.php" );
 $wgCaptchaClass = 'QuestyCaptcha';
 # Add the permissions
 $wgGroupPermissions['*']['skipcaptcha'] = false;
 $wgGroupPermissions['sysop']['skipcaptcha'] = true;
 $wgGroupPermissions['bureaucrat']['skipcaptcha'] = true;
 $wgGroupPermissions['user']['skipcaptcha'] = true;
 $wgCaptchaTriggers['edit']          = true; 
 $wgCaptchaTriggers['create']        = false; 
 $wgCaptchaTriggers['addurl']        = true; 
 $wgCaptchaTriggers['createaccount'] = true;
 $wgCaptchaTriggers['badlogin']      = true;
 $arr = array (
         "Question A" => "Answer of A",
         "Question B" => "Answer of B",
 );
 foreach ( $arr as $key => $value ) { 
         $wgCaptchaQuestions[] = array( 'question' => $key, 'answer' => $value );
 };

{% endhighlight %}

很容易理解, 我就不说啥废话了~

对了~记得关掉之前设置的禁止编辑等~ wiki还是开放才是正解~

通过上述环节就可以初步完成对垃圾信息的各种围追堵截了~ 后续可能会把验证码的模式调整下, 修改为reCaptcha~
