---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day8-Phabricator中邮件SMTP的配置
tags: [postfix,sendmail,Phabricator,Patch]
---

按着Phabricator刚开始的五个未完成任务,最为麻烦的一个就是SMTP的配置了,因为本身我的server里没有装sendmail,于是需要完全重新开始, 最初是按着sendmail装的, 后来转战到了postfix~一下为值得记录的备注:
<ul>
	<li>postfix的配置比较简单,我也是主要<a href="http://www.cyberciti.biz/tips/postfix-smtp-ssl-certificate-csr-installation-guide.html" target="_blank">按照这篇blog</a>的设置(用的是gmail)进行的~,唯一值得注意的一点就是: 如果你发现设置完成后的postfix无法启动, 查看mail.log的日志发现是因为bind:0.0.0.0:25 already in use之类的提示的话,你需要查看一下端口的情况,看一下你的25端口是不是被占用了,尤其是从sendmail转到postfix的人, 25端口很有可能被sendmail占用,从而导致postfix无法使用, 所以这种情况下需要先停止sendmail的服务, 因为sendmail和postfix是并列的服务,并不是从属关系~之后基本就没什么问题了~</li>
	<li>接下的配置基本完全参照phabricator上的guide来操作就可以了~可能需要注意的问题就是:在填写mail-adapter的时候可以填写:PhabricatorMailImplementationPHPMailerAdapter, 但是在phpmailer的设置中smtp-protocol需要用tls而不是按照它所推荐的说gmail用ssl....因为我用ssl似乎无法connect to the host..可能是因为postfix中有涵盖这个~冲突了?不确定...但是至少tls的设置确实是正常的~因为经我验证确实生效了~欢迎来访(<a href="http://phabricator.zzgary.info" title="phabricator" target="_blank">here!</a>--但不保证一定批准...)</li>
</ul>
我会在之后慢慢把很多二级目录都迁移到二级域名之中去,欢迎大家随时来访哈~
