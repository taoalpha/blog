---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day48-css中的百分比
tags: [percentage,CSS,Patch]
---

好久没写patch了~ 从上次写完ipromise之后, 一直没进行什么新的项目, theysay也只是进行了一小部分而已~ 惭愧...

上周的时候研究了一下css中的百分比问题, 比如宽高的百分比是相对对应的宽高的吗? 字体的百分比又是如何界定呢? 之类的问题~ 今天正好做一总结~

<strong>rules for block element:</strong>

<ol>
    <li>无论position设置与否, 一旦母元素<strong>宽高</strong>用绝对单位定义, 子元素的宽高相对母元素宽高而言;</li>
    <li>如果母元素只限制宽(比如:body), 高根据内部元素自动调整时, 百分比子元素的宽相对母元素宽设定, 高根据子元素内部元素高度而定;</li>
    <li>如果元素本身限制为position:static或者relative, 那么其在不限制宽度的时候宽度会默认100%相对上级元素;</li>
    <li>如果元素本身限制为position:absolute或者fixed, 那么其在不限制宽度的时候宽度会根据内部内容限制;</li>
</ol>

<strong>rules for position:</strong>
当然为了position有效, 元素的position属性必须设定为非static, 同时因为absolute和fixed是相对窗口而言, 所以这里只讨论relative的..
<ol>
    <li>在母元素宽高限制的情况下, top和bottom相对母元素高度而定, left和right相对母元素宽度而定;</li>
    <li>在母元素只限制宽的情况下, left和right相对母元素宽度而定, 但是top和bottom则相对上一级的定义高度而言-直到body; 但是如果此元素的母元素在高度上依赖于其内部内容, 此时top和bottom值对该元素是无意义的;</li>
</ol>
<strong>rules for fontsize:</strong>
<ol>
    <li>font-size基本都是相对原本的font-size而言的, 即如果本身是16px的, 那么font-size设定为200%就是32px的;</li>
</ol>

