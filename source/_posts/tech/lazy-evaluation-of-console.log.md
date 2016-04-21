title: Lazy Evaluation of console.log
date: 2016-04-21 14:54:22-04:00
category: tech
tags: [JS,Console]
---

### Story

Yesterday, I got a question from a friend who asked me to review his code and explain why the object he printed out got changed before he actually modifies it. This is a classic 'asynchronous' or lazy evaluation(more accuarately) problem of `console.log()`.

We all know that `console.log` is the most popular and common way to debug your javascript code since it is easy to use and easy to see the output, your eyes can not fool you, right ?

No, sometimes, your eyes will fool you, especially when we talk about the lazy evaluation.

### Test and Explain

Lets see some examples:

``` javascript
// under chrome 49.0
var obj = {}
obj.a = "hello"
console.log(obj)
obj["foo"] = "bar"

/* output without "foo"
{ a: 'hello' }
*/

var obj = {}
obj.a = "hello"
obj.b = []
console.log(obj)
obj["foo"] = "bar"

/* output with "foo"
{ a: 'hello', b: [], foo: 'bar' }
*/
```

Why !?

The main reason is because the `console.log` has different behaviors in two platforms. Although the the asynchronous or synchorouns of `console.log` depends on the platforms, but normally  when you call `console.log`, your arguments are always referenced and computed right away, but the display or render process is definitely asynchronous, so it needs to find a place to store the data. Either the console clone the the mutable objects that you did log, or it will store a reference to them. But for complicated objects, the first method would not work properly since it will take time and memory, so for complicated objects, the console will store a reference to them. And the time you see the result of rendering, you always see the current state of the object, but the current state maybe not be the state that you call the `console.log` function.

So how to avoid this 'mistake' ? Here are several ways:

1. Use nodeJS.
  The Console class holds all methods and api for simulating the console in browsers and console functions are asynchronous unless the destination is a file. But maybe because it don't need to render (just output to the stream), so things like above will not appear in Node.
2. Use stringify before logging.
  This would work for not so deep objects, since it will force console to store the data instead of reference.


Here is the same code running under Node.

``` javascript

// under node 5.1.0

var obj = {}
obj.a = "hello"
console.log(obj)
obj["foo"] = "bar"

/* output without "foo"
{ a: 'hello' }
*/

var obj = {}
obj.a = "hello"
obj.b = []
console.log(obj)
obj["foo"] = "bar"

/* output without "foo"
{ a: 'hello', b: [] }
*/
```

Cool ?! :)
