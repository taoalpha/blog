date: 2015-11-11 3:00:00
title: Strict Mode in JavaScript
category: tech 
description: Some of you may have already seen some use of the strict mode before, but I believe most of the people don't actually know much about the strict mode.
tags: [JS] 
language: en
author: taoalpha
---

## Introduction

`'use strict'` is a new feature introduced from ECMAScript 5, it is not a subset of js, it has some different semantics from normal code. So be careful to use it.

## What is the difference?

After you insert the `'use strict'` into the head of your entire code or in the beginning of the function code.

``` javascript

// Whole-script strict mode syntax
"use strict";
var v = "Hi!  I'm a strict mode script!";

// function-level
function strict(){
  // Function-level strict mode syntax
  'use strict';
  function nested() { return "And so am I!"; }
  return "Hi!  I'm a strict mode function!  " + nested();
}
function notStrict() { return "I'm not strict."; }
```

And since "use strict" only validate when you insert it into the head of the script when you want to do whole-script strict mode, so be careful to concatenate scripts if you are using strict mode since concatenate strict mode with non-strict mode scripts will be strict and concatenate non-stricct with strict will be non-strict.

### Fail aloud

We all know javascript is a really nice language that it will fail silently in most of times not breaking the interaction. But it will also cause some troubles for debugging... Now we have strict mode which will convert all mistakes into errors, so your javascript will not fail silently in strict mode.

So what kind of mistakes will be converted into errors in strict mode?

- Declare variable first - in strict mode, you can't use assignment without `var` to create a global varibale anymore;
- Assign value to non-writable variable or a getter-only property, non-extensible object..etc, will throw an error;
- Delete an undeletable property will throw an error;
- All property name in an object must be unique;
- Parameters in a function can not be duplicate;
- ECMAScript 5 fobids the octal syntax(starts with 0), but ES6 brings it back with prefix: '0o';

### Simplifying variable uses

- Prohibit `with` - because you could never know the properties in it is mapped to which object until you run the code;
- `eval` with strict mode will not introduct variables in it to the surrounding scope;
- Forbid deleting on plain names(most are primitive variables);
- `eval` and `arguments` can not be overwrite with assignment;
- no alias for `arguments`, so the arguments in a function can only be changed by assigning to `arguments[i]`;
- `arguments.callee` is no longer supported;

> Relatedly, if the function eval is invoked by an expression of the form eval(...) in strict mode code, the code will be evaluated as strict mode code.

I remembered someone told me a golden rule about eval in strict mode before : Don't use it. :)

### "Securing" JavaScript

Since before and in normal mode, all functions declared will has the global (window in browser) as `this` by default if they are not invoked by an object.

But in strict mode, functions invoked without an object will have a default `this` as undefined or null;

``` javascript
"use strict";
function fun() { return this; }
// this will be undefined in strict mode, but in normal mode, it will be the global this
```

But you still can use `call()`,`apply()`,`bind()` to specify a particular this.


And you can not use function.caller and function.arguments to refer the function itself or its arguments within the function code anymore. (actually in normal code in advance browsers, you can not use these either)

### Reserved Keywords

In strict mode, you will have some reserved keywords that maybe implemented in future js. Here is a list of them:

`implements, interface, let, package, private, protected, public, static, and yield`.

So don't use them in strict mode to be names of your variables.


### Others

In strict mode, a function statements has to be the top level of a script or function.(in normal mode, functions statements are permitted everywhere..)

So you can not declare a function within a if statements or for loop...


## Referrence

- [Strict mode - MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mode)
