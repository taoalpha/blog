category: readings
description: ''
date: 2014-12-04 9:00:00
title: Google又做了一件大好事:干掉了烦人的识别型验证码!
tags: [Captcha,reCaptcha,读系列,翻译文章]
---

译系列正式转为读系列, 以后都为阅读后自己整理总结成文~ 吸收知识哈哈

<p>伟大的Google又做了一件大好事啊!! 它干掉了烦人的识别型验证码!!! <a href="http://venturebeat.com/2014/12/03/google-boils-down-the-captcha-to-a-simple-checkbox-to-prove-youre-not-a-bot/#ref=muzli">本文</a>简单介绍了一下这一新的验证码.</p>

<p>对于验证码, 大家都不会陌生, 无论你是否经常上网, 是否买过东西, 是否看过网络视频, 你一定遇到过验证码!!! 而如今最为常见的几种验证码形式分别是:</p>

<ul>
<li><strong>Captcha(Completely Automated Public Turing test to tell Computers and Humans Apart):</strong> 图片识别, 通过识别一些或模糊或清晰的图片中的文字信息来达到验证"我不是机器人"的效果;</li>
<li><strong>reCAPTCHA:</strong> 同样来自Google, 用Captcha的方式做有意义的事情. 其和Captcha的表现形式基本是一致的, 只不过里面的图片不再是预设好的人工生成的那种故意扭曲或者加干扰后的图片, 而是Google的图书扫描项目中那些OCR无法识别的单词(多数是手写体或者不够清晰), 这样你每次输入验证码, 还能帮助Google的Books做的更好哦~(至于如果它自己都不识别, 那么怎么判断输入是否正确, 则是因为通常reCaptcha会提供两个词组, 一个是已知的, 一个是未知的, 所以呢, 在已知的正确的情况下, 未知的正确性就有了一定的保证, 而结合大量的输入, 那么最中获得的结果的正确概率就越高:所以, 面对一些很少有人输入过的验证码, 其实你很有可能输错了部分, 但也通过了~哈); 而继图书项目后, Google又在reCaptcha项目中加入了Google街景的路牌, 街道名识别~ 所以有时候你会遇到那种拍的很模糊的数字图~</li>
<li><strong>Puzzle CAPTCHA:</strong> 在识别类验证码之后, 又出现了这种拼图类的验证码, 操作方式有很多, 有的是图片切分打乱, 需要你重新排列成完整的图片, 有的则是有一块图片从整个图片中脱离出来, 需要你移动回去这种~ 这种有时候也叫做Draggable Captcha~</li>
<li><strong>Quiz Captcha:</strong> 这种则属于问答类的验证码了, 有的时候是一些显而易见的数学计算题或者找规律题, 有的时候则是一些基本常识, 还有些时候甚至是当前往网站名称这类有着明显答案提示的问题~</li>
</ul>

<p>当然, 除了上述的这些, 还有着很多的验证码类型, 但是无论怎样, 为了实现区分人和机器的目的, 都是需要一定操作成本的, 这也是为什么大家很讨厌验证码的原因~</p>

<p>但是! Google这次新的reCaptcha:No CAPTCHA reCAPTCHA, 就改变了这一点, 它完全干掉了现有的这种繁琐的验证码, 取而代之的是一个简单的checkbox!!! 你只要勾选了这个"我不是机器人"边上的checkbox, 就算是通过了验证~ 似乎感觉这不是进步而是退步? 这样怎么能够实现Captcha的区分人和机器人的目的呢?</p>

<p>其实这个简单的checkbox里面有着非常复杂的机制, 它会通过你验证码勾选前后的整个表现来判断是否是一个机器人, 一旦有所怀疑, 甚至可以选择变回旧有的那种图形或者其他传统类型的验证码来再次确认. 这些都是基于 <a href="http://venturebeat.com/2014/09/06/google-shows-its-deep-learning-systems-are-doing-just-fine-thank-you-very-much/">人工智能方面</a>很深入的研究和成果.</p>

<p>目前这种新的Captcha的API已经开放给很多大客户了, 最近在开始接受网站主们的申请了~ 而那些大客户的反馈来看, 其效果是非常不错的: 核心的anti-spam质量虽然文章中没说, 但应该不错, 文章中重点提到了这个新Captcha的一个优点就是可以让用户更快的登录访问网站.</p>

<p>有兴趣的可以前往<a href="https://developers.google.com/recaptcha/">Google reCaptcha</a>了解更多详情~</p>
