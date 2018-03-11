date: 2016-08-27 7:00:00
title: Type check in JS
category: tech
description: how to do type check in JS
tags: [js,type check]
author: taoalpha
---

JavaScript is a loosely typed language which means it doesn’t care type too much. Most times, it can convert different types automatically for us. But sometimes, you may actually need to know the exact type of a variable. And you may have trouble to do that in JS…

(We will only focus on normal types, a lot new types introduced by ES6 like ArrayBuffer, Map, Set, Int8Array, Promise … will not be covered in this post.)

## Types
In general, you can consider everything in JS is an object, except for the undefined. That’s why you can use dot on any type of variables and it will not throw error but give you undefined if you use on string/number/boolean.

``` javascript
"a".a;  // undefined
1..a;  // undefined, use .. since first . will be recognize as end of the string(float)
true.a;  // undefined
```

But when you call typeof on different types, it may give you different results and sometimes, it may surprise you. That’s why we need to know how to check the type of a variable.

### Primitive Types

Like many other langauges in the world. JS has several primitive types like: string, boolean, there is not so many differences we can talk about. Except for these two common types, JS has a shared type for all numbers: int, float… which is number. JS stores all number in the float number format, and they all have the same type. So if you check: 1 === 1.0, it will give you true since they are both number with same value.

Normally, we consider undefined and null as primitive too. The difference between them are subtle: former one means the variable has not been initialized, and latter one means the value is null.

In ES6, we have a new primitive type called: symbol, which is a unique and immutable data type and may be used as an identifier for object properties, so there will not be two same symbols in the world.

### Objects
Except all above, JS has only one other type: object. Actually, even all these primitive types: string, number, boolean, symbol, have their own constrcutors, and they are all objects, even null is an object type too.

If we dive into the object type, we can have several small branches (consider them all as a special object, like they all extend the object and define their special methods then):

#### Array
Like any other languages, array in JS use continuous integers as indexes to store any type of data with them. And array has a lot of native methods defined in their prototype. Use typeof on Array will give you object, so you can not use it to identify Array. But any declared array will have an constructor as Array, you may want to use it to identify its type.

Start from ES5, every array has a special method called isArray() to check whether its an array or not.

``` javascript
let a = [1, 2];

typeof a === "object";  // true

// all below need to make sure a is defined before checking its type
Object.prototype.toString.call(a);  // "[object Array]"
a.constructor === Array;  // true
// ES5 +
a.isArray();  // true
```
#### Function
Unlike Array, Function does have its own type as function, so you can use typeof on them. Besides, you can also use other methods:

``` javascript
let a = function() {};

typeof a === "function";  // true

// all below need to make sure a is defined before checking its type
Object.prototype.toString.call(a);  // "[object Function]"
a.constructor === Function;  // true
```

#### RegExp
Similar with Array, use typeof on a regular expression will also give you object.

``` javascript
let a = /a/g;

typeof a === "object";  // true

// all below need to make sure a is defined before checking its type
Object.prototype.toString.call(a);  // "[object RegExp]"
a.constructor === RegExp;  // true
```
#### Math
Math is a special global object in JS. Its not a Function object, its more like a static gloabl object. You can refer it or its properties/methods by using dot on it.

``` javascript
let a = Math;

typeof a === "object";  // true

// all below need to make sure a is defined before checking its type
Object.prototype.toString.call(a);  // "[object Math]"
```
#### Date
Unlike Math, Date is a Function object, so if you use Object.prototype.toString.call(Date), it will give you [object Function].

``` javascript
let a = new Date();

typeof a === "object";  // true

// all below need to make sure a is defined before checking its type
Object.prototype.toString.call(a);  // "[object Date]"
a.constructor === Date;  // true
```
#### Error
Same as Date, Error is a Function object too.

``` javascript
let a = new Error();

typeof a === "object";  // true

// all below need to make sure a is defined before checking its type
Object.prototype.toString.call(a);  // "[object Error]"
a.constructor === Error;  // true
```
There also have some special Error objects like InternalError, but they are not supported so widely(even chrome does not support them), so I won’t cover them here either.

#### Null
null is an object, since you use typeof on it, it will return object to you. But its special, it does not have any constructor, so you have use some other ways to identify them:

``` javascript
let a = null;

typeof a === "object";  // true

// easies way is use strong equal to check on null
a === null;   // true
// or use toString
Object.prototype.toString.call(a);  // "[object Null]"
```
#### Object
Normally if you are sure its not all types above and it does exist(not a undefined), it has to be an object. :) But you can still check it if you want:

``` javascript
let a = {};

typeof a === "object";  // true

// all below need to make sure a is defined before checking its type
Object.prototype.toString.call(a);  // "[object Object]"
a.constructor === Object;  // true
```

## End
Cool! Now you know how to identify all different types in JS, at least normal types :)

If you like to coding for practice, you can build you own typeCheck module and pushed to NPM :)