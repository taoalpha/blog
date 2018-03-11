date: 2016-01-11 7:00:00
title: ES6 Quiz With Answer
category: tech
description: 
tags: []
series: 
author: Dmitry Soshnikov
---

[orginal post](https://gist.github.com/DmitrySoshnikov/3928607cb8fdba42e712)

### @kangax's ES6 quiz, explained

[@kangax](https://twitter.com/kangax) created a new [interesting quiz](http://perfectionkills.com/javascript-quiz-es6/), this time devoted to ES6 (aka ES2015). I found this quiz very interesting and quite hard (made myself 3 mistakes on first pass).

Here we go with the explanations:

##### Question 1:

```javascript
(function(x, f = () => x) {
  var x;
  var y = x;
  x = 2;
  return [x, y, f()];
})(1)
```

- <span style="color: green;">**[2, 1, 1]**</span>
- [2, undefined, 1]
- [2, 1, 2]
- [2, undefined, 2]

The most complex question for me in this quiz. I didn't get it right initially until read the [spec](http://www.ecma-international.org/ecma-262/6.0/index.html#sec-functiondeclarationinstantiation) and [clarified](https://twitter.com/DmitrySoshnikov/status/662035788826337281) with [@kangax](https://twitter.com/kangax). First I answered `[2, undefined, 1]`, which is _"almost correct"_, except _one subtle thing_. The correct answer here is the first one, `[2, 1, 1]`, and let's see why.

[As we know](http://dmitrysoshnikov.com/ecmascript/es6-notes-default-values-of-parameters/#conditional-intermediate-scope-for-parameters), parameters create _extra scope_ in case of using [default values](http://dmitrysoshnikov.com/ecmascript/es6-notes-default-values-of-parameters/).

Parameter `f` is always the function (the default value, since it's not passed), and it _captures_ `x` exactly from the _parameters scope_, that is `1`.

Local _variable_ `x` _shadows_ the parameter with the same name, `var x;`. It's [hoisted](http://dmitrysoshnikov.com/notes/note-4-two-words-about-hoisting/), and is assigned default value... `undefined`? Yes, _usually_ it would be assigned value `undefined`, but not in this case, and this is the subtle thing we mentioned. If there is a parameter with the same name, then the local binding is initialized not with `undefined`, but with the value (including default) of that parameter, that is `1`.

So the variable `y` gets the value `1` as well, `var y = x;`.

Next assignment to local variable `x` happens, `x = 2`, and it gets value `2`.

By the time of the return, we have `x` is `2`, `y` is `1`, and `f()` is also `1`. It's also a tricky part: since `f` was created in the scope of parameters, its `x` refers to the _parameter_ `x`, which is still `1`.

And the final return value is: `[2, 1, 1]`.

---

##### Question 2:

```javascript
(function() {
  return [
    (() => this.x).bind({ x: 'inner' })(),
    (() => this.x)()
  ]
}).call({ x: 'outer' });
```

- ['inner', 'outer']
- <span style="color: green;">**['outer', 'outer']**</span>
- [undefined, undefined]
- Error

Arrow functions have _lexical `this`_ value. This means, they inherit `this` value from the context they are _defined_. And later it stays _unchangeable_, even if explicitly _bound_ or called in a different context.

In this case both arrow functions are created within the context of `{x: 'outer'}`, and `.bind({ x: 'inner' })` applied on the first function doesn't make difference.

So the answer is: `['outer', 'outer']`.

---

##### Question 3:

```javascript
let x, { x: y = 1 } = { x }; y;
```

- undefined
- <span style="color: green;">**1**</span>
- { x: 1 }
- Error

Variable `y` will eventually have value `1` since:

First, `let x` defines `x` with the value `undefined`.

Then, _destructuring assignment_ `{ x: y = 1 } = { x }` on the _right hand side_ has a _short notation_ for an object literal: the `{x}` is equivalent to `{x: x}`, that is an object `{x: undefined}`.

Once it's destructured the pattern `{ x: y = 1 }`, we extract variable `y`, that corresponds to the property `x`. However, since property `x` is `undefined`, the _default value_ `1` is assigned to it.

So the answer is: `1`.

---

##### Question 4:

```javascript
(function() {
  let f = this ? class g { } : class h { };
  return [
    typeof f,
    typeof h
  ];
})();
```

- <span style="color: green;">**["function", "undefined"]**</span>
- ["function", "function"]
- ["undefined", "undefined"]
- Error

This [IIFE](http://benalman.com/news/2010/11/immediately-invoked-function-expression/) is executed with no explicit `this` value. In ES6 it means it will be `undefined` (the same as in [strict mode](http://dmitrysoshnikov.com/ecmascript/es5-chapter-2-strict-mode/#codethiscode-value-restrictions) in ES5).

So the variable `f` is bound to the `class h {}`. Its `typeof` is a `"function"`, since classes in ES6 is a _syntactic sugar_ on top of the constructor _functions_.

However, the `class h {}` itself is created in the _expression position_, that means its name `h` _is not added_ to the environment. And testing the `typeof h` should return `"undefined"`.

And the answer is: `["function", "undefined"]`.

---

##### Question 5:

```javascript
(typeof (new (class { class () {} })))
```

- "function"
- <span style="color: green;">**"object"**</span>
- "undefined"
- Error

This is an obfuscated syntax playing, but let's try to figure it out :)

First of all, since ES5 era, _keywords_ are allowed as _property names_. So on a simple object example, it can look like:

```javascript
let foo = {
  class: function() {}
};
```

And ES6 standardized _concise method definitions_, that allows dropping the `: function` part, so we get the:

```javascript
let foo = {
  class() {}
};
```

This is exactly what corresponds to the inner `class () {}` -- it's a _method_ inside a class.

The class itself is _anonymous_, so we can rewrite the example:

```javascript
let c = class {
  class() {}
};

new c();
```

Now, instead of assigning to the varialbe `c`, we can instantiate it directly:

```javascript
new class {
  class() {}
};
```

The result of a default class is always a simple object. And its `typeof` should return `"object"`:

```javascript
typeof (new class {
  class() {}
});
```

And the answer is: `"object"`.

---

##### Quetion 6:

```javascript
typeof (new (class F extends (String, Array) { })).substring
```

- "function"
- "object"
- <span style="color: green;">**"undefined"**</span>
- Error

Here we have a similar obfuscated example (but we already figured out this inlined `typeof`, `new`, and `class` thing above ;)), though the interesting part is the value of the `extends` clause. It's the: `(String, Array)`.

The grouping operator always returns its last argument, so the `(String, Array)` is actually just `Array`.

So what we've got here is:

```javascript
class F extends Array {}

let f = new F();

typeof f.substring; // "undefined"
```

Since array instances do not have `substring` method, and our extended class `F` didn't provide it either, the answer is `"undefined"`.

---

##### Question 7:

```javascript
[...[...'...']].length
```

- 1
- <span style="color: green;">**3**</span>
- 6
- Error

Here we deal with the [spread operator](http://exploringjs.com/es6/ch_parameter-handling.html#sec_spread-operator). It allows to _spread_ all the elements to the array. It can work with any _iterable_ object.

Strings are iterable, meaning that we can iterate over their chars (in this case char by char). So the inner `[...'...']` results to an array: `['.', '.', '.']`:

```javascript
let s = '...';

let a = [...s];

console.log(a); // ['.', '.', '.']
```

Array are iterable as well. So the _outer_ spread is applied on our new array:

```javascript
let result = [...a];

console.log(result); // ['.', '.', '.']
console.log(result.length); // 3
```

As we can see spreading the array happens element by element, so the resulting array just `copied` all the elements, and looks the same -- with just `3` string dots.

And the answer is: `3`.

---

##### Question 8:

```javascript
typeof (function* f() { yield f })().next().next()
```

- "function"
- "generator"
- "object"
- <span style="color: green;">**Error**</span>

In this example we encounter a [generator function](https://davidwalsh.name/es6-generators). When executed, they return a _generator object_:

```javascript
let g = (function* f() { yield f })();
```

Generator objects have `next` method, that returns the next value at the `yield` position. The returned value has _iterator protocol_ format:

```javascript:
{value: <returned value>, done: boolean};
```

So on first `next()` we get:

```javascript
g.next(); // {value: f, done: false}
```

As we see, the returned value _itself_ doesn't have method `next()`, so trying to call it _as a chain_ would result to an error:

```javascript
g.next().next(); // error
```

Notice though, that we could normally call it as:

```javascript
g.next(); // {value: f, done: true}
g.next(); // {value: undefined, done: true}
```

So the answer is: `Error`.

---

##### Question 9:

```javascript
typeof (new class f() { [f]() { }, f: { } })[`${f}`]
```

- "function"
- "undefined"
- "object"
- <span style="color: green;">**Error**</span>

The obfuscated example results to a Syntax Error since class name `f()` is not correct.

The answer is `Error`.

---

##### Question 10:

```javascript
typeof `${{Object}}`.prototype
```

- "function"
- <span style="color: green;">**"undefined"**</span>
- "object"
- Error

This one is very tricky :)

First, we deal with [template strings](https://ponyfoo.com/articles/es6-template-strings-in-depth).

They are capable to render values of variables directly in the strings:

```javascript
let x = 10;

console.log(`X is ${x}`); // "X is 10"
```

However, in the example we have something that looks a bit strange: it's not `${Object}` how it "should be", but the `${{Object}}`.

No, it's not another special syntax of template strings, it's still a _value_ inside `${}`, and the value is `{Object}`.

What is `{Object}`? Well, as we mentioned earlier above, ES6 has short notation for object literals, so in fact it's just the: `{Object: Object}` -- a simple object with the property named `"Object"`, and the value `Object` (the built-in `Object` constructor).

Now it's becoming more clear:

```javascript
let x = {Object: Object};
let s = `${x}`;

console.log(s); // "[object Object]"
```

See what's happened? The `${x}` is roughly equivalent to the:

```javascript
'' + x;

// or the same:

x.toString(); // "[object Object]"
```

Now, the string `"[object Object]"` obviously doesn't have property `prototype`:

```javascript
"[object Object]".prototype; // undefined

typeof "[object Object]".prototype; // "undefined"
```

So the answer is: `"undefined"`.

---

##### Question 11:

```javascript
((...x, xs)=>x)(1,2,3)
```

- 1
- 3
- [1,2,3]
- <span style="color: green;">**Error**</span>

This one is the simplest. [Rest parameters](http://exploringjs.com/es6/ch_parameter-handling.html#sec_rest-parameters) can appear _only_ at the _last_ postion. In this case `...x` goes as a first argument of an IIFE arrow function, so results to a Parse Error.

And the answer is: `Error`.

---

##### Question 12:

```javascript
let arr = [ ];
for (let { x = 2, y } of [{ x: 1 }, 2, { y }]) {
  arr.push(x, y);
}
arr;u
```

- [2, { x: 1 }, 2, 2, 2, { y }]
- [{ x: 1 }, 2, { y }]
- [1, undefined, 2, undefined, 2, undefined]
- <span style="color: green;">**Error**</span>

Several topics combined here: _destructuring assignment_, _default values_, and `for-of` loop.

However, we can quickly identify it's an error, because of ~~two~~ one thing:

**EDIT 1:** [@fkling42](https://twitter.com/fkling42) [pointed out](https://gist.github.com/DmitrySoshnikov/3928607cb8fdba42e712#gistcomment-1612938) that the variable `y` is in the environment, but _is not initialized_ yet (being under TDZ -- _Temportal Dead Zone_), and _that's the reason_ why it cannot be accessed

**EDIT 2:** [@getify](https://twitter.com/getify) [pointed out](https://twitter.com/getify/status/662050783945359360), that value `2` actually normally passes [RequireObjectCoercible](http://www.ecma-international.org/ecma-262/6.0/index.html#sec-requireobjectcoercible) check, and hence there would be no error in destructuring `let { x = 2, y } = 2;`.

- `{ y }` is a short notation of `{y: y}` ~~and will fail, since variable `y` doesn't exist in the scope;~~ The variable `y` is in the scope, but is under _TDZ_, so cannot be accessed
- (we wouldn't reach this, because of the frist error, but): trying to destructure `2` ~~will fail too~~ will not fail, since to object coercion will be normally applied.

So the answer is: `Error`.

---

##### Question 13:

```javascript
(function() {
  if (false) {
    let f = { g() => 1 };
  }
  return typeof f;
})();
```

- "function"
- "undefined"
- "object"
- <span style="color: green;">**Error**</span>

This example is only on attention, since it's a syntax error: the arrow function `=>` cannot be defined in this way, since we have a an object with the `g` (consice) method.

And the answer is: `Error`.

---

##### Conclusion

I like such tricky quiz questions, it's always fun to track the runtime semantics and parsing process manually. Of course, most of the things here are far from practical production code, and are interesting mostly from the theoretical viewpoint. Still I found it enjoyable.

I'll be glad to discuss all the questions in the comments.

Good luck with ES6 ;)

Written by: Dmitry Soshnikov

http://dmitrysoshnikov.com