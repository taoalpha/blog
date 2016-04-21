title: apply and call in JS
date: 2016-04-17 17:17:01-04:00
category: tech
tags: [JS,Apply,Call]
---

Function.call and Function.apply are two very important methods and you should be very familiar with them if you are good at functional javascript. The most important and the only purpose of these two methods is to convert one input to another.

These two methods are easy to use but also easy to confuse, people always forget which one they should use... I hope I can help you remember these two methods clearly through this post.

### Definition

Here I copy and paste the official definition of two methods from MDN:

**call**

{% blockquote MDN https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call Function.prototype.call %}

The call() method calls a function with a given this value and arguments provided individually.

Note: While the syntax of this function is almost identical to that of apply(), the fundamental difference is that call() accepts an argument list, while apply() accepts a single array of arguments.

**Syntax:**

fun.call(thisArg[, arg1[, arg2[, ...]]])

{% endblockquote %}

**apply**

{% blockquote MDN https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply Function.prototype.apply %}

The apply() method calls a function with a given this value and arguments provided as an array (or an array-like object).

Note: While the syntax of this function is almost identical to that of call(), the fundamental difference is that call() accepts an argument list, while apply() accepts a single array of arguments.

**Syntax:**

fun.apply(thisArg, [argsArray])

{% endblockquote %}

### Test and Clarify

Before I do the test, I hope you all remember the first thing: call accept multiple params, and apply accept an array. You can remember this by remember the **A** for apply and array. Easier ? :)

Here I wrote a simple test script to clarify two methods. The basic idea is to define a two different functions `giveMeArray` (accept an array as input) and `giveMeParams` (accept multiple params as input).

And then I try to run both methods with call and apply:

``` javascript
var giveMeArray = function(arr){
  console.log("running giveMeArray with arguments:");
  console.log(arguments);
  console.log("The arr currently is:");
  console.log(arr);
  arr.forEach(
    function(i) {console.log(i);}
  )
}

var giveMeParams = function(x,y,z){
  console.log("running giveMeParams with arguments:");
  console.log(arguments);
  console.log(x);
  console.log(y);
  console.log(z);
}

arr = [1,2,3];

// use apply to pass an array to giveMeArray
// giveMeArray.apply(null,arr)
// ERR!
// RESULT: pass arr to giveMeArray as three different params 

// use call to pass multiple params to giveMeArray
// giveMeArray.call(null,1,2,3)
// ERR!
// RESULT: pass all three params to giveMeArray individually

// use apply to pass an array to giveMeParams
giveMeParams.apply(null,arr)
// CORRECT!

// use call to pass multiple params to giveMeParams
giveMeParams.call(null,1,2,3)
// CORRECT!


// CONCLUSION:
// apply: pass the arr(the second params in apply) to origin function as multiple params 
// call: pass all params except the first one to origin function as multiple params 

// for giveMeArray if you have to it.
giveMeArray.apply(null,[arr]);
giveMeArray.call(null,arr);
```

Now everything seems pretty clear, right ?

### Conclusion

- apply: pass the arr(the second params in apply) to origin function as multiple params 
- call: pass all params except the first one to origin function as multiple params 

