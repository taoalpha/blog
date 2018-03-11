date: 2016-01-09 7:00:00
title: JavaScript Coding Style
category: read
description: some thoughts and notes after finish reading JS Coding Style posts
tags: [coding style,js]
author: taoalpha
---

## Why and What is Coding Style

Coding style is like the common styles and patterns that are used in your personal codebase or some organizations’ codebase, its purpose is making your code more readable and reusable through the entire developemnt, especially when you work in a team. Everyone can create their own coding style, there is no right or wrong among them, like you prefer 4 spaces than 2 spaces, you like to use camelCase represent the functions and variables,that’s totally fine.

The benefit of using the same style is obvious, it can save you a lot of time reading and modifying others’ code or even your own code. There are some styles that are pretty popular and agreed by a lot of people and team, like [Google Style Guide](https://github.com/google/styleguide). Being modified and updated for so many years, I believe these styles would be a better choice to choose rather than create one by yourself.

## Javascript Style Guide

There are several popular style guide for javascript, one is the part of the Google Style Guide series: [Google JavaScript Style Guide](https://google.github.io/styleguide/javascriptguide.xml), another is created by airbnb: [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript), and also there is a [Code Conventions for the JavaScript Programming Language](http://javascript.crockford.com/code.html) created by the author of JavaScript: [The Good Parts](http://www.amazon.com/exec/obidos/ASIN/0596517742/wrrrldwideweb).

I read them all and summarize the core parts here.

### Google JavaScript Style Guide

Here I ignore all parts related to the Google Closure Compiler, if you are interested in, take a look at [Closure Compiler](https://developers.google.com/closure/compiler/docs/js-for-compiler).

#### Syntax & Basic Concept

- var: never declare a variable without var to save you from global variables;
- semicolons: always use semicolons, sometimes the closing brackets are not enough to signal the end of the statement: Javascript never ends a statement if the next token is an infix or bracket operator;
- new: Never use wrapper objects for primitive types(like new Boolean(false), return an object!), but can use Boolean(0) to do casting, also for array and object, use literal syntax instead of new;
- prototye: Use prototype to attach methods to an object created via new, initialize other properties within constructor,Current JavaScript engines optimize based on the “shape” of an object, adding a property to an object (including overriding a value set on the prototype) changes the shape and can degrade performance., and NEVER modify prototype of builtins like Object and Array;
- delete: Use set to null instead of delete to delete some properties, but if the number of properties of the object matters, use delete;
- closure: Be careful to use closure since it might cause memory leak;
- eval,with(){}: Just don’t use them;
- for-in-loop: Only use it to iterate the key of object/hashmap;
- quote: Use single quote '' for strings, use string concatenation if the string is too long;

#### Naming

- CONSTANT_NAME: always use ALL_CAP_SNAKE_CASE represent the constant;
- functionName,variableName,methodName: use camelCase represent the functions and variables, methods;
- ClassName,EnumNamesLikeThis: use CamelCase represent class or enums;
- filenameslikethis.js: use plain lowercase as the name of the files;
- _private: private should be named with a trailing underscore;
- opt_: Optional function arguments start with opt_;
- global: try not to contaminate the global, can use a global object to store all variables you want to use as gloabl scope - prevent some conflicts between global and local;

#### Comments & JSDoc

Just remmeber that comments is written for someone who isn’t familiar with the code including youself after a long time!

Here is some resouces about the [JSDoc](http://usejsdoc.org/).

#### Tips

##### Some Boolean Expressions
```
Boolean('0') == true
'0' != true
0 != null
0 == []
0 == false
Boolean(null) == false
null != true
null != false
Boolean(undefined) == false
undefined != true
undefined != false
Boolean([]) == true
[] != true
[] == false
Boolean({}) == true
{} != true
{} != false
```

##### Better For Loop

```
var paragraphs = document.getElementsByTagName('p');
for (var i = 0, paragraph; paragraph = paragraphs[i]; i++) {
  doSomething(paragraph);
}
```

##### BE CONSISTENT

### Airbnb JavaScript Style Guide

I will address some difference between this one and google’s.

#### Syntax & Basic Concept

- const: Alwasy use const on references instead of var, ensure that you can not reassign your reference, Block-scoped;
- let: If you must reassign references, use let instead of var, Block-scoped;
- reserved words: don’t use reserved words as keys;
- object shorthand: use object shorthand for method and value defined in an Object, and also put all shorthands at the beginning of the object declaration;

``` javascript
// method
const atom = {
  value: 1,

  addValue(value) {
    return atom.value + value;
  },
};

// value, if value and key are the same
// put all shorthands at the beginning
// only quote properties that are invalid identifiers
const obj = {
  lukeSkywalker,
  foo: 3,
  bar: 4,
  'data-blah': 5,
};
```

- spreads: Use ... to copy arrays: const itemsCopy = [...items];
- Array.from(): Use Array.from() convert an array-like object to an array;
- destructuring: Use object and array destructuring when accessing and using multiple properties of an object;

``` javascript
// good
function getFullName(user) {
  const { firstName, lastName } = user;
  return `${firstName} ${lastName}`;
}
// best
function getFullName({ firstName, lastName }) {
  return `${firstName} ${lastName}`;
}

// array destructuring
const arr = [1, 2, 3, 4];
const [first, second] = arr;


// Prefer object destructuring for multiple return values to array destructuring
// good
function processInput(input) {
  // then a miracle occurs
  return { left, right, top, bottom };
}

// the caller selects only the data they need
const { left, right } = processInput(input);
```

- template strings: When programmatically building up strings, use template strings instead of concatenation;
- functions declarations: Use function declarations instead of function expressions, when you must use function expressions (as when passing an anonymous function), use arrow function notation;

``` javascript
// bad
const foo = function () {
};
// good
function foo() {
}

// use arrow functions as function expressions
// immediately-invoked function expression (IIFE)
(() => {
  console.log('Welcome to the Internet. Please follow me.');
})();


// No function declarations should be in a block
// bad
if (currentUser) {
  function test() {
    console.log('Nope.');
  }
}

// good
let test;
if (currentUser) {
  test = () => {
    console.log('Yup.');
  };
}
```

- arguments: Don’t use it, use ...args instead;

``` javascript
function concatenateAll(...args) {
  return args.join('');
}
```  

- `default value`: Use default parameter syntax rather than mutating function arguments, and always put default parameters last;

``` javascript
function handleThings(name, opts = {}) {
  // ...
}
```

- spacing: put space between function name and the brackets and curly brackets;
- parameter: Never mutate parameters, Never reassign parameters;

``` javascript
// bad
function f1(obj) {
  obj.key = 1;
};

// good
function f2(obj) {
  const key = Object.prototype.hasOwnProperty.call(obj, 'key') ? obj.key : 1;
};
```

- arrow functions:
  - If the function body consists of a single expression, omit the braces and use the implicit return. Otherwise, keep the braces and use a return statement;
  - and if the expression spans over multiple lines, wrap it in parentheses;
  - If your function takes a single argument and doesn’t use braces, omit the parentheses;

``` javascript
// good
[1, 2, 3].map(number => `A string containing the ${number}.`);

// bad
[1, 2, 3].map(number => {
  const nextNumber = number + 1;
  `A string containing the ${nextNumber}.`;
});

// good
[1, 2, 3].map( (number) => {
  const nextNumber = number + 1;
  return `A string containing the ${nextNumber}.`;
});

[1, 2, 3].map(number => (
  `As time went by, the string containing the ${number} became much ` +
  'longer. So we needed to break it over multiple lines.'
));
```

- class: Always use class. Avoid manipulating prototype directly;
- extends: Use extends for inheritance;
- methods: Methods can return this to help with method chaining;

``` javascript
// good
class PeekableQueue extends Queue {
  peek() {
    return this._queue[0];
  }
}
```

- import: Always use modules (import/export) over a non-standard module system. You can always transpile to your preferred module system, which means don’t use require etc;
  - Do not use wildcard imports;
  - And do not export directly from an import;

``` javascript
// bad
import * as AirbnbStyleGuide from './AirbnbStyleGuide';

// good
import AirbnbStyleGuide from './AirbnbStyleGuide';

// bad
// filename es6.js
export { es6 as default } from './airbnbStyleGuide';

// good
// filename es6.js
import { es6 } from './AirbnbStyleGuide';
export default es6;
```

- iterators and generators:
  - Don’t use iterators. Prefer JavaScript’s higher-order functions like map() and reduce() instead of loops like for-of;
  - Don’t use generators for now.

``` javascript
const numbers = [1, 2, 3, 4, 5];

// bad
let sum = 0;
for (let num of numbers) {
  sum += num;
}

sum === 15;

// good
let sum = 0;
numbers.forEach((num) => sum += num);
sum === 15;

// best (use the functional force)
const sum = numbers.reduce((total, num) => total + num, 0);
sum === 15;
```

- properties:
  - Use dot notation when accessing properties;
  - Use subscript notation [] when accessing properties with a variable;
- variables:
  - Always use const to declare variables. Not doing so will result in global variables. We want to avoid polluting the global namespace. Captain Planet warned us of that;
  - Use one const declaration per variable;
  - Group all your consts and then group all your lets;
  - Assign variables where you need them, but place them in a reasonable place;
- hoisting:
  - var declarations get hoisted to the top of their scope, their assignment does not;
  - const and let declarations are blessed with a new concept called Temporal Dead Zones (TDZ);
  - It’s important to know why typeof is no longer safe;
  - Anonymous function expressions hoist their variable name, but not the function assignment;
  - Named function expressions hoist the variable name, not the function name or the function body;
  - Function declarations hoist their name and the function body;

``` javascript
// using const and let
function example() {
  console.log(declaredButNotAssigned); // => throws a ReferenceError
  console.log(typeof declaredButNotAssigned); // => throws a ReferenceError
  const declaredButNotAssigned = true;
}

// assignment will not be hoisted
function example() {
  console.log(anonymous); // => undefined

  anonymous(); // => TypeError anonymous is not a function

  var anonymous = function () {
    console.log('anonymous function expression');
  };
}

function example() {
  console.log(named); // => undefined

  named(); // => TypeError named is not a function

  superPower(); // => ReferenceError superPower is not defined

  var named = function superPower() {
    console.log('Flying');
  };
}

// the same is true when the function name
// is the same as the variable name.
function example() {
  console.log(named); // => undefined

  named(); // => TypeError named is not a function

  var named = function named() {
    console.log('named');
  }
}

// BUT! Function declarations hoist their name and the function body.
function example() {
  superPower(); // => Flying

  function superPower() {
    console.log('Flying');
  }
}
```

- Comparison Operators & Equality:
  - Use === and !== over == and !=;
  - Conditional statements such as the if statement evaluate their expression using coercion with the ToBoolean abstract method and always follow these simple rules:
  - Objects evaluate to true
  - Undefined evaluates to false
  - Null evaluates to false
  - Booleans evaluate to the value of the boolean
  - Numbers evaluate to false if +0, -0, or NaN, otherwise true
  - Strings evaluate to false if an empty string ‘’, otherwise true

#### Comments
- Use /** ... */ for multi-line comments. Include a description, specify types and values for all parameters and return values;
- Use // for single line comments. Place single line comments on a newline above the subject of the comment. Put an empty line before the comment unless it’s on the first line of a block;
- Prefixing your comments with FIXME or TODO helps other developers quickly understand if you’re pointing out a problem that needs to be revisited, or if you’re suggesting a solution to the problem that needs to be implemented. These are different than regular comments because they are actionable. The actions are FIXME – need to figure this out or TODO – need to implement;

``` javascript
/**
 * make() returns a new element
 * based on the passed in tag name
 *
 * @param {String} tag
 * @return {Element} element
 */
function make(tag) {

  // ...stuff...

  return element;
}
```

#### Spaces
- Use soft tabs set to 2 spaces;
- Place 1 space before the leading brace;
- Place 1 space before the opening parenthesis in control statements (if, while etc.). Place no space between the argument list and the function name in function calls and declarations;
- Set off operators with spaces;
- End files with a single newline character;
- Use indentation when making long method chains. Use a leading dot, which emphasizes that the line is a method call, not a new statement;
- Leave a blank line after blocks and before the next statement;
- Do not pad your blocks with blank lines;
- Do not add spaces inside parentheses;
- Do not add spaces inside brackets;
- Add spaces inside curly braces;
- Avoid having lines of code that are longer than 100 characters (including whitespace);

#### Commas and Semicolons
- Leading commas: NOPE;
- Additional trailing comma: Yup;
- Always use semicolons;

``` javascript
// good (guards against the function becoming an argument when two files with IIFEs are concatenated)
;(() => {
  const name = 'Skywalker';
  return name;
})();
```

#### Type Casting & Coercion
- Perform type coercion at the beginning of the statement, use String,Number etc instead of other tricky methods;
- If for whatever reason you are doing something wild and parseInt is your bottleneck and need to use Bitshift for performance reasons, leave a comment explaining why and what you’re doing;
- Be careful when using bitshift operations. Numbers are represented as 64-bit values, but Bitshift operations always return a 32-bit integer (source). Bitshift can lead to unexpected behavior for integer values larger than 32 bits;

``` javascript
// good
/**
 * parseInt was the reason my code was slow.
 * Bitshifting the String to coerce it to a
 * Number made it a lot faster.
 */
const val = inputValue >> 0;

// be careful
2147483649 >> 0 //=> -2147483647
```

#### Naming
- Avoid single letter names. Be descriptive with your naming;
- Use camelCase when naming objects, functions, and instances;
- Use PascalCase when naming constructors or classes;
- Use a leading underscore _ when naming private properties;
- Don’t save references to this. Use arrow functions or Function#bind;
- If your file exports a single class, your filename should be exactly the name of the class;
- Use camelCase when you export-default a function. Your filename should be identical to your function’s name;
- Use PascalCase when you export a singleton / function library / bare object;
``` javascript
// bad
function foo() {
  const that = this;
  return function () {
    console.log(that);
  };
}

// good
function foo() {
  return () => {
    console.log(this);
  };
}
```
#### Accessors
- Accessor functions for properties are not required;
- If you do make accessor functions use getVal() and setVal(‘hello’);
- If the property is a boolean, use isVal() or hasVal();
- It’s okay to create get() and set() functions, but be consistent;
- jQuery
- Prefix jQuery object variables with a $;
- Cache jQuery lookups;
- For DOM queries use Cascading $('.sidebar ul') or parent > child $('.sidebar > ul');
- Use find with scoped jQuery object queries;

``` javascript
// good
function setSidebar() {
  const $sidebar = $('.sidebar');
  $sidebar.hide();

  // ...stuff...

  $sidebar.css({
    'background-color': 'pink'
  });
}
```

#### Testing
- You should write testing!!!

### Code Conventions for the JavaScript Programming Language

All coved by two styles I list above.

## Summary
Compared to google’s old style guide, airbnb’s style guide has much more valuable new ES6 styles, if you are an active ES6 users, I strongly suggest you use airbnb’s style !!!

Even you are a solo worker, you should use some common styles, it is a good habit and you should have.
