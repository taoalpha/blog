---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day27-python的类以及继承与合并
tags: [Inheritance,python,合并,Patch,继承,Composition,class]
---

很久之前上Java和C++课的时候学过一些类的继承和合并的问题, 但除了当时苦逼的大作业之外,基本没什么用到的地方...如今接触python也不短的时间了, 除了上次做人人的登陆时用了一下class以外,基本也没怎么使唤它...

这几天因为想要做一个feed的定制应用, 因为结构比较复杂, 只用def可以搞,不过会很乱...不利于整体结构,于是就再次拾起class...记录一下对class继承和合并的理解~

继承其实比较好理解,因为和字面的意思一致, 子类肯定是从父类上继承相关的变量以及函数的,而继承的方式上,又可以简单分为三种:

<ol>
	<li><strong>隐式继承: </strong>在子类定义的开始,就默认用隐式继承的方式继承了父类中所有可继承的函数,变量等;</li>
  	<li><strong>显式继承: </strong>如果针对继承来的函数有所不满, 需要再次调整的话,就可以在子类中重新针对父类的函数进行定义, 如此即为显式继承, 相当于替换了父类的对应函数或者变量;</li>
  	<li><strong>显式继承中的父类调用: </strong>还有一种情况,如果你重新定义了父类的函数, 但又想要再次用到父类的函数,该如何呢? 就可以用这种方式~</li>

{% highlight python %}

# 代码示例来自"苯方法学python"~
class Parent(object):

    def override(self):
        print "PARENT override()"

    def implicit(self):
        print "PARENT implicit()"

    def altered(self):
        print "PARENT altered()"

class Child(Parent):
    
    def override(self):
        print "CHILD override()"

    def altered(self):
        print "CHILD, BEFORE PARENT altered()"
        super(Child, self).altered()
        print "CHILD, AFTER PARENT altered()"

dad = Parent()
son = Child()

dad.implicit()
son.implicit()
# 隐式继承
dad.override()
son.override()
# 显式继承
dad.altered()
son.altered()
# 显式继承中调用父类;
>> output:
PARENT implicit()
PARENT implicit()
PARENT override()
CHILD override()
PARENT altered()
CHILD, BEFORE PARENT altered()
PARENT altered()
CHILD, AFTER PARENT altered()

{% endhighlight %}

</ol>
继承中有个很麻烦的大boss就是"多重继承"...对此我也完全没有搞清楚...就不瞎扯误导大家了.

合并是另一种方式来省却大量重复函数或者模块定义的方法~

相比继承的众多雷区,合并更为人所提倡, 思路也很简单, 就是在合并类中定义一个需要应用的类变量,如此就可以通过这个变量去访问其成员了:


{% highlight python %}

class Other(object):

    def override(self):
        print "OTHER override()"

    def implicit(self):
        print "OTHER implicit()"

    def altered(self):
        print "OTHER altered()"

# 合并类的定义
class Child(object):

    def __init__(self):
        self.other = Other()
		# 把要引用的类定义为本类的变量,如此就可以通过这个变量去访问这个类的成员了

    def implicit(self):
        self.other.implicit()
    
    def override(self):
        print "CHILD override()"

    def altered(self):
        print "CHILD, BEFORE OTHER altered()"
        self.other.altered()
        print "CHILD, AFTER OTHER altered()"

son = Child()

son.implicit()
son.override()
son.altered()

>>>output:
OTHER implicit()
CHILD override()
CHILD, BEFORE OTHER altered()
OTHER altered()
CHILD, AFTER OTHER altered()

{% endhighlight %}


基本上了解上述两个概念就差不多够用了~类的出现其实最直接的好处就和函数定义一样,可以省却很多重复的代码块~
