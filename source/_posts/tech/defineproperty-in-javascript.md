date: 2016-04-29 7:00:00
title: defineProperty in JavaScript
category: tech
description: introduce defineProperty in JS
tags: [js]
series: The way I learn JS
author: taoalpha
---

## Write Ahead
About 30 minutes ago, I tried to rewrite the [colors module](https://www.npmjs.com/package/colors), at least part of it :). Then I found a nice and rarely used method defineProperty which made the past 30 minutes totally worth it.

## Rewrite the colors
Before we put our hands on defineProperty, I want to tell you how I found this method :) [colors](https://www.npmjs.com/package/colors) is a module that can give you a colorful node.js console. And one of the most important features is it extends the origin String with a lot colorful methods.

About how to add color to your console, please read this article: [ANSI escape code](https://en.wikipedia.org/wiki/ANSI_escape_code).

### Extend with prototype
Before I look into the source code of colors, I tried to implement in my own way which is adding different colors as new methods to the prototype of String.

So I inlcude the codes file from colors which defines the color code(ANSI escape code), and wrote my function as follow:

``` javascript
/**
 * Add color support for console.log by giving string some additional methods to paint themself with color
 * @author Tao <tao@taoalpha.me>
 */


/**
 * @type {object}
 */
let codes = require("./codes");

Reflect.ownKeys(codes).map( (name) => {
  String.prototype[name] = function() { return codes[name].open + this + codes[name].close; }
} )

let a = "Hi, Tao is a good boy!"

console.log(a.red());
```

It works, cool! We are done here!!!! Wait… it seems that something is not so perfectly… in the example from colors, you don’t need the extra () after the name of color.

We all know that () is a required sign for calling a function, so if we want to use red instead of red(), we can not use function to achieve that, so how we should do with that ?

### defineProperty

{% blockquote MDN https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty Object.defineProperty() %}

The Object.defineProperty() method defines a new property directly on an object, or modifies an existing property on an object, and returns the object.

Usage:

Object.defineProperty(obj, prop, descriptor)

{% endblockquote %}

And for its descriptor, except for data descriptor like configurable, enumerable, value, writable, it also has a special kind of descriptor: accessor descriptor. An accessor descriptor also has the following optional keys: get, set.

So we gonna use this accessor descriptor to help us achieve what we want.

``` javascript
// ... same as before
Reflect.ownKeys(codes).map( (name) => {
    Object.defineProperty(String.prototype, name, { get: function () { return codes[name].open + this + codes[name].close; } });
} )

let c = "Tao is so cool!"

console.log(a.red);
```

Now we have the exactly same results as in colors.

## Summary
Next, I will rewrite the theme part of colors, be ready for the surprising I may find :)

