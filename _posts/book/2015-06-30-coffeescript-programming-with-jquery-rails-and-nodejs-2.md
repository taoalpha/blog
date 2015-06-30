---
layout: post
title: CoffeeScript Programming with jQuery, rails and Nodejs (2)
category: book
description: The second and last note of this book, will focus on how to use CoffeeScript with jQuery, rails and node.
tags: [js,CoffeeScript,jQuery,rails,nodejs,reading notes]
language: en
series: The Way I Learn CoffeeScript
author: taoalpha
---

## Summary

After learned the basic syntax of CoffeeScript, I re-wrote all my blog's js files with CoffeeScript. I have to say, practice is the best way to learn and understand one skill. Especially for coding, if you just read the book and never write a single line by yourself, you will never become a master of it or you may stick in the beginner for ever.

Today we will finish the book. Talking about how to combine the CoffeeScript with some other web tools we use a lot: jQuery, Rails and Nodejs.

## Notes

Here I just ignored the second chapter about how to install the coffeescript and nodejs in your computer, if you need some help, feel free to comment below the blog or just visit the [nodejs](https://nodejs.org/) and [coffeescript](http://coffeescript.org/) to find a way yourself.

### jQuery

jQuery is the most popular js module people used in their websites or webapps. And using jQuery with CoffeeScript is just like javascript. jQuery is javascript, after all.

Want to use CoffeeScript with jQuery? Just do it and follow the rules we learn from the basic syntax part. Here I list several examples and if you look it closely, you will find everything you have already known if you read the first chapter carefully. The author of the book shows us another complex examples: [TodoMVC in CoffeeScript](https://gist.github.com/alecperkins/3363111).

BTW: [TodoMVC](http://todomvc.com/) is a great project which shows you how to write a todo app in all kinds of tools and frameworks.

{% highlight coffeescript %}
$ ->
  do some
  do another
### =>
$(function() {
  some();
  return another();
});
That's just like the $(document).ready(function(){})
###

# A function using ajax to send mail, which is a new feature I will add to my blog in a few days :)
@sendMail = (msg)->
  $.ajax
    type: 'POST'
    url: 'https://mandrillapp.com/api/1.0/messages/send.json'
    data:
      'key': ''
      'message':
        'from_email': msg.sender_mail
        'from_name' : msg.sender_name
        'to': [
            {
              'email': ''
              'name': 'TaoAlpha'
              'type': 'to'
            }
          ]
        'autotext': 'true'
        'subject': msg.subject
        'html': msg.content
  .done (response)->
    showAlert("success","Thanks for your contribution!")
  .fail (data)->
    showAlert("fail","Sorry! Failed to send the email. Please retry!")

# another function to get unique result from an array of objects
Array::getObjectUnique = (id) ->
  a=b=[];
  add = (data) -> b.push data[id];data
  (add i for i in @ when b.indexOf(i[id]) == -1 )

{% endhighlight %}

{% highlight javascript %}
// You can see that you have saved a lot of keystrokes and the codes look more clean and beautiful.
// Because coffeescript doesn't support declare global variables directly, and if we want to use the function in other script, we need to declare it into the `this` scope.

this.sendMail = function(msg) {
  return $.ajax({
    type: 'POST',
    url: 'https://mandrillapp.com/api/1.0/messages/send.json',
    data: {
      'key': '',
      'message': {
        'from_email': msg.sender_mail,
        'from_name': msg.sender_name,
        'to': [
          {
            'email': '',
            'name': 'TaoAlpha',
            'type': 'to'
          }
        ],
        'autotext': 'true',
        'subject': msg.subject,
        'html': msg.content
      }
    }
  }).done(function(response) {
    return showAlert("success", "Thanks for your contribution!");
  }).fail(function(data) {
    return showAlert("fail", "Sorry! Failed to send the email. Please retry!");
  });
};

# get unque result for array of objects
Array.prototype.getObjectUnique = function(id) {
  var a, add, b, i, j, len, results;
  a = b = [];
  add = function(data) {
    b.push(data[id]);
    return data;
  };
  results = [];
  for (j = 0, len = this.length; j < len; j++) {
    i = this[j];
    if (b.indexOf(i[id]) === -1) {
      results.push(add(i));
    }
  }
  return results;
};
{% endhighlight %}

### Rails

Ruby on Rails is a web framework that came around in 2004. And it soon became quite popular. Actually many people believe that Rails saved the ruby...

Check this:[How to download and install Rails](http://rubyonrails.org/download) if you haven't installed it.

#### Rails's principles

- Convention over configuration

> Rails is designed to assume that the programmer will follow certain known conventions, which if used, provide great benefit and much less need to configure the framework.That means that the framework makes assumptions on how a typical application should be built and structured and it doesn't try to be overly flexible and configurable. This helps you spend less time on mundane tasks like configuring and wiring up an application architecture and more time on actually building your app.

- Don't repeat yourself, or DRY

> Every piece of knowledge must have a single, unambiguous, and authoritative representation within a system.
> Rails strives to remove duplication and boilerplate wherever it can.

#### How to use Rails with CoffeeScript

Luckily, after Rails 3.1, you don't need do anything to let Rails support CoffeeScript. It has already become part of rails! And also, rails has changed its default js library to jQuery.

So what you need to do if you want to use coffeescript with rails? Nothing but learn rails!

Just like the author said in the book: "If you haven't done so already, I encourage you to spend some more time learning Rails as well as Ruby, and immersing yourself in the wonderful communities they support."

### Node.js

Node is fantastic. It changes something. Before node, javascript was mostly run inside browsers. Now it just came out and gave web developers a chance to become a full-stack!

#### Features of Node

- Event-driven

> The Node.js framework only allows non-blocking, asynchronous I/O. This means that any I/O operation that is accessing an external resource, such as the operating system, a database, or a network resource must happen asynchronously.

- Fast and scalable

> The V8 JavaScript engine(created by google and used in chrome) used by Node.js is highly optimized for performance, thus making Node.js applications very fast. The fact that Node is non-blocking will ensure that your applications will be able to handle many concurrent client requests without using a lot of system resources.

- Node is not Rails

> Rails strives to be a full-stack solution to building web applications, whereas Node.js is more of a low-level system for writing any type of fast and scalable network application.

#### Node and CoffeeScript

Want to write coffeescript in node? It's easy, all you need is a module named `CoffeeScript`. And like many other languages, node has several frameworks people built for web development, like: [Express](http://expressjs.com/).

The core about how to use coffeescript with nodejs is to use the `--watch` for `coffee` command in node. It will automatically compile all file end with `coffee` into `js` when there is a change made into these files.

And just like jQuery, you just follow the rules and write your code.

## Digest

CoffeeScript is a tool that can help you write js more quickly and elegant. And any platform or language you want to use coffeescript, what you need to do is following the coffeescript's rules. There is no difference caused by platform or language.

That's all. Thanks!
