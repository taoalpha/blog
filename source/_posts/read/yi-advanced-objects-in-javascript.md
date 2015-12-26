category: dandp
description: ''
date: 2014-08-29 3:00:00
title: Advanced Objects in JavaScript
tags: [译系列,翻译文章,Object,coding,js]
---

<p>JS算是我最常用的集中语言之一了, 而随着nodejs的出现, js终于成为了一款贯通前后端的语言~ High five for this!</p>

<p>JS的Object可以说是应用极为广泛! 那么除了我们通常的那些用法, 对Objects还有什么高级用法吗?</p>

<p>========正文====本文来自: Readability Top Reads==========</p>

<p>与通常我们使用JS中Object的方法不同, 本文中涉及的要更加高端. JS的Objects的基础使用中绝大部分都会和使用json一样的简单. 但是, JS同时也提供了更加复杂的工具来创建Objects, 而且更加有趣也更加有意义, 其中很多在现代的浏览器中都已经得到支持了.</p>

<p>本文中最后谈及的<em><em>Proxy</em></em>和<em><em>Symbol</em></em>, 是基于ECMAScript 6的一些特性, 目前在跨浏览器方面还不是很完善.</p>

<h4>Getters and setters</h4>

<p>Getters和Setters存在与JS中已经有一段时间了, 但是通常很少会用到. 我通常还是会使用常规的函数来获取一些属性. 比如, 我通常都是使用如下这样的函数来实现:</p>


``` javascript
/**
 * @param {string} prefix
 * @constructor
 */
function Product(prefix) {
  /**
   * @private
   * @type {string}
   */
  this.prefix_ = prefix;
  /**
   * @private
   * @type {string}
   */
  this.type_ = "";
}

/**
 * @param {string} newType
 */
Product.prototype.setType = function (newType) {
  this.type_ = newType;
};

/**
 * @return {string}
 */
Product.prototype.type = function () {
  return this.prefix_ + ": " + this.type_;
}

var product = new Product("fruit");
product.setType("apple");
console.log(product.type());  //logs fruit: apple

```


<p><a href="http://jsfiddle.net/btipling/mohb4fx2/26/">jsfiddle</a></p>

<p>利用getter的话, 我就可以简化这一代码:</p>


``` javascript
/**
 * @param {string} prefix
 * @constructor
 */
function Product(prefix) {
  /**
   * @private
   * @type {number}
   */
  this.prefix_ = prefix;
  /**
   * @private
   * @type {string}
   */
  this.type_ = "";
}

/**
 * @param {string} newType
 */
Product.prototype = {
    /**
     * @return {string}
     */
    get type () {
      return this.prefix_ + ": " + this.type_;
    },
    /**
     * @param {string}
     */
    set type (newType) {
      this.type_ = newType;
    }
};

var product = new Product("fruit");

product.type = "apple";
console.log(product.type); //logs "fruit: apple"

console.log(product.type = "orange");  //logs "orange"
console.log(product.type); //logs "fruit: orange"

```


<p><a href="http://jsfiddle.net/btipling/mohb4fx2/3/">jsfiddle</a></p>

<p>上面的代码明显还是有些罗嗦的, 而且语法显得很不寻常, 但是<em><em>set</em></em>,<em><em>get</em></em>的好处就是在使用的时候更加易于理解. 后来我发现如下这样的好东西:</p>


``` javascript
roduct.type = "apple";
console.log(product.type);

```


<p>比下面这样可读性更强也更容易接受吧:</p>


``` javascript
product.setType("apple");
console.log(product.type());

```


<p>虽然直接的获取以及设定用例的属性还是略微有些违反我已经形成的固有习惯. 长久以来我们都在bugs和技术问题的训练中养成了避免直接对用例赋值的'好习惯'. 同时, 还有一点则是为了返回值的问题. 比如注意上例中这两句:</p>


``` javascript
console.log(product.type = "orange");  //logs "orange"
console.log(product.type); //logs "fruit: orange"

```


<p>注意上例中,"orange"先输出, 然后输出"fruit: orange". 在赋值命令的return中, getter是不会被触发的. 所以如果想要通过赋值语句来获取属性值是行不通的. 其实对于<em><em>set</em></em>部分,  return是会被直接忽略的. 所以你即便在setter中加入<code>return this.type;</code> 也是没有意义的. 通常来说赋值后的默认返回值是可以直接使用的, 除非是本身有另一套的getter.</p>

<hr>

<h4>defineProperty</h4>

<p><code>get propertyname()</code> 语法可用于对象标识符, 在前面的例子中, 我曾经给<code>Product.prototype</code>赋予了一个对象标识符. 本来没啥问题, 但是使用这样的对象标识符会导致prototypes之间链接以实现继承变得更加困难. 此时你就可以使用<code>defineproperty</code>而不用对象标识符来创建getters和setters了.</p>


``` javascript
/**
 * @param {string} prefix
 * @constructor
 */
function Product(prefix) {
  /**
   * @private
   * @type {number}
   */
  this.prefix_ = prefix;
  /**
   * @private
   * @type {string}
   */
  this.type_ = "";
}

/**
 * @param {string} newType
 */
Object.defineProperty(Product.prototype, "type", {
  /**
   * @return {string}
     */
  get: function () {
      return this.prefix_ + ": " + this.type_;
  },
  /**
   * @param {string}
  */
  set: function (newType) {
    this.type_ = newType;
  }
});

```


<p><a href="http://jsfiddle.net/btipling/mohb4fx2/4/">jsfiddle</a></p>

<p>上面的代码和之前的例子效果完全一样. 于之前的例子不同, <em>defineProperty</em>的第三个参数称为descriptor, 而且其中除了设置<em>set</em>和<em>get</em>以外, 还允许你去定制一些属性以及对应值. 你可以利用descriptor参数来创建一些类似常量之类的这种无法被改变和删除的属性. </p>


``` javascript

  var obj = {
    foo: "bar",
};


//A normal object property
console.log(obj.foo); //logs "bar"

obj.foo = "foobar";
console.log(obj.foo); //logs "foobar"

delete obj.foo;
console.log(obj.test); //logs undefined


Object.defineProperty(obj, "foo", {
    value: "bar",
});

console.log(obj.foo); //logs "bar", we were able to modify foo

obj.foo = "foobar";
console.log(obj.foo); //logs "bar", write failed silently

delete obj.foo;
console.log(obj.foo); //logs bar, delete failed silently

```

<a href="http://jsfiddle.net/btipling/mohb4fx2/6/">jsfiddle</a>

上例最后两次对<em>foo.bar</em>的更改尝试都以失败结束. 这是因为<em>defineProperty</em>默认阻止对内置属性的改变. 你可以利用<em>configurable</em>和<em>writable</em>来修改这一行为. 如果你使用的是stric mode, 那么错误信息就不会静默而是转化为js错误输出的.


``` javascript

var obj = {};

Object.defineProperty(obj, "foo", {
    value: "bar",
    configurable: true,
    writable: true,
});

console.log(obj.foo); //logs "bar"
obj.foo = "foobar";
console.log(obj.foo); //logs "foobar"
delete obj.foo;
console.log(obj.test); //logs undefined

```


<a href="http://jsfiddle.net/btipling/mohb4fx2/9/">jsfiddle</a>

其中, <em>configurable</em>键值允许你控制属性值能否被删除. 它同时还允许你控制属性值能否被修改. 而<em>writable</em>键值则允许你去给属性赋值进行修改.

如果<em>configurable</em>设定为false(默认), 那么你再次调用<em>defineProperty</em>定义同变量的时候就会造成js的错误, 而且会抛出异常而不是静默处理的.


``` javascript

var obj = {};

Object.defineProperty(obj, "foo", {
    value: "bar",
});


Object.defineProperty(obj, "foo", {
    value: "foobar",
});

// Uncaught TypeError: Cannot redefine property: foo 


```

<a href="http://jsfiddle.net/btipling/mohb4fx2/11/">jsfiddle</a>

而如果你设定<em>configurable</em>为true, 那么你就可以再次利用<em>defineProperty</em>对属性值进行修改. 比如你可以对原本不可写的属性进行修改.


``` javascript

var obj = {};

 Object.defineProperty(obj, &quot;foo&quot;, {
     value: &quot;bar&quot;,
     configurable: true,
 });

 obj.foo = &quot;foobar&quot;;

 console.log(obj.foo); // logs &quot;bar&quot;, write failed

 Object.defineProperty(obj, &quot;foo&quot;, {
     value: &quot;foobar&quot;,
     configurable: true,
 });

 console.log(obj.foo); // logs &quot;foobar&quot;

```

<p><a href="http://jsfiddle.net/btipling/mohb4fx2/12/">jsfilddle</a>;</p>

同时还要注意下, 任何由<code>defineProperty</code>定义的属性都不能在<code>for in</code>循环中出现的.


``` javascript

var i, inventory;

 inventory = {
     &quot;apples&quot;: 10,
     &quot;oranges&quot;: 13,
 };

 Object.defineProperty(inventory, &quot;strawberries&quot;, {
     value: 3,
 });

 for (i in inventory) {
     console.log(i, inventory[i]);
 }

```


<p><a href="http://jsfiddle.net/btipling/mohb4fx2/13/">jsfiddle</a></p>

上述循环会输出如下结果:

``` javascript

apples 10
oranges 13

```


然后我们用<code>enumerable</code>键值来允许属性值在for in循环中出现:


``` javascript

var i, inventory;

 inventory = {
     &quot;apples&quot;: 10,
     &quot;oranges&quot;: 13,
 };

 Object.defineProperty(inventory, &quot;strawberries&quot;, {
     value: 3,
     enumerable: true,
 });

 for (i in inventory) {
     console.log(i, inventory[i]);
 }

```

<p><a href="http://jsfiddle.net/btipling/mohb4fx2/14/">jsfiddle</a></p>
上述则会输出:

apples 10
oranges 13
strawberries 3


你还可以利用<code>isPropertyEnumerable</code>来测试一个属性是否能够出现在循环中.

``` javascript

var i, inventory;

 inventory = {
     &quot;apples&quot;: 10,
     &quot;oranges&quot;: 13,
 };

 Object.defineProperty(inventory, &quot;strawberries&quot;, {
     value: 3,
 });

 console.log(inventory.propertyIsEnumerable(&quot;apples&quot;)); //console logs true
 console.log(inventory.propertyIsEnumerable(&quot;strawberries&quot;)); //console logs false

```


<p><a href="http://jsfiddle.net/btipling/mohb4fx2/21/">jsfilddle</a></p>


<code>isPropertyEnumerable</code>对于在prototype其它环节定义的属性值也会默认返回false的, 当然对于以其他形式定义的, 只要是属于这个object的属性都会默认返回false的.

最后还有几点关于使用<code>defineProperty</code>的注意项: 结合使用<code>set</code>,<code>get</code>和设定为true的<code>writable</code>键值, 或者是<code>set</code>,<code>get</code>和<code>value</code>直接放在一起也是错误的做法.  把一个属性设定为一个数型值, 只会把这个数值转化为一个字符串的(这个在所有情况下都是一样的). 在<code>defineProperty</code>中你也是可以把<code>value</code>定义为函数的.


<strong>defineProperties</strong>

除了<code>defineProperty</code>, Object还有<code>Object.defineProperties</code>. 可以允许你一次性定义以多个属性. <a href="http://jsperf.com/defineproperty-vs-defineproperties">有篇文章</a>对比过两者的区别, 不过就Chrome而言, 两者并无太明显的差别.


``` javascript

var foo = {}

Object.defineProperties(foo, {
    bar: {
        value: "foo",
        writable: true,
    },
    foo: {
        value: function() {
           console.log(this.bar);
        }
    },
});

foo.bar = "foobar";
foo.foo();  //logs "foobar"

```

<a href="http://jsfiddle.net/btipling/rxopg5qe/1/">jsfiddle</a>

<strong>Object.create</strong>

<code>Object.create</code>和<code>new</code>是基本一样的, 都可以允许你创建一个新的对象. 函数本身有2个参数, 一个是对象的prototype, 另一个则是property descriptor, 其的传参方式则和<code>Object.defineProperties</code>完全一致.


``` javascript

var prototypeDef = {
    protoBar: "protoBar",
    protoLog: function () {
        console.log(this.protoBar);
    }
};
var propertiesDef = {
    instanceBar: {
        value: "instanceBar"
    },
    instanceLog: {
        value: function () {
            console.log(this.instanceBar);
        }
    }
}

var foo = Object.create(prototypeDef, propertiesDef);
foo.protoLog(); //logs "protoBar"
foo.instanceLog(); //logs "instanceBar"

```

<a href="http://jsfiddle.net/btipling/pqdcxnep/">jsfiddle</a>

在property descriptor中传入的属性值会覆盖掉prototype的同属性值.


``` javascript

var prototypeDef = {
    bar: "protoBar",
};
var propertiesDef = {
    bar: {
        value: "instanceBar",
    },
    log: {
        value: function () {
            console.log(this.bar);
        }
    }
}

var foo = Object.create(prototypeDef, propertiesDef);
foo.log(); //logs "instanceBar"


```

<a href="http://jsfiddle.net/btipling/pqdcxnep/2/">jsfiddle</a>

设置一个高级类型, 比如array或者object作为Object.create的传参可能会导致一些错误, 因为你将会创建一个所有对象共用的单例(变量会互串,公用单例的对象之间相互影响).


``` javascript

var prototypeDef = {
    protoArray: [],
};
var propertiesDef = {
    propertyArray: {
        value: [],
    }
}

var foo = Object.create(prototypeDef, propertiesDef);
var bar = Object.create(prototypeDef, propertiesDef);

foo.protoArray.push("foobar");
console.log(bar.protoArray); //logs ["foobar"] 
foo.propertyArray.push("foobar");
console.log(bar.propertyArray); //also logs ["foobar"] 

```

<a href="http://jsfiddle.net/btipling/pqdcxnep/4/">jsfiddle</a>

当然, 你可以通过初始化<code>propertyArray</code>为null来解决之前的问题. 如此你就可以随便使用任意的array了, 甚至可以做更多的事情, 比如使用getter:


``` javascript

var prototypeDef = {
    protoArray: [],
};
var propertiesDef = {
    propertyArrayValue_: {
        value: null,
        writable: true
    },
    propertyArray: {
        get: function () {
            if (!this.propertyArrayValue_) {
                this.propertyArrayValue_ = [];
            }
            return this.propertyArrayValue_;
        }
    }
}

var foo = Object.create(prototypeDef, propertiesDef);
var bar = Object.create(prototypeDef, propertiesDef);

foo.protoArray.push("foobar");
console.log(bar.protoArray); //logs ["foobar"] 
foo.propertyArray.push("foobar");
console.log(bar.propertyArray); //logs [] 


```

<a href="http://jsfiddle.net/btipling/pqdcxnep/5/">jsfiddle</a>

初始化属性值是一个很便捷的方式. 我通常会比较喜欢在工作中把各项属性值都初始化的. 过去我的代码中经常会出现这样的初始化代码.

之前的例子告诉你: 一旦property descriptor定义好了, 那么其中的所有属性值都自动生成了(PS. 这块翻译表述不很准确, 请参照原文.). 这也是为什么一个数组会跨实例共享的原因. 我同样推荐千万不要在多个属性值调用时过分依赖代码的顺序. 如果你一定要在其他属性调用前初始化属性, 那么也许可以直接在实例中使用<code>Object.defineProperty</code>.

因为使用Object.create并不包含一个constructor的函数, 所以你就不能使用<code>instanceof</code>来测试对象所属. 所以我们用<code>isPrototypeOf</code>来确定它是哪个prototype的对象. 使用形式可以使用constructor的形式:MyFunction.prototype.isPrototypeOf或者直接使用Object.create的第一个参数来调用也是一样的.


``` javascript

function Foo() {
}

var prototypeDef = {
    protoArray: [],
};
var propertiesDef = {
    propertyArrayValue_: {
        value: null,
        writable: true
    },
    propertyArray: {
        get: function () {
            if (!this.propertyArrayValue_) {
                this.propertyArrayValue_ = [];
            }
            return this.propertyArrayValue_;
        }
    }
}

var foo1 = new Foo();

//old way using instanceof works with constructors
console.log(foo1 instanceof Foo); //logs true

//You check against the prototype object, not the constructor function
console.log(Foo.prototype.isPrototypeOf(foo1)); //true

var foo2 = Object.create(prototypeDef, propertiesDef);

//can't use instanceof with Object.create, test against prototype object...
//...given as first agument to Object.create
console.log(prototypeDef.isPrototypeOf(foo2)); //true

```

<a href="http://jsfiddle.net/btipling/pqdcxnep/6/">jsfiddle</a>

<code>isPropertyOf</code>会遍历整个prototype链直到找到符合检验对象的后就会返回true.

``` javascript

var foo1Proto = {
    foo: "foo",
};

var foo2Proto = Object.create(foo1Proto);
foo2Proto.bar = "bar";

var foo = Object.create(foo2Proto);

console.log(foo.foo, foo.bar); //logs "foo bar"
console.log(foo1Proto.isPrototypeOf(foo)); // logs true
console.log(foo2Proto.isPrototypeOf(foo)); // logs true

```

<a href="http://jsfiddle.net/btipling/pqdcxnep/7/">jsfiddle</a>


<strong>sealing objects, freezing them and preventing extensibility(如何封装对象来阻止其扩展性)</strong>

只是因为可以就给Object增加各种任意的属性是非常不好的. 在现代的浏览器和node.js的结合下, 已经可以实现限制整个Object从而限制某些单个的属性的变化了.

<code>Object.preventExtensions</code>, <code>Object.seal</code> 和 <code>Object.freeze</code>三个函数对Object的限制程度依次增加. 在限制模式下, 一旦出现违反其规则的行为就会抛出js的异常错误的, 而在正常的模式下, 这些错误并不影响代码的正常运行的.

<code>Object.preventExtensions</code>将阻止Object中属性的新增. 它不会阻止那些现有可写入属性的改变, 也不会阻止属性的删除. 而且它也不会阻止调用defineProperty来修改已知属性.


``` javascript

var obj = {
    foo: "foo",
};

obj.bar = "bar";
console.log(obj); // logs Object {foo: "foo", bar: "bar"} 

Object.preventExtensions(obj);

delete obj.bar;
console.log(obj); // logs Object {foo: "foo"} 

obj.bar = "bar";
console.log(obj); // still logs Object {foo: "foo"} 

obj.foo = "foobar"
console.log(obj); // logs {foo: "foobar"} can still change values

```

<a href="http://jsfiddle.net/btipling/dwyuz997/3/">jsfiddle</a>

<code>Object.seal</code>比preventExtensions更进一步. 它不只会阻止新增属性, 还会阻止修改属性配置以及删除属性. 一旦object被密封后, 你就不能通过defineProperty来对现有属性进行修改了. 如上所说, 一旦你尝试, 就会报错的.

``` javascript

"use strict"; 

var obj = {};

Object.defineProperty(obj, "foo", {
    value: "foo"
});

Object.seal(obj);

//Uncaught TypeError: Cannot redefine property: foo 
Object.defineProperty(obj, "foo", {
    value: "bar"
});

```

<a href="http://jsfiddle.net/btipling/dwyuz997/6/">jsfiddle</a>

你同样也不能删除任何属性了, 即便它们是设定为可配置的也不行(configurable设定为true). 但是你可以修改这些属性的value.


``` javascript

"use strict"; 

var obj = {};

Object.defineProperty(obj, "foo", {
    value: "foo",
    writable: true,
    configurable: true,
});

Object.seal(obj);

console.log(obj.foo); //logs "foo"
obj.foo = "bar";
console.log(obj.foo); //logs "bar"
delete obj.foo; //TypeError, cannot delete

```

<a href="http://jsfiddle.net/btipling/dwyuz997/9/">jsfiddle</a>

最后, <code>Object.freeze</code>则会让一个object完全锁死. 你不能进行新增, 删除, 修改赋值等任何变化. 同时你也不再能使用defineProperty来对现有属性修改.


``` javascript

"use strict"; 

var obj = {
    foo: "foo1"
};

Object.freeze(obj);

//All of the following will fail, and result in errors in strict mode
obj.foo = "foo2"; //cannot change values
obj.bar = "bar"; //cannot add a property
delete obj.bar; //cannot delete a property
//cannot call defineProperty on a frozen object
Object.defineProperty(obj, "foo", {
    value: "foo2"
});

```

<a href="http://jsfiddle.net/btipling/dwyuz997/10/">jsfiddle</a>

如下的这些函数是用来帮助检测Object是否frozen,sealed或者not extensible的:
<code>Object.preventExtensions</code>, <code>Object.seal</code> 和 <code>Object.freeze</code>

<strong>valueOf 和 toString</strong>

你可以使用<code>valueOf</code>和<code>toString</code>来自定义你定义好的Object在js需要一个初始值的时候如何处理.

下面是一个tostring的例子:


``` javascript

function Foo (stuff) {
    this.stuff = stuff;
}

Foo.prototype.toString = function () {
    return this.stuff;
}


var f = new Foo("foo");
console.log(f + "bar"); //logs "foobar"

```

<a href="http://jsfiddle.net/btipling/LgacxLbL/3/">jsfiddle</a>

以及一个valueOf的例子:

``` javascript

function Foo (stuff) {
    this.stuff = stuff;
}

Foo.prototype.valueOf = function () {
    return this.stuff.length;
}

var f = new Foo("foo");
console.log(1 + f); //logs 4 (length of "foo" + 1);

```

<a href="http://jsfiddle.net/btipling/LgacxLbL/5/">jsfiddle</a>

但是如果你同时使用tostring和valueOf的话, 可能会得到一些奇怪的结果.

``` javascript

function Foo (stuff) {
    this.stuff = stuff;
}

Foo.prototype.valueOf = function () {
    return this.stuff.length;
}

Foo.prototype.toString = function () {
    return this.stuff;
}

var f = new Foo("foo");
console.log(f + "bar"); //logs "3bar" instead of "foobar"
console.log(1 + f); //logs 4 (length of "foo" + 1);

```

<a href="http://jsfiddle.net/btipling/LgacxLbL/6/">jsfiddle</a>

一个更加便捷的方式使用toString就是让你的object支持hash.

``` javascript

function Foo (stuff) {
    this.stuff = stuff;
}

Foo.prototype.toString = function () {
    return this.stuff;
}

var f = new Foo("foo");

var obj = {};
obj[f] = true;
console.log(obj); //logs {foo: true}

```

<a href="http://jsfiddle.net/btipling/LgacxLbL/8/">jsfiddle</a>


<strong>getOwnPropertyNames 和 keys</strong>

你可以利用<code>Object.getOwnPropertyNames</code>来获得object中所有已定义的属性名称. 如果你熟悉Python的话, 它和python的dictionary类型的keys函数是一样的. 实际上, 也确实有Object.keys这么一个函数. 两者的区别在于, getOwnPropertyNames同时还会遍历到那些无法枚举到的属性, 即它可以返回那些不会出现在for in循环中的属性.


``` javascript

var obj = {
    foo: "foo",
};

Object.defineProperty(obj, "bar", {
    value: "bar"
});

console.log(Object.getOwnPropertyNames(obj)); //logs ["foo", "bar"]
console.log(Object.keys(obj));  //logs ["foo"]

```

<a href="http://jsfiddle.net/btipling/ookcucwm/1/">jsfiddle</a>

<strong>Symbol</strong>

<code>Symbol</code>是一个特殊的初始类型, 是在ECMAScript 6中定义的, 会在下一代js中使用. 你可以通过chrome canary以及firefox nightly以及下面的jsfiddle例子中提前感受下(例子本身也只支持这两种浏览器, 且版本不低于本文发表时间: 2014-8).

Symbols可以被用于在Object中创建以及引用属性.


``` javascript

var obj = {};

var foo = Symbol("foo");

obj[foo] = "foobar";

console.log(obj[foo]); //logs "foobar"

```

<p><a href="http://jsfiddle.net/btipling/5c35eyav/">jsfiddle</a> <em>(Chrome Canary and Firefox Nightly only)</em></p>

Symbols本身是唯一且不可改变的.


``` javascript

//console logs false, symbols are unique:
console.log(Symbol("foo") === Symbol("foo"));

```

<p><a href="http://jsfiddle.net/btipling/5c35eyav/2/">jsfiddle</a> <em>(Chrome Canary and Firefox Nightly only)</em></p>

你还可以在defineProperty中使用Symbols.


``` javascript

var obj = {};

var foo = Symbol("foo");

Object.defineProperty(obj, foo, {
    value: "foobar",
});

console.log(obj[foo]); //logs "foobar"

```

<p><a href="http://jsfiddle.net/btipling/5c35eyav/3/">jsfiddle</a>  <em>(Chrome Canary and Firefox Nightly only)</em></p>

属性通过symbols添加到object后将不能在for in循环中调用. 但是可以在hasOwnProperty中正常反馈.


``` javascript

var obj = {};

var foo = Symbol("foo");

Object.defineProperty(obj, foo, {
    value: "foobar",
});

console.log(obj.hasOwnProperty(foo)); //logs true

```

<p><a href="http://jsfiddle.net/btipling/5c35eyav/4/">jsfiddle</a> <em>(Chrome Canary and Firefox Nightly only)</em></p>

Symbols不会出现在getOwnPropertyNames的返回值中, 但是Object本身有<code>Object.getOwnPropertySumbols</code>.


``` javascript

var obj = {};

var foo = Symbol("foo");

Object.defineProperty(obj, foo, {
    value: "foobar",
});

//console logs []
console.log(Object.getOwnPropertyNames(obj));

//console logs [Symbol(foo)]
console.log(Object.getOwnPropertySymbols(obj));

```

<p><a href="http://jsfiddle.net/btipling/5c35eyav/5/">jsfiddle</a> <em>(Chrome Canary and Firefox Nightly only)</em></p>

Symbols在你不只希望一个属性不被偶然中修改, 更不希望它在正常的流程中出现时, 会是一个很好的帮手. 我并没有想到所有symbols的所有潜在用法, 我可以肯定还有很多.

<strong>Proxy</strong>

这又是一个在ECMAScript 6中添加的新东西. 截至到2014年8月, proxies只能在Firefox中生效. 所以下面这个例子只能在firefox中看了(实际上我也是用firefox做的测试).

Proxies的出现是让我很兴奋的一件事, 因为它可以允许我们轻易获得任何属性. 请看下面例子:


``` javascript

var obj = {
    foo: "foo",
};
var handler = {
    get: function (target, name) {
        if (target.hasOwnProperty(name)) {
            return target[name];
        }
        return "foobar";
    },
};
var p = new Proxy(obj, handler);
console.log(p.foo); //logs "foo"
console.log(p.bar);  //logs "foobar"
console.log(p.asdf); //logs "foobar"

```

<p><a href="http://jsfiddle.net/btipling/d4he6u4t/4/">jsfiddle</a> <em>(Firefox only)</em></p>

上例中, 我们把Object obj 代理到一个变量上. 我们定义了一个handler的对象来和代理后的对象进行交互. 其中的get函数应该很好理解. 它获取了目标对象以及对象的名称. 我们可以利用这个信息来返回任意一个我们希望获得的属性值, 但是为了以防万一, 我会在对象有的属性返回对应的值, 而在所有对象没有的属性我就返回"foobar". 我喜欢这个函数, 它可以用在很多有趣的地方.

还有个地方可以让proxy大显身手, 就是用于测试. 除了get以外, 你完全可以增加使用set, has以及更多的处理函数. 一旦Proxy得到更多的浏览器支持, 性能稳定后, 我会考虑写一篇更加详细的博文来聊聊Proxy的.

所以说, 其实对于JS的Object, 还是有很多更加高级的用法的. 即便是现在, 也可以有很多强大的属性定义提供使用, 而在未来, 更是无法想象, 尤其是要想到Proxy完全可以改变js的整个写法. 如果你有任何问题或者纠正我的地方, 请通过Twitter来@我, 告诉我~ 我的用户名是@bjorntipling.

<p><strong>Source Link</strong></p>

<ul>
<li><a href="http://bjorn.tipling.com/advanced-objects-in-javascript" title="source link of this article">Advanced Objects in JavaScript</a></li>
</ul>

