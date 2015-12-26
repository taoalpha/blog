date: 2015-07-09 9:00:00
title: Add Swiftype as my default internal search engine
category: tech
description: Show you how to add the swiftype search engine into your website.
tags: [swiftype,内置搜索]
language: en
author: taoalpha
---

## Summary

Since I imported some old articles from my old blog, <a href="{% post_path tech-add-internal-search-to-jekyll-blog %}">the internal search I built using javascript and json datas</a> last time got slower and slower. So I decided to add a third-part search engine for my blog. Like I recommended in my <a href="{% post_path tech-add-internal-search-to-jekyll-blog %}">last post</a>, [swiftype](https://swiftype.com) is a really nice choice.

## How to add swiftype in your blog

### Before Sign Up

Before you open the [swiftype website](https://swiftype.com) and sign up, you should do some work to check whether your website is friendly to search engine.

#### robots.txt

If you have some subdirectories or subdomains you don't want to be crawled by some search engines, you need to set the rules in robots.txt.

As an example, I want to hide all my `api/` pages to all search engines, I can add this line into my robots.txt:

``` conf
User-agent: *
Disallow: /api/
```

You can just put the robots.txt in the root directory of your domain and it will work.

#### sitemap.xml

> A site map (or sitemap) is a list of pages of a web site accessible to crawlers or users. It can be either a document in any form used as a planning tool for Web design, or a Web page that lists the pages on a Web site, typically organized in hierarchical fashion. -- from wikipedia

So if you have a sitemap, it can help search engines like google crawl your site better.

You can just put the sitemap.xml in your root directory with robots.txt, or you can specify it in your robots.txt using this one line code: `Sitemap: http://taoalpha.me/blog/sitemap.xml`.

You can have multiple sitemap.xml files, of course.

Don't know how to create a sitemap.xml ? [Check this!](https://www.xml-sitemaps.com)

### Sign Up and Build your engine

After you finished optimizing your site for search engines. Now you can sign up on the [swiftype website](https://swiftype.com) and build your engine.

The free plan of swiftype has some limits for using:

- Total Documents	500
- Monthly Queries	1,000

So if your blog is really big and you have a lot of users using your search, you may need to change to a pro plan~

Just find a nice plan for yourself on the swiftype.

### Add your domain and rules

After you build your search engine. Now you can add your domain into your engine. Or if you start with the tutorial on the homepage of swiftype, maybe you have already done this.

You can go to `your dashboard -> manage -> domain` to check the domain you have added into your engine. And also you can set the rules for you domain.

#### WHITELIST RULES

Only pages matching these rules will be included in your index.

#### BLACKLIST RULES

All Pages matching any of these rules will be excluded. So like my blog, I want to remove all the tag pages and category pages from my index in order to empty the room for the real post page. I can just add `/blog/tag/`,`/blog/user/`,`/blog/page` into my BLACKLIST rules.

### Install the Search into your site

Swiftype has a real good instruction to help you install the search into your website. You can just follow the integrate instruction step by step and customize the color and style of your result-page.

After all settings, you will get a javascript code and you just need to add this code into all the page you want  your search box to be viewed by your users.

And according to your settings for the input field for searching, you will need do a little work to add the input into your website with the default class.

Just remember to activate the search after that.

### After installed

#### Manage your content

Besides domains and the rules, you can also view the details of the pages crawled by the swiftype in `your dashboard -> manage -> content`.

Here list all the pages included in your search engine, and even better, it will also record some click-data and referring-suggest-data to help you optimize your posts.

#### Customize the engine

Besides all the normal functions, you can also customize your swiftype engine, like re-order the search results customize your relevance algorithm, define your Synonym list...etc.

Of course, it has some limits for free plan.

#### Analytics

Swiftype will record some information related to the search part, like top queries,top auto-completions, top searches with no result...etc

## Tips:

- Be patient. You need to wait a while before any pages included in your engine;
- Remember to activate your engine. If you have added the js code and input field into your website, and still can not use the engine, maybe that's because you forget to activate your engine;
- Customize. If you want the search box fit into your content more naturally , you should customize the style for it;
