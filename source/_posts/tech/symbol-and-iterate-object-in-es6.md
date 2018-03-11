date: 2016-04-28 7:00:00
title: Symbol and Iterate Object in ES6
category: tech
description: Symbol and Iterate Object in ES6
tags: [js,es6,symbol]
series: The way I learn JS
author: taoalpha
---

## Write Ahead
ES6 introduces a new primitive type into JavaScript which is Symbol. All symbols are unique so you can treat them as tokens server as unique id.

You can create a symbol using its factory function Symbol(), you can pass a parameter to it as the name of the symbol, but most of time, the name is only used to debug, you can not access a symbol with name.

## What Symbol can do
### As property keys
As a primitive value, if we use typeof on a symbol, we get symbol. And also symbols can be used as property keys for constructing objects. So in ES6, for properties in objects, the definition changes to:

- Property keys are either strings or symbols;
- Property names are strings;

So we have a few new methods for objects and some changes on old methods.

``` javascript
// from 2ality
let obj = {
  [Symbol('my_key')]: 1,
  enum: 2,
  nonEnum: 3
};

// change nonEnum to not enumerable
Object.defineProperty(obj,
    'nonEnum', { enumerable: false });
}

Object.getOwnPropertyNames(obj)
// you got: ['enum', 'nonEnum'], since names can only be strings

Object.getOwnPropertySymbols(obj)
// you got: [Symbol(my_key)], since only symbols you want

Reflect.ownKeys(obj)
// you got everything: [Symbol(my_key), 'enum', 'nonEnum'], Reflect is a new global object introduced by ES6

Object.keys(obj)
// you got: ['enum'], since only enumerable keys will be returned
```

### As unique constants
And since the symbols are all unique, so we can use symbols create a unique bindings, like this:

``` javascript
const COLOR_RED    = Symbol();
const COLOR_ORANGE = Symbol();
const COLOR_YELLOW = Symbol();
const COLOR_GREEN  = Symbol();
const COLOR_BLUE   = Symbol();
const COLOR_VIOLET = Symbol();
```

Now we have a binding that much powerful and strict than strings.

## Symbol.iterator
Symbol.iterator is a special symbol that defines the iterator for your object. Currently some built-in types like Array, Map, Set, String and TypedArray have its default iteration behavior, but others don’t. So you can use Symbol.iterator define your own iterator for your object.

``` javascript
let obj = {
  data: [ 'hello', 'world' ],
  [Symbol.iterator]() {
    const self = this;
    let index = 0;
    return {
      next() {
        if (index < self.data.length) {
          return {
            value: self.data[index++]
          };
        } else {
          return { done: true };
        }
      }
    };
  }
};

// then you can use for ... of to iterate the value you have
for (let x of obj) {
  console.log(x);
}
// hello
// world


// You should find that the [Symbol.iterator] is a generator function, so you can simplify this method as follow:

let obj = {
  data: [ 'hello', 'world' ],
  *[Symbol.iterator]() {
    const self = this;
    let index = 0;
    while (index < self.data.length){
      yield self.data[index++];
    }
  }
}
```

### Retrieve the string from symbol
sometimes you will want to retrieve the string you pass to creating a symbol, you can use Symbol.for() and Symbol.keyFor().

``` javascript
let sym = Symbol.for('Hello everybody!');
Symbol.keyFor(sym);
// "Hello everybody!"
```

## Summary
Symbol is a pretty cool stuff we have in ES6, you may come up with a lot of tricks and useful tips based on the unique of symbols.

Thanks for [Symbols in ECMAScript 6](http://www.2ality.com/2014/12/es6-symbols.html) from [②ality – JavaScript](http://www.2ality.com/) and more and my favorite [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript).