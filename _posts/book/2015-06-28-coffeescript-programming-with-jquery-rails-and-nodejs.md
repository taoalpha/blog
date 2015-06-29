---
layout: post
title: CoffeeScript Programming with jQuery, rails and Nodejs (1)
category: book
description: The notes I took while I was learning the 'CoffeeScript'. If you are a real beginner with 'CoffeeScript', I suggest you start with another book called "The Little Book on CoffeeScript", it's better for beginners. And after that, this one is definitely your best choice.
language: en
tags: [js,CoffeeScript,jQuery,rails,nodejs,reading notes]
author: taoalpha
---

## Summary

The notes I took while I was learning the 'CoffeeScript'. If you are a real beginner with 'CoffeeScript', I suggest you start with another book called "The Little Book on CoffeeScript", it's better for beginners. And after that, this one is definitely your best choice.

CoffeeScript is a language which complies to JavaScript. Like the sass or scss to css except that CoffeeScript is not compatible with javascript. So you can not mix the javascript syntax with the CoffeeScript.

This note is mainly about the fist chapter of the book, a nice introduction for CoffeeScript including the basic syntax.

> And to improve my english, I think i will start writing english notes for the english books. ^_^

## Notes

CoffeeScript is pretty popular in the community of JavaScript for its simplicity, elegant and readable. Now let us dive into it.

Instead of  listing the keywords and statements used in CoffeeScript one by one, it would better we learn CoffeeScript from comparing the difference between the CoffeeScript and JavaScript.

- CoffeeScript removes most of the semicolons and the curly braces which used a lot in JavaScript, gives us a clearly view of the code, but you can still use the semicolons if you want, and you still have to use the semicolons if you want to put multiple statements in single one;
- CoffeeScript learns a lot from ruby and python. Like this one: it uses whitespace or indentation, more accurately, to delimit the code blocks instead of braces.
- CoffeeScript removes a lot of parenthesis for many statements and functions, like if..else, while loops and functions with single string parameter. But this is optional, you can still use them if you want. **Notice: you will need parenthesis if you want to call a function without any parameters)**
- Function: as the first class object in JavaScript, CoffeeScript also does a lot improvements for it.
  - If you write js, you will know that the syntax is really ugly when you want to write a anonymous function. Now you can make it pretty beautiful with CoffeeScript;
  - CoffeeScript also saves you a lot keystrokes for defining the functions;
  - so what are the rules?
    - Replace the `function` keyword with `->`;
    - Drop the parenthesis if there is no argument for the function;
    - Put the arguments enclosed with parenthesis in front of the `->`, and if the argument has a default value, you can set it in the parenthesis;
    - Drop the curly braces and use indentation for the function body;
    - Automatically return the last expression of the function, but if you need return something before, you still need to use the `return`;


{% highlight coffeescript %}

 -> alert 'hi there!'
# the code above won't self-initiating, if you want to do that, you need use parenthesis or the `do` keyword like below:
# (-> alert 'hi there!')()
# do -> alert 'hi there!'

square = (n=1) -> n * n

# function using splats
# this is an alternative way for using Array.prototype.slice()
gpaScoreAverage = (scores...) ->
  total = scores.reduce (a, b) -> a + b
  total / scores.length

alert gpaScoreAverage(65,78,81)
scores = [78, 75, 79]
alert gpaScoreAverage(scores...)

{% endhighlight %}

{% highlight javascript %}
var square;
(function(){
  return alert("hi there!");
});
/* the code in comments above will compile to:
(function(){
  if (n == null) {
    n = 1;
  }
  return alert("hi there!");
})();
*/
square = function(n) {
  return n * n;
};

// [].slice.call(arguments,0) ==>  Array.prototype.slice.call(arguments,0)
var gpaScoreAverage, scores,
  slice = [].slice;

gpaScoreAverage = function() {
  var scores, total;
  scores = 1 <= arguments.length ? slice.call(arguments, 0) : [];
  // get the single score value or a list of the scores
  total = scores.reduce(function(a, b) {
    return a + b;
  });
  return total / scores.length;
};

alert(gpaScoreAverage(65, 78, 81));

scores = [78, 75, 79];

alert(gpaScoreAverage.apply(null, scores));

{% endhighlight %}

- CoffeeScript will declare the variables you need at the top of the function for you automatically. So that means you can't create the global variables in a function like you can do in JavaScript, actually you can't use the `var` keyword in CoffeeScript. <= many people agree that omitting the `var` keyword makes the variables become global is a really bad desgin...
- Object:
  - CoffeeScript supports the `class` keyword, and it will create a closure to build the class;
  - Use the `constructor` to initialize some private properties, or just omit it;
  - Every function you define in a `class` will be added to the object as a prototype method;
  - Use `@` as a shortcut for `this`;
  - **fat arrow**: When you want to use `this` in previous scope instead of the new scope, you need the fat arrow : `=>`;
  - Use `super` to call the parent's method (same name, so just pass the parameter);
  - Use `::` as a shortcut for `.prototype`, so you can extend your prototype as this:`Vehicle::stop =-> alert 'stop'`;

{% highlight coffeescript %}
class Vehicle
  # Use the constructor to initialize some private properties
  # Use @ as this
  constructor: ->
    @c = 1
  drive: (km) ->
    alert "Drove #{km} kilometres"

class Car extends Vehicle
 constructor: ->
   @odometer = 0
 drive: (km) ->
   @odometer += km
   super km
 name:"John Doe"
 driver: (msg) ->
   @msg = msg
 whoisdriver: ->
   @msg()

car = new Car
car.drive 5
alert "Odometer is at #{car.odometer}"

class Person
  constructor: (name)->
    @name = name
    @mycar = new Car()
    @mycar.driver => alert "#{@name}"

mike = new Person "Mike"
# use `=>` to show mike's name instead of the default `john doe` set in Car
mike.mycar.whoisdriver()
{% endhighlight %}

{% highlight coffeescript %}
var Car, Person, Vehicle, car, mike,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Vehicle = (function() {
  function Vehicle() {
    this.c = 1;
  }

  Vehicle.prototype.drive = function(km) {
    return alert("Drove " + km + " kilometres");
  };

  return Vehicle;

})();

Car = (function(superClass) {
  extend(Car, superClass);

  function Car() {
    this.odometer = 0;
  }

  Car.prototype.drive = function(km) {
    this.odometer += km;
    return Car.__super__.drive.call(this, km);
  };

  Car.prototype.name = "John Doe";

  Car.prototype.driver = function(msg) {
    return this.msg = msg;
  };

  Car.prototype.whoisdriver = function() {
    return this.msg();
  };

  return Car;

})(Vehicle);

car = new Car;
car.drive(5);
alert("Odometer is at " + car.odometer);

Person = (function() {
  function Person(name) {
    this.name = name;
    this.mycar = new Car();
    this.mycar.driver((function(_this) {
      return function() {
        return alert("" + _this.name);
      };
    })(this));
  }

  return Person;

})();

mike = new Person("Mike");
mike.mycar.whoisdriver();
{% endhighlight %}

- Other Good Things:
  - CoffeeScript will quote reserved words automatically if you use them in your literal object;
  - You can also drop the comma when you define your literal array or literal object only if you put one property per line, you can drop the braces for object, but you need them for array;
  - Use `#{variable_name}` to concatenate the string and variables instead of `+`, but only use them enclosing with double-quote, the single-quote strings are literal, borrowed from ruby;
  - CoffeeScript will always convert the `==` and `!=` to `===` and `!==`;
  - Use the `existential operator: ?` to check whether a variable exists and has a value or not(means not null or undefined);
  - Also use the `soak: ?. ` as a shortcut for ternary statement;
  - Support some new keywords like `unless`, the opposite to `if`;
  - Use plain english aliases for some of the logical operators: `is for ===`,`isnt for !==`,`not for !`,`and for &&`,`or for ||`,`true can also be yes, or on`,`false can be no or off`;
  - Support assign multiple values at once;
  - CoffeeScript replaces the `case` in `switch` with `when ... then`, so you can forget about the `break`, and it also replaces the `default` with `else`;
  - CoffeeScript supports the `chained comparisions`: `61 > a > 39`;
  - You can use `###` to comment multiple lines. The biggest difference between `###` and `#` is former one will be part of generated javascript;

{% highlight coffeescript %}
b=1
if a? && b?
  alert "a.c equals to #{a?.c}"
[city, state, country] = ["!2","24","2"]
# or function which returns an object with the same structure as you described before the `=`
{address: {street: myStreet,room: myRoom}} = getAddress()
### =>
var b;
b = 1;
// since we declared the b before, we only need to check if b is null.
if ((typeof a !== "undefined" && a !== null) && (b != null)) {
  alert("a.c equals to " + (typeof a !== "undefined" && a !== null ? a.c : void 0));
}
var city, country, myRoom, myStreet, ref, ref1, state;
ref = ["!2", "24", "2"], city = ref[0], state = ref[1], country = ref[2];
ref1 = getAddress().address, myStreet = ref1.street, myRoom = ref1.room;
###
{% endhighlight %}

- List: CoffeeScript borrowed a lot `list comprehensions` from python`[ x*2 for x in object_name ]` and ruby.
  - `while`: it works nearly the same as in javascript except that it has an opposite keyword in CoffeeScript: `until` and both of them can be used as expression and will return a array;
  - `for`: the standard statement is `[action or mapping] for [selector] in [collection] when [condition] by [step]`. Last `by` following with a number would affect the loop step(`i++``);
  - `[f_number..l_number]`: it will create a array with numbers between the fist number and the last number, you can use `...`(3 dots) to make the array only contains the numbers in between;
  - `of`: for key-value pairs of an object, you can use `of` to loop them through;

{% highlight coffeescript %}
times = [0..2]
(n*times while times -= 1).pop()
### =>
 var times;
 times = [0, 1, 2];
((function() {
  var results;
  results = [];
  while (times -= 1) {
    results.push(n * times);
  }
  return results;
})()).pop();
###
alert x for x in flavors when x != 'h' by 2
###=>
var x, i, len;
for (i = 0, len = flavors.length; i < len; i+=2) {
  x = flavors[i];
  if (x !== 'h') {
    alert(x);
  }
}
###
ages =
 john: 25
 peter: 26
 joan: 23
alert "#{name} is #{age} years old" for name, age of ages
###=>
var age, ages, name;
ages = {
  john: 25,
  peter: 26,
  joan: 23
};
for (name in ages) {
  age = ages[name];
  alert(name + " is " + age + " years old");
}
###
{% endhighlight %}

## Digest

- For JavaScript:
  - Every `class` in JS is a function object;
  - Only function object has the default prototype, so the normal objects like literal string, number or even string created from String(),any objects created by functions, they all don't have the default prototype;
  - But every object has a default constructor which is exactly the function object who create it;
- For CoffeeScript:
  - If there is only one line in the body, you can move it in front of the condition <= `while/until/for/if...`

## Puzzle

- Q1: In the second code example above, CoffeeScript create a default extend function for us:

{% highlight javascript %}
var extend = function(child, parent) {
  for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
  }

  // Start from here
  function ctor() {
      this.constructor = child;
  }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor();
  // End
  // Just cannot understand the codes above...

  // Why we need another function as the child's prototype? We have already copied all the properties from parent, or we just need a beautiful prototype chain? `Car <= ctor() <= Vehicle() <= Object` compared to `Car <= Car <= Object()`.
  // Then why not we just use the child.prototype = new parent() ??? we can still get a good prototype chain. `Car <= Vehicle <= Vehicle <= Object`.

  child.__super__ = parent.prototype;
  return child;
},
hasProp = {}.hasOwnProperty;
{% endhighlight %}
