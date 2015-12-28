title: Related Articles and generate API files in Hexo
date: 2015-12-27 20:54:43
tags: [hexo,js,related article]
category: tech
series: The Way I Learn Hexo
---

## Why?

Since I have migrated my entire blog to hexo, so I need to rewrite a lot modules :) Today we talk about related articles and how to generate api files in your hexo blog.

## How

### Related Articles

Unlike jekyll, hexo doesn't have a built-in module to populate the related articles (meanwhile, jekyll's built-in related articles are sucks, so many people build themselves, I did once before, you can check this <a href="{% post_path tech-jekyll-related-posts-optimization %}">Optimize jekyll(in chinese)</a> if you want.), so I have to write one for myself.

The idea is pretty simple and similiar with last one I did for jekyll, use the tag to compare different posts, it they have some common tags, they should be similiar, or related.

So I query the post according to current post's category and get all posts with same category as current one, then for each post, I compared its tags with current post's, if there is some intersect between them, I will count it as a related article to current post.

The code is simple too(written in jade):

``` jade
- var posts = []
- if(page.categories){
-   var cat = page.categories.toArray()[0].name
-   var existTags = page.tags.toArray().map(function(v){return v.name})
-   var prePosts = site.categories.findOne({name: cat}).posts
-   if(prePosts.toArray().length>0){
-     var someCatPosts = prePosts.sort('date', -1).toArray()
-     someCatPosts.forEach(function(v){
-       var tags = v.tags.toArray().map(function(t){return t.name}).filter(function(n){return existTags.indexOf(n)!=-1})
-       if(tags.length>0 && posts.length < 5 && v.permalink != page.permalink){
-         posts.push(v)
-       }
-     })
-   }
- }
if posts.length > 0
  div.relatedposts.sidenav
    h2= "Related Posts:"
    ul.article-list
      each post in posts
        li
          a(href=url_for(post.permalink))= post.title
```

### API Generator

Since I use static blog, I don't have any tools or modules like php to deal with post and get request, but what I can do is I can host json files with data I want to put in and treat it as a API(since most API just return a json with proper content), like I have `latest.json` to show the latest 10 posts of my blog, you can view it through [this link](http://taoalpha.me/blog/api/latest.json).

Yup. This is the basic idea, and how to do it? We need build a plugin for hexo :)

A plugin for hexo is a normal module for node, so you need to define the package.json and the index.js, its totally fine that you only have one js file if you don't need to deal with complicated logic things. But this time, I use two js files, the `index.js` would load the config from the hexo and assing the task to different generators. :)

And this is modified from the source code of [hexo-generator-sitemap](https://github.com/hexojs/hexo-generator-sitemap) :)

Since they are using pretty much the same logic, I just remove the built-in modules: sitemap and feed generator, and combine them into one.

Here it is:

``` javascript
// this is the index.js
var merge = require('utils-merge');
var pathFn = require('path');

// load the config from the hexo.config and combine them with some default configurations
var config = hexo.config.api = merge({
  sitemap:{
    src: "sitemap.jade",
    desc: "sitemap",
    path: "sitemap.xml"
  },
  feed:{
    src: "feed.jade",
    desc: "feed",
    path: "feed.xml"
  }
}, hexo.config.api);

var gen = require('./lib/generator');

// assign them to different generators

for(var item in config){
  (function(item){hexo.extend.generator.register(item, function(locals){
    return gen(item,hexo.config,locals)
  })
  })(item)
}
```

``` javascript
// this is the ./lib/generator.js
var jade = require('jade');
var pathFn = require('path');
var fs = require('fs');

// main functions, current only deal with the latest posts if it is a json file task :)
// if it is xml task, then it will render the default template ( sitemap.jade, feed.jade)
module.exports = function(item,config,locals){
  var api = config.api
  if(api[item].path.endsWith("json")){
    var posts = locals.posts.toArray()
      .sort(function(a, b){
        return b.updated - a.updated;
      });
    var data = [],count = 0
    posts.forEach( (post) => {
      if(count > (api[item].limit || 10)){
        return
      }
      var temp = {}
      post.date = new Date(post.date).toLocaleDateString()
      api[item].attr.forEach( (v)=>{
        if(v == "summary"){
          temp[v] = post.content.replace(/(<([^>]+)>)/ig,'').slice(0,200)
        }else{
          temp[v] = post[v]
        }
      })
      count ++
      data.push(temp)
    })
    data = JSON.stringify(data)
  }else{
    // for xml(now only support sitemap, feed since I only these two templates :)
    var templateSrc= pathFn.join(__dirname, '../'+api[item].src);
    var tmpl = jade.compile(fs.readFileSync(templateSrc, 'utf8'));

    var posts = [].concat(locals.posts.toArray(), locals.pages.toArray())
      .filter(function(post){
        return post.sitemap !== false;
      })
      .sort(function(a, b){
        return b.updated - a.updated;
      });

    var data= tmpl({
      config: config,
      posts: posts
    });
  }
  return {
    path: api[item].path,
    data: data
  }
}
```

That's it.

I love hexo!! I love JS!!! :)
