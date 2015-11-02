---
layout: post
title: Array Operation Cost in JavaScript 
category: tech 
description: Array would be one of the most frequently used data structures in javascript.
tags: [JS,Array,Data Structure] 
series: JavaScript Performance
author: taoalpha
language: en
---

## Introduction

`concat()`,`splice()`,`slice()`,`push()`,`pop()`,`shift()`,`unshift()`... all these handy functions belong to Array. We are using them everyday, but do you really know about them ? Time cost of a function in language like JavaScript is not easy to measurement, since different browsers use different javascript engine which will cause different implementation on same functions. But, normally, the basic operations will be the same.

So today, I will test some basic array operations on NodeJS and compare the time cost between these operations.

**TEST ENVIRONMENT:** Mac Air, iTerm, NodeJS v4.1.1

## Constructor

We all know that we have several different ways to construct an array, the most frequently used are two methods I list below:

- Literal notation : `[ele1,ele2,...]`
- `new` function : `new Array(ele1,ele2,...)` or `new Array(length_of_array)`

Normally there are no difference between these two methods. But if you are dealing with some real big datasets and you know exactly how long your array is and want to save a few time for some basic operations, you may should continue reading.

The fundamental difference between these two methods is : literal notation declare an array with elements in it, `new Array(ele1,ele2,...)` will do exactly the same, but `new Array(length_of_array)` will only declare a length of a array(and create or allocate a memory for this array with its length).

Here is a gif about the memory allocation will give you a clear understanding about it.

![bad allocate](https://gamealchemist.files.wordpress.com/2013/05/array.png)

The advantage of declaring with allocating is that it can improve the speed of constructing an array.

As test I did, to construct a 100000 array with 0-99999 (average time cost):

- Use literal notation with push(): 8ms
- Use literal notation with unshift(): 2230ms
- Use literal notation with assigning directly by index: 5ms 
- Use `new Array(100000)` with assigning directly by index: 2ms
- Use literal notation with assigning length first then assigning directly by index : 2ms

Apparently, it would save you some time if you declare the length before you assign the values.And if you don't like to use the `new`, you can still use literal notation and set the length manually.

{% highlight javascript %}
// time cost for array constructing
var i = 0
var ar = []
var arr = new Array(100000)

i = 0
console.time("Literal notation with assigning directly")
while(i<=99999){
  ar[i] = i
  i++
}
console.timeEnd("Literal notation with assigning directly")

i = 0
ar = []
console.time("Literal notation with push()")
while(i<=99999){
  ar.push(i)
  i++
}
console.timeEnd("Literal notation with push()")

ar = []
console.time("Literal notation with unshift()")
while(i>=0){
  ar.unshift(i)
  i --
}
console.timeEnd("Literal notation with unshift()")

i = 0
ar = []
ar.length = 100000
console.time("Literal notation with declaring length first")
while(i<=99999){
  ar[i] = i
  i++
}
console.timeEnd("Literal notation with declaring length first")

i = 0
console.time("Using new with length defined")
while(i<=99999){
  arr[i] = i
  i++
}
console.timeEnd("Using new with length defined")
{% endhighlight %}


## delete and remove

JavaScript does have a keyword for deleting: delete. For array, when you use `delete ar[i]`, you actually assign `ar[i] = undefined`. I recommend you to use the second method since it is a little faster.

Test on 100000-length list (delete all elements):

- Delete with "delete" keyword: 11ms
- Delete with assigning "undefined" to the value: 2ms

Both of the two methods would not change the length of the array, but we can also use "pop()", "shift()" to empty an array.

Test on 100000-length list (remove all elements):

- remove with "pop()": 5ms 
- remove with "shift()": 18ms
- remove with splice() : 25ms

So, the shift() will cost near 3 times of pop() and splice() even slower. 

Of course, under different conditions, you will choose different methods to achieve what you want.

## other native functions

I did some tests on other basic native functions too. Here are the results:

- splice() to insert 1000 elements into a 100000-length list : 60ms 
- concat() two 100000-length lists : 1ms
- Use while loop and push to concat two 100000-length lists : 8ms
- slice() to hard copy one 100000-length list : 1ms
- Use while loop and push to hard copy one 100000-length list : 8ms
- Use while loop and assign value with predefined length to copy one 100000-length list : 2 (same as constructing part)
- indexOf() to search every element in a 100000-length list (the smaller the index is, the sooner it will be): 4600ms 
- Use while loop to achieve the search : 7300ms
- Reverse (ordered list like 0 - 99999) : 1ms
- Reverse (ordered list like 99999 - 0) : 100ms (this is weird...)

Most of time, the native functions are the best methods to do the operation since the engine already done a lot to optimize them.


## Summary

Sometimes you will think these small difference between different methods is not important, since the technology is growing so fast, the difference will become so small that we can just ignore them. That's 100% correct!

I did these just because I am curious and sometimes, if you are dealing with a really large dataset, then maybe the nanoseconds count and you may want to use some small changes to optimize your code. Why don't you always keep your code optimized all the time?


That's all!
