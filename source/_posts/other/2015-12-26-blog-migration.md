date: 2015-12-26 02:34:01
title: Blog Migration from jekyll to hexo
description: Finally migrate my blog to the hexo!!!
category: blog
tags: [migration,hexo]
author: taoalpha
language: en
---

After nearly 24 hours work, I finally migrated my blog from jekyll to hexo. Actually, I recreated the entire blog with hexo with same styles and scripts files.

## Why

Why I want to migrate to hexo instead of keeping using jekyll ? The most important reasons are:

- hexo is written with NodeJS which I am more familiar with, so it would be easy to debug and create my own extension easily;
- the new version of jekyll has a really bad compatibality of previous versions... after a terrible error happended when I upgraded last time, I decided to use hexo;

## Workflow

### Hexo Workflow

First, I want to introduct the hexo workflow instead of the migration workflow, here I list some lovely features that I think are most important:

- theme: you can import or create your own theme in hexo with pure css/js/html and a little template langualge;
- npm: since it is written with Node, so you definitely can take advantage of the npm, so you can choose any language you want to write css or javascript, I'm using es6 and scss;
- fast: fast to build and fast to generate;

hexo is really easy to use, especially with theme functions, you can just fork some beautiful themes from github or official website of hexo, and then what you need to care is only writing the posts.

### Migration Workflow

Since I need to migrate the website from jekyll to hexo, there are few things you need to prepare and remember:

- structure: if you are using a customized theme created by yourself, then you need create a theme in hexo, but luckily, most of times, you don't need to rewrite the scss and javsascript since hexo also supports most of the precompilers of them.
- format: they are using totally different format of the tempalte file, jekyll is using somthing more similiar with liquid template while hexo supports jade/ejs/swig...etc, I chose jade since it is the most familiar one compared to others :)
- files: You can keep your styles and scripts, but you need rewrite the template files. The structure of the html can be the same, but you need modify it according to hexo's requirements and attributes
- posts: After you created your own theme, you can migrate all the posts you have to hexo, according to the content you put into your posts, you may need some extra work to convert some tags or elements, like the `highlight` block;
- debug: remember to debug every functions after you have migrated the entire site :)

## Tips

Be Patient! You will encounter a lot of bugs and problems during the entire process, but you can always find something helpful from google or github.

If you are doing the same thing, welcome to comment or shoot me an email :)

## Todo

- Series Widget
- Small bugs
- Re-factor some parts
- Optimize the theme
