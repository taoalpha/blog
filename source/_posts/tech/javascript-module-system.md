title: Javascript Module Standard
date: 2016-06-17 11:35:23-04:00
category: tech
tags: [JS, Module]
---

## History

Like [brianleroux](https://medium.com/@brianleroux) said in his post [ES6 Modules: The End of Civilization As We Know It?](https://medium.com/@brianleroux/es6-modules-amd-and-commonjs-c1acefbe6fc0): "For many years JS had a single widely accepted module format, which is to say, there was none. Everything was a global variable petulantly hanging off the window object."

Before we have CommonJS, AMD and the newest ES6 module system, we only have global variables, closures and some good coding styles to simulate modular programming, which is like: we separate different functions into different js files and import them into our html based on the order we need them to be.

## Module Standard

With the development of JavaScript community, we have several popular module standard, and today I want to record some basic difference and syntax from all these different standard.

### CommonJS

CommonJS (once called ServerJS before, or CJS in short), is famous among all js developers, since Node uses it as its default module standard. And compared to AMD, which we will talk about later, CommonJS is a standard for synchronous modules, the modules have to be loaded sequentially, which might take more time than if they were to be loaded asynchronously.

The syntax for CommonJS is pretty easy:

``` javascript
// the module.js file

// define the module you want to export
let myModule = function(){
  // ...
}

module.exports = myModule

// how to use in another file ?

// use the path to the module.js file
// you can omit the .js since it will look up .js file by default (the priority: .node > .js > .json)
let mm = require('./module.js');
// ... mode code here 
```

### AMD

AMD (Asynchronous Module Definition) is a standard for asynchronous modules, and different with CommonJS, AMD naturally works on the browser, and its syntax is also easy to understand and use, all you need is a [Require.js](http://requirejs.org/).

``` javascript
// define the module: myModule
// syntax: define(alias, dependenciesArray, callbackFunction)
define('myModule', [], function() {
  var myModule = function(){};
  return myModule;
});

// use it
// require(dependenciesArray, callbackFunction)
require(['myModule'], function(obj) {
  // use obj as the module you import
})

// you can put them into a single file or different files
// but you need import the Require.js to use the `define` and `require`.
```

### ES6

Some of you may struggle to decide which standard to adapt, you may choose CJS over AMD if you love Node a lot like me, some of you may prefer AMD since it is easy to adapt in web dev. But now since ES6 has finalized the new syntax for the next generation of JS, you can forget all above and use ES6 from now on.

The syntax is also very simple and easy to use, but totally different with CJS and AMD... why don't they just use CJS and save all of us...

``` javascript
// module.js file
var a = function() {
	// ...
}; 

// normal export
export function B() {
	// ...
}
// export object as default for import
export default a;
// export all from another module
export * from 'anotherModule.js';

// how to use
// main.js file
import a, { B } from './module.js';
import * as bundle from './module.js';
// now you can use bundle.B or bundle.a
```

## Todo

Now you have a basic idea about these module standard, but how to use them or how to adapt them into your own workflow ? I will have another post talking about the tools that can help us make this easy.
