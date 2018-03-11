date: 2015-12-31 7:00:00
title: Blur on Background
category: tech
description: How to add blur effect to any images with css
tags: [css,blur]
series: The way I learn CSS3
author: taoalpha
---

Today I finally made my first angularJS app which is a simple todo app connected with my [First nodejs cli tool: baby](http://taoalpha.github.io/blog/2015/12/06/tech-my-first-cli-tool-with-nodejs/). They share the same data set, so you can think it as the UI for baby todo part (I will build the UI for other nice features, one by one).

I really like the interface of the [Papaly](https://papaly.com/), especially the speed dial dashboard !! So I also use a large image and the crystal blur block on my design, here I just want to share something with you :)

## Blur

Blur is quite popular in Web Design, you can see them all the time. But how we do that from the point of coding part ? Before CSS3 introduced the filter, people just modify the images manually and make them blur before actually use them in the design, and now we have CSS3, we can just use filter.

We all know make a image blur is pretty simple, but how we make part of image blur, and even more, how we make part of image blur be dynamic ? This is what I gonna talk about today :)

### Without CSS3

Let’s do it old fashion first. You want create a box within which all background image should be blur, and also the box may move to any place or even can be moved by users. How to do that? Quite simple, we can use two images, one is normal, the other is blur one.

Then what you should know is `background-attachment` which adds the magic.

``` css
/* background-attachment can specify the position of the background image
 * fixed : the background is fixed with regard to the viewport, so it won't move with the element
 * background-attachment: fixed;
 * background-size:100%;
 * keep size 100% to fit the viewprot
 */

html,body{
  width:100%;
  height:100%;
  margin:0px;
}
.imgBlur{
  width:100%;
  height:100%;
  margin:auto;
  background-image:url("http://www166.lunapic.com/editor/premade/o-blur.gif");
// image without blur
  background-size:100%;
}
div.blurBox{
  width:50%;
  margin:auto;
  height:200px;
  color:white;
  padding:30px;
  text-align:center;
  display:table;
}
div.blurBox.withoutcss3{
  background-attachment:fixed;
  background-size:100%;
  background-image:url(http://www166.lunapic.com/editor/premade/blur.gif);
// image with blur 
  display:none;
}
.blurBox span{
  display:table-cell;
  vertical-align:middle;
}
```

### With CSS3

With CSS3, we don’t need the second image, we can just use blur.

``` css

/* z-index is to make sure the content of the box won't be blur */

div.blurBox.withcss3{
  z-index:1;
}
div.blurBox.withcss3:before{
  width:100%;
  display:block;
  content:" ";
  height:100%;
  background-image:url(http://www166.lunapic.com/editor/premade/o-blur.gif);
  // now we don't need blur image
  background-attachment:fixed;
  // still need this since we need use the blur on the image
  position: absolute;
  background-size:100%;
   -webkit-filter: blur(3px);
  filter:blur(3px);
  z-index:-1;
}
```

Here is the demo I made with codepen:

<p data-height="265" data-theme-id="0" data-slug-hash="LGbajd" data-default-tab="result" data-user="taoalpha" data-embed-version="2" data-pen-title="LGbajd" class="codepen">See the Pen <a href="https://codepen.io/taoalpha/pen/LGbajd/">LGbajd</a> by taoalpha (<a href="https://codepen.io/taoalpha">@taoalpha</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>
