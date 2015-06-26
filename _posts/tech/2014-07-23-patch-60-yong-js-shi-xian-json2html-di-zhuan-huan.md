---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-60-用js实现json2html的转换
tags: [SIDEBAR,Patch,coding,JSON2HTML,js]
---

这两天在写一个sidebarjs的jquery plugin, 调用的时候允许传递json格式的sidebar menu list, 然后用js去将json渲染成html用于展示. 因为期间因为一个简单的逻辑bug而耽搁了我几个小时的时间... 所以特来记录一下~ 哈

首先, 为了便于便于编辑和修改, 我暂时是把样式文档写死在css文件中的, 等到完善后会把样式结合传入的class或者id参数带入的, 并且最终回合成一个单独的js文件~

其中传参部分为:

{% highlight javascript %}

var menus = {
    0:{
      "name":"The Dark Lab",
      "link":"#"
    },
    1:{
      "name":"Integrity Test",
      "subs":{
        0:{
          "name":"1 buck test",
          "link":"#onebuck"
        },
        1:{
          "name":"10 buck test",
          "link":"#tenbuck"
        },
        2:{
          "name":"Foods test",
          "link":"#foodstest"
          }
      }
    },
    2:{
      "name":"Social Test",
      "subs":{
        0:{
          "name":"When will help test",
          "link":"#whenhelp"
        },
        1:{
          "name":"Who will help test",
          "link":"#whohelp"
        }
      }
    },
    3:{
      "name":"Love Test",
      "subs":{
        0:{
          "name":"Blind love test",
          "link":"#blindlove"
        }
      }
    }
  };
    $('#sidebar').sidebar({
		menus:menus,
        theme:"dark",
        active:2,
        initialdisplay:1,
        content:"#content",
        trigger:"#sidebar_trigger_button",
        social:{
            0:{
                "name":"twitter",
                "link":"https://twitter.com/ZzGary92"
            },
            1:{
                "name":"facebook",
                "link":"https://www.facebook.com/zzgary"
            },
            2:{
                "name":"wordpress",
                "link":"http://callmet.zzgary.info"
            },
            3:{
                "name":"google",
                "link":"https://plus.google.com/114938170856322904606"
            }
        }
			});

{% endhighlight %}



成品如下:
<a href="http://callmet.zzgary.info/wp-content/uploads/2014/07/sidebarmenu.png"><img src="http://callmet.zzgary.info/wp-content/uploads/2014/07/sidebarmenu.png" alt="sidebar menu demo" width="258" height="685" class="size-full wp-image-1482" /></a>


如上, 为了实现从传入的json到html的转换, 首先需要对json的结构进行分析, 因为本身存在循环递归嵌套的情况, 自然在转换上, 也就需要借助同样的方式进行, 所以成品函数如下:



{% highlight javascript %}

renderMenu: function (subs,renderHtml) {
      $.each(subs,function(i,v){
        if(v.subs){
          renderHtml += "<li class=has-sub><a href=#><span>"+v.name+"</span></a><ul>";
          renderHtml = Sidebar.prototype.renderMenu(v.subs,renderHtml);
          renderHtml += "</li></ul>";
        }else{
          renderHtml += "<li><a href="+(v.link ? v.link:"#")+" ><span>"+v.name+"</span></a></li>";
        }
      })
      return renderHtml
    }

{% endhighlight %}

利用函数本身的自身循环调用, 就可以遍历同样循环嵌套的json了~ 当然, 针对json不同的格式和内容, 对应的递归方式也就需要有同样的修改, 仅作参考~

在此期间, 因为没理清思路, 递归调用的时候把

{% highlight javascript %}

renderHtml = Sidebar.prototype.renderMenu(v.subs,renderHtml);

{% endhighlight %}

写成了

{% highlight javascript %}

renderHtml += Sidebar.prototype.renderMenu(v.subs,renderHtml);

{% endhighlight %}

导致debug了很久才找到错误... 这里有个好tip~ 记得多打log!哈

