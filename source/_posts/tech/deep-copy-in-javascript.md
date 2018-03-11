date: 2016-08-13 7:00:00
title: Deep copy in javascript
category: tech
description: how to implement deep copy in js.
tags: [js,copy]
series: The way I learn JS
author: taoalpha
---

## Deep Copy vs Reference Copy
In javascript, everytime you use = or pass a primitive to a function, you are doing deep copy, since whatever happends to it will never affect the origin one.

But things will be so different on objects:

``` javascript
// deep copy on primitives
let a = "hello";

let b = a;
b = 1;
console.log(b, a); // 1, "hello"

function foo(a) { a = 1 };
foo(a);
console.log(a);  // "hello"

// reference copy on objects
let c = [1, 2, 3];

let e = c;
e[0] = 2;
console.log(c); // [2, 2, 3]

function bar(a) { a[0] = 3 };
bar(c);
console.log(c); // [3, 2, 3]
```
Since objects passing by reference, so any changes on them will affect the actual data, so will be reflected to the origin ones.

## Deep Copy on Objects
Most times, reference copy makes life easier. But sometimes, you actually need a deep copy of an object, then you may find several methods in this post :)

### Object.assign
Object.assign is introduced by ES2015, now is supported by most modern browsers, of course, IE not included… but you can find a really handy polyfill for it from this link.

``` javascript
// deep copy with Object.assign
let a = {a: "a", b: "b"}

// have to use {} as the target, since you need a whole new copy
let b = Object.assign({}, a);

console.log(b); // {a: "a", b: "b"}
console.log(b == a); // false
```

Of course, you can use Object.assign do a lot more than deep copy an object, but at least when you want to get some deep copies, this would be one of the easies way to do it.

### JSON.parse and JSON.stringify
Considering Object.assign is not supported by ALL browsers, you may not want to use it. Then try JSON way:

``` javascript
// deep copy with JSON.parse and JSON.stringify
let a = {a: "a", b: "b"}

// use stringify to convert the object to a string(primitive) and parse the string to a new object
let b = JSON.parse(JSON.stringify(a));

console.log(b); // {a: "a", b: "b"}
console.log(b == a); // false
```
Cool, ha? But there is one condition that will give you error: **CIRCULAR OBJECTS**.

JSON.stringify can not convert circular objects to string, so it will break and thorw an error.

It does work on circular objects with Object.assign :)

### slice and concat on arrays
If you want to deep copies on arrays, then you have two wonderful methods to use:

``` javascript
// deep copy with slice
let a = [1, 2, 3, 4];

// slice(0) will return you an new array with nothing sliced in origin one
let b = a.slice(0);
console.log(b);  // [1, 2, 3, 4]
console.log(b == a);  // false

// concat() will return you an new array with nothing to caoncat with
let c = a.concat();
console.log(c);  // [1, 2, 3, 4]
console.log(c == a);  // false
```
The reason behind these two methods is because they both return new arrays instead of modifying origin ones.

### Customized deep copy methods
Of course you can implement your own deep copy helper functions, actually several popular libs like jQuery, backbone, underscore, all have their own clone or extend methods to help you do deep copy.