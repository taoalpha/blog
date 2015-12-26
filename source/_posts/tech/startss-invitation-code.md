title: Start SS邀请码抢码活动 
date: 2015-05-06 08:00:39
category: tech 
description: 记一次邀请码抢码活动中的斗智斗勇...
tags: [js,油猴脚本,startss] 
author: taoalpha
---

五一回来后面临的一大问题就是翻墙... 好久不翻的结果是发现了不少新的翻墙服务... 

无论是依然坚挺的[红杏](http://www.hongxingchajian.com/)还是后来出现颇有好名的[曲径](http://www.hongxingchajian.com/)(update:已停止接受新用户), 以后最近出现的[土行孙](https://tuxingsun.net)都算是不错的选择, 你要是觉得这些方法都不够高达上, 不够体现你的逼格, 你也可以搜索shadowsocks+vps自建一个翻墙代理, 自己一人享受~ 当然你要是觉得自己实在经济困难, 也可以用一些最近出现的Shadowsocks免费服务, 其中startss就是其中很不错的一个~
(其前辈同SSnode已经被墙...恭喜...).

startss目前采用邀请码注册的方式, 新用户会自动分配5G的流量, 基本上上网页, 一个月还是够用的~ 但是想要看看视频啥的... 那就铁定不够了.. 那么, 怎么获得更多的流量呢? startss目前开展的一个邀请码加油活动就是很好的渠道, 它有个独立的页面每隔30分钟就会放出一个邀请码(update: 这里的码已经不能用于注册了, 纯加油), 输入这个码到加油页面即可. 当然, 一个码只有一次加油机会, 所以一定要眼明手快哦~

当然 对于我们这种眼不明手不快的人... 为了抢到码, 就只能在自己还算擅长的领域做做小弊了... 以下为本次作弊实录:

5.4-1: 发现这一活动, 手抢两次失败...
5.4-2: 查看了下页面, 发现码是直接写到页面中的, 可以用脚本轻易的获取, 于是写了第一个版本的油猴脚本, 大概5行左右... 唯一的功能就是发现新码后弹框提示;
5.4-3: 发现还是抢不到!!! 复制这一步耗费的时间太多... 于是干脆不复制了... 直接发现新码后自动提交到加油...
5.4-4: 终于抢到了... 但是这样刷是不是太频繁了呢,别被禁了.. 恩, 做个时间限制.. 只在放码的时间刷... 每次手动更新旧码太蠢了, 直接上cookie吧, 这个alert弹出框太捣乱了, 直接重写alert不让它弹出了;
5.5-1: 哈哈, 连抢了好多次~ 赞! 
5.5-2: 咦, 怎么最近一直没抢到? 原来站长修改了验证码格式... 增加了扰乱字符... 此处经历了两次扰乱方式, 第一种是增加随机扰乱符号, 比如//这种, 之后更是加上了隐藏的字符.. 直接干掉了我们这种直接用js获取text的人... 但两种方式都很容易破解, 不够犀利... 这个时候我已经不在意抢码了.. 我更好奇的是站长下一步的防刷方法会是什么...
5.6-1: 一天没更新, 我间隔着抢了几个充了充流量;
5.6-2: 站长祭出大杀器... 竟然把码转成图片了... 正巧记得以前看过js的ocr... 试之... 倒是可以识别, 不过准确率非常低, 数字和字母的字体都是非主流的, 所以识别起来不够给力, 基本很难一次识别正确..

至此, 告一段落. 不晓得目前还在坚持刷码的人是如何操作的, 不过我后来实验了下手填图片码, 基本时间够快也是能抢到的, 而且从目前来看没有垄断性刷码的id出现, 八成应该是手刷了都~

附上代码:
``` javascript
// ==UserScript==
// @name         get code
// @namespace    http://code.chenjie.info/
// @version      0.1
// @description  enter something useful
// @author       You
// @match        http://code.chenjie.info*
// @grant        none
// @require http://code.jquery.com/jquery-latest.js
// @require http://code.jquery.com/jquery-latest.js
// @require http://antimatter15.com/ocrad.js/ocrad.js
// ==/UserScript==


/*!
懒得require了, 很短就直接嵌入了
 * jQuery Cookie Plugin v1.4.1
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2006, 2014 Klaus Hartl
 * Released under the MIT license
 */
// 我就省略了.... 防止此处展现太长... 


oldcode = $.cookie('codenumber')

function check(){
    kk = new Date()
    // 做了简单的时间判定, 防止刷的过于频繁...
    if (Math.abs(kk.getMinutes()-30)<1 || Math.abs(kk.getMinutes()-60)<1 || kk.getMinutes()<1){

        // 最开始码是写入文本的, 直接获取即可~ 后来的骚扰也只是多了几步替换而已

        //code = $('tr.success td').find("span").remove().end().text().replace("专属加油码:","").replace(/[\/, ,^,&,*,!,@,#,$,%,_,+,-,=,(,)]/g,"")

        // 尝试了下OCR识别码
        var image = new Image();
        image.src = 'vcode.php';
        var tmp = document.createElement("canvas")
        tmp.width = image.width;
        tmp.height = image.height;
        var ctx = tmp.getContext("2d");
        ctx.drawImage(image,0,0)
        var image_data = ctx.getImageData(0,0,tmp.width,tmp.height);
        console.log(image_data);
        code = OCRAD(image_data);
        console.log("newcode: "+code);

        // 下面这部分就是通过比对新旧码来实现自动跳转加油页
        //if (code != oldcode && code){
        //    $.cookie('codenumber',code);
            //prompt("new code",code);
        //    window.open("http://startss.net/user/add_transfer.php?code="+code,"_self","")
        // 构造了一个url参数从而可以另写一个油猴脚本在加油页获取它, 这里不用cookie的原因是跨域名了...
        // 加油页的脚本做一个提交后的自动重定向到这一页面就可以实现全自动了...
        //}else{
        //    location.reload()
        //}
    }
}

// 设定校验间隔
setInterval(check,2000)
```


``` javascript
// 重写alert的代码:
window._alert = window.alert;
window.alert = function (msg, showItNow) {    
    if (showItNow) {
        window._alert(msg);
    }
};
```

恩~ 就这样~ 哈哈~ 

PS: 为了防止被喷... 我必须申明下... 这种刷的行为并不值得提倡... 我本身也并没有使劲刷... 抢了几次后就会断掉的~ 毕竟我本身有自己的一个vps, 所以这里主要是觉得好玩, 试验了下, 后来被不断的改版新花样搞兴奋了~哈哈 


[TaoAlpha]:    http://zzgary.info "TaoAlpha"
