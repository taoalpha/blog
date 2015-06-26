---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-70-PDF(resume)制作方式总结
tags: [PDF,应用推荐与技巧,Resume,Patch]
---

最近和大家聊天说到了简历制作的问题. 基本都是PDF格式, 但是针对如何生成最后的PDF却有着很多不同的方式, 这里特别总结以下当前最主流和最不主流的几种PDF简历的制作方式:

<ul>
	<li><strong>主流手段之Word/Pages:</strong> 这个算是最为常见的一种方法了, 以简洁快速和技术门槛极低而风靡世界, 当然同样以丑陋千篇一律而出名被众人摈弃... 但是Word就一定做不出好的resume了吗? 当然不是, 实际上绝大多数用PS做出来的简历也是完全可以用Word做出来的, 就看你花不花时间去做了~ 当然, 毕竟Word本身不是专业的图片处理和制作软件, 所以要实现很好的简历效果自然会更费劲一些~ 这里有一些很不错的Word简历样本.</li>
	<li><strong>主流手段之Photoshop/InDesign:</strong>前者作为最强大的图片处理软件可谓人尽皆知, 那么想要做一个有创意的resume, 用PS自然是不二之选, 网络上也有很多好看的PSD可供下载参考; 后者作为专业的排版设计软件, 就做简历而言, 可以说是大材小用了, 但是其产出质量自然也是极高的, 但是这两者都有个不好的特点就是其生成的PDF文件都相对比较大, 而一旦压缩的话, 很容易出现图片模糊失真的现象; </li>
	<li><strong>技术流手段之Latex:</strong> Latex对数学相关人士而言会比较熟悉, 它可以生成很漂亮的数学公式~ 当然, 其在排版上的应用也是非常广泛的, 不过通过Latex编译出来的resume一般格式也会相对固定一些, 就色彩等方面的灵巧性, 自然是不能和PS等相比, 但是中规中矩也算是比较符合工科生的特点;</li>
	<li><strong>非主流技术手段之jsPDF:</strong> 这是一个js的库, 专门是用来通过javascript生成PDF的, 目前其html的部分还处于实验阶段, 很多属性都不能很好的表现在pdf中, 但是像体现技术范儿的同学可以做个网页然后给一个生成PDF resume的按钮~哈</li>
	<li><strong>非主流之取巧型html转pdf:</strong> 类似jsPDF, 如果你也比较熟悉html/css, 然后又觉得能够用网页做出效果很好的resume, 就可以通过print功能, 把做好的网页保存成pdf, 也不失为一个方法~ 当然要注意选项中去掉默认添加的header以及默认去掉的背景色就可以打印出完整的页面了, 这种做法还有个特别的好处就是一般来说最终的PDF文件都相对比较小;</li>

</ul>

相关资源清单:
<ul>
	<li><a href="http://designscrazed.org/best-professional-resume-templates/" title="各种resume模板-各种格式" target="_blank">PSD/WORD/AI/ID等等模板</a></li>
	<li><a href="http://www.buzzfeed.com/peggy/impeccably-designed-resumes" title="非常赞的resume设计样例" target="_blank">一些很好的resume范例</a></li>
	<li><a href="http://mrrio.github.io/jsPDF/" title="github-jspdf" target="_blank">jsPDF-Github</a> || <a href="http://jspdf.com/" title="jsPDF官网" target="_blank">jsPDF-官网</a></li>
	<li><a href="https://www.writelatex.com/" title="在线预览Latex" target="_blank">Latex在线预览</a></li>
</ul>

