---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day40-web app中的数据存储
tags: [数据存储,web storage,Patch]
---

随着allfeed的主要预期功能基本全部实现, 我也可以针对web app(extension也勉强算是一个app吧)中的数据存储做一个简单的汇总了~

因为html5中对于数据存储的方式进行了很大的扩充, 再也不是以前只有Cookie这么一种方式了~

因为关于web storage的水比我预期的深很多... 所以以下也只是非常粗略的整理下我自己的理解和收获~^_^

<ul>
    <li>Cookie
        <p>cookie是非常常用的一种数据存储方式, 也是最为古老的一种存储方式, 简单方便, 经常用来存储一些用户信息, session信息等, 主要是满足server端的信息需求;</p>
        <ul>
            <li>优点: 作为server所需信息更为方便, 可以设定过期时间(expiration time);</li>
            <li>缺点: 容量小, 只有4096 bytes;</li>
        </ul>
    </li>
    <ul>HTML5 Web Storage
        <li>LocalStorage
            <p>作为新增的存储方式, localstorage相比cookie有不少的好处, 它的出现也主要是基于cookie无法满足的几个需求: 更大的存储容量, 为client端服务等等, 所以localstorage最主要的两个特点也是: 5MB的存储空间, 主要满足client(javascript)本身的数据需求; 有兴趣了解一下这一段历史的<a href="http://diveintohtml5.info/storage.html">可以阅读dive into html5</a></p>
            <ul>
                <li>优点: client端更为方便, 读取处理的performance更为优秀; 容量大, 5MB per domain</li>
                <li>缺点: 如果需要和server做数据交互的话, 就只能用ajax做post或者get了; 不能设定expiration time;</li>
            </ul>
        </li>
        <li>Session Storage
            <p>和Localstorage同为storage的延伸之一, 与Localstorage最主要的区别就是expiration time了, 顾名思义, Session Storage的有效时间只在当前Session下, 而且虽然html5支持,但是ie8之下对于recover 的page, 其session storage是不会恢复的~</p>
        </li>
    </ul>
    <li>WebSQLDatabases
        <p>这是在html5之前的一种存储方式, 用数据库的方式存储, 用sql来读取, 简单可以理解为一个browser端的sqlite, 但是在html5被标注deprecated, 之后各浏览器平台怕也是会逐渐放弃支持了; 但是除了这一种之外, 还存在集中其他的database存储方式;</p>
    </li>
    <li>Others
        <ul>
            <li>IndexedDB
                <p>IndexedDB也是html5引入的一种, 数据库会保存在用户的浏览器之中, 作为client端数据的一种提供方式, 为app支持offline有了很好的支撑; 作为web sql database的替代方案, IndexedDB也是支持标准sql的, 而且功能和使用上都和原本的sql databases很接近~ <a href="http://www.html5rocks.com/en/tutorials/indexeddb/todo/">具体使用可参见这里</a></p>
            </li>
            <li>PouchDB
                <p>作为一个开源的第三方js library, 通过浏览器和javascript基本模拟了CouchDB的功能, 可以在离线时将数据存储在本地, 而在线后同步到server之上; 本地存储的时候用的就是IndexedDB~ <a href="http://pouchdb.com/api.html">有兴趣了解的可以移步这里</a></p>
            </li>
        </ul>
    </li>
</ul>
Allfeed中数据的存储是通过Localstorage进行的, 而同步是通过ajax和server实现的, PouchDB也是今天才看到, 以后有机会可以改写一下~ 正好算是第二次重构代码~

附图一张, 是介绍Localstorage和cookie在Android和Chrome中的性能比较(chrome版本号比较低):
<a href="http://callmet.zzgary.info/wp-content/uploads/2014/02/performance.png"><img src="http://callmet.zzgary.info/wp-content/uploads/2014/02/performance.png" alt="Localstorage和cookie的比较" width="800" height="510" class="size-full wp-image-1280" /></a>
