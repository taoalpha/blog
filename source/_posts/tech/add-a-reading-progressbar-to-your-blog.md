date: 2016-01-16 7:00:00
title: Add a reading progressbar to your blog
category: tech
description: how to add a reading progressbar to your blog
tags: [css,progress]
author: taoalpha
---

Yesterday, I added [airbnb blog](http://blog.airbnb.com/) to my subscriptions, and found an interesting feature on this blog: when you scroll down, there will be a progressbar on the top of the page showing the progress of your reading on this post. So I just added it to my blog :)

Actually the logic is pretty simple, you calculate the distance you have scroll down, and then divided by the height of your post area, fixed with some margins and offset, added some styles and html, you will get your own reading progressbar :) I don’t know whether airbnb using this method or not since I didn’t look their code…

``` javascript
// with jQuery
( () => {
  $(window).scroll( () => {
    // listen to the scroll event
    if(window.scrollY > 220){
      // the distance between the top of the document and start of your post area, only show when you actually start reading :)
      var percentage = Math.ceil( ( (window.scrollY - 200 + $(window).height()) / $('section.entry').height() )*100 )
      // calculate the percentage of reading, here I minus the distance at the top but add the height of your screen to make sure it will hit 100 when scroll down to the bottom
      if(percentage<=100){
        // show and update the progressbar
        $('div#progressbar').fadeIn(300).find('span.text').text(percentage+"% READ")
        $('div#progressbar').fadeIn(300).find('span.bg').css({width:percentage+"%"})
      }
      // hide it when read 100%
      if(percentage >= 100){
        $('div#progressbar').fadeOut(300)
      }
    }else{
      // hide if you scroll up to the top
      $('div#progressbar').fadeOut(300)
    }
  })
})()
```

And then you just need a html snippet like this on your post page and add your own styles for them:

``` pug
div#progressbar
  span.bg
  span.text
```