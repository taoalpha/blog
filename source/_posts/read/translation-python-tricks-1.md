category: dandp
description: ''
date: 2014-01-03 8:00:00
title: python tricks(1)
tags: [python,翻译文章,译系列]
---

无意中发现的一篇文章~ 很有意思, 介绍了不少python的技巧型用法~ <a href="http://www.secnetix.de/~olli/Python/tricks.hawk" target="_blank">原文在此</a>
<ul>
  	<li><strong>模拟"?:"的三元运算符</strong>
  python是不识别C中的"?:"这种三元操作符的,但是模拟这种运算是非常容易的:
      x ? y : z ---> [z,y][bool(x)]
  如果你提前就知道了x的类型, 比如本身就是1,0或者布尔类型, 那么就完全可以不用使用bool()函数了~ 原理? 很简单, 我们只是简单创建了一个列表, 包含两个值, 然后用布尔类型作为索引值来选择list的元素, 其中"true"是等同于1, 而false等同于0, 如此就变成了指定list的第一个还是第二个元素了~
      
   注意到在此情况下, x,y,z三个操作数始终都是需要的, 这一点和C里面的"?:"操作符不一样. 如果你需要一个简单方式, 也可以使用if-else来实现.
      
   实际上, 还有另一种方法做到这一点, 但是只会在y本身不为false时生效:
      x ? y : z ---> bool(x) and y or z
  (其实就是相当于与运算, 如果x,y都为真,那么就是y(因为bool(x)=1),如果bool(x)为假且y为真时, 就是z~)
  </li>
  	<li><strong>如何查看python的版本.</strong>
  其实很多时候经常发现自己用到的一些功能在旧版本的python中不支持. 这个时候如果在旧版本中运行了, 就会出现一个非常恶心的exception traceback....而通常它的错误信息都是非常无用的...在此情况中, 你就可以用一个简单的脚本来解决~

``` css

import sys
if not hasattr(sys, "hexversion") or sys.hexversion < 0x020300f0:
    sys.stderr.write("Sorry, your Python is too old.\n")
    sys.stderr.write("Please upgrade at least to 2.3.\n")
    sys.exit(1)

```

将这一段代码放在你的程序的最顶部, 包括其他的import语句都要放在其下方. 其中hexversion代表的是一个旨在1.5.2的python之后出现的变量, 由此预防有人使用比1.5.2还早的版本. 这个变量的格式0x&lt;maj&gt;&lt;min&gt;&lt;rev&gt;&lt;rel&gt;(major,minor以及revision和一个发布状态的指示符,官方一般是f0),每四个字符是两个16进制数位.
  </li>
  	<li><strong>调试CGIs.</strong>
     从python2.2版本后使用的cgitb库是一个非常好用的工具, 尤其是在调试CGI程序时. 任何时候每当run-time错误比如exception发生时, 一个很好的html文件就会创建, 包含了错误发生的位置以及源代码, 行号甚至其中涉及的变量. 为了使用这个模块, 只需要把这行代码放在你的CGI程序上方即可.
      
``` css

import cgitb; cgitb.enable()

```

  
  </li>

  
	<li><strong>列表元素的并行排序</strong>
  	有时候你需要对一个列表元素进行排序, 同时还有第二个列表(同等长度)需要一起排序. 当然, 你可以一开始就使用一个2元数构成的列表, 但有的时候程序要求使用别的格式...所以还是可能发生的, 无论如何, 这样也很简单~ 如下的代码片段就可以适用于2个甚至更多的列表~
      
``` css

data = zip(list1, list2)
data.sort()
list1, list2 = map(lambda t: list(t), zip(*data))

```

      注意到zip()函数返回的就是一个包含数组的列表, 所以最后你需要把zip()后的数据再次拆分一下~ 这也是map()函数以及lambda函数的作用. 如果你实际上不需要列表,那么完全可以把最后一行简化为:
      
``` css

tuple1, tuple2 = zip(*data)

```

  </li>
	<li><strong>转换Mac地址</strong>
  		我发现我自己经常转换MAC地址...有时候叫它以太网地址...到一个标准格式. 比如: 每6个部分代表2个数位, 而且都是用的小写的16进制字节. 也是很简单的~
      
``` css

mac = ":".join([i.zfill(2) for i in mac.split(":")]).lower()

```

      zfill()函数是在python 2.2.2之后引入的, 是针对字符串操作的一个函数.
  </li>
	<li><strong>针对IP地址排序</strong>
  如何对一个代表着IP地址的字符串列表进行排序呢? 当然, 你可以针对sort()函数做一些简单调整, 但是那会是非常低效率的.
      
      更好的处理方法是能够利用内置好的比对函数来对列表做预处理, 然后再次把它转回原来的格式. 这个技巧可以处理很多情况, 不止是IP地址~
      
      在本例中还是使用IP地址, 我们首先把每个IP地址重新格式化, 每四个八位字节占据三个字符的域, 如果需要可以在前补充空格. 这样每部分都有同样的长度且可以比较了, 而且有现成的比对函数, 之后就是把它再调回之前的格式就行了~

``` css

for i in range(len(ips)):
    ips[i] = "%3s.%3s.%3s.%3s" % tuple(ips[i].split("."))
ips.sort()
for i in range(len(ips)):
    ips[i] = ips[i].replace(" ", "")

```

      
  </li>
	<li><strong>解析命令行选项</strong>
  如下是一个关于解析命令选项的代码片段, 使用的是getopt库, 而且是一种相对比较复杂的方式...在本例中, 程序会接受3个参数, 同时需要至少两个参数.
    
``` css

import sys, getopt, os.path
me = os.path.basename(sys.argv[0])

debug   = False
really  = True
verbose = False

my_options = (
    ("d", "debug",     "debug   = True",  "Enable debug mode."),
    ("n", "notreally", "really  = False", "No action, display only."),
    ("v", "verbose",   "verbose = True",  "Increase verbosity.")
)

short_opts = reduce(lambda a, b: a + b[0], my_options, "")
long_opts  = map(lambda x: x[1], my_options)

def usage ():
    args = "[-%s] <dir1> <dir2> [...]" % short_opts
    print >> sys.stderr, "Usage: ", me, args, "\nOptions:"
    for opt in my_options:
        print >> sys.stderr, "-" + opt[0], opt[3]
    sys.exit(1)

try:
    opts, args = getopt.getopt(sys.argv[1:], short_opts, long_opts)
except getopt.GetoptError:
    usage()

for o, p in opts:
    for shrt, lng, action in my_options:
        if o[1:] in shrt or o[2:] == lng:
            exec action
            break
    else:
        usage()

if len(args) < 2:
    usage()

```
  
  </li>
	<li><strong>python与shell的结合</strong>

	有时候写一个既可以用于shell的也可以用于python的脚本会非常有帮助的. 这也是可行的, 技巧就是: 在shell中四个引号的序列作为代表引用, 而在python中用3个引号. 所以你可以把shell命令嵌套在一个三个引号中. 注意一般最开始的字符代表的都是这个模块或者脚本的doc信息, 所以通常会被python的编译所忽略.

如下的例子中演示了这一技巧. 首先它是作为一个shell脚本(因为在首行声明了#!/bin/sh). 然后嵌套的shell命令会检查是否安装了python. 如果没有的话, 就会出现一个非常有意义的错误信息, 同时脚本退出. 如果有的话, 脚本会再次用python执行. python会忽略所有包含在三个引号内的注释信息,同时执行剩下的部分.

如果你希望能有一个真实的doc信息, 你必须在之后声明它.如下:

``` css

#!/bin/sh

"""":
if which python >/dev/null; then
    exec python "$0" "$@"
else
    echo "${0##*/}: Python not found. Please install Python." >&2
    exit 1
fi
"""

__doc__ = """
Demonstrate how to mix Python + shell script.
"""

import sys
print "Hello World!"
print "This is Python", sys.version
print "This is my argument vector:", sys.argv
print "This is my doc string:", __doc__
sys.exit (0)

```

</li>
	<li><strong>把signal numbers转换为names</strong>
	不幸的是在signal模块中并不存在一个转换signal number到signal name的函数, 虽然通常来说这会很有帮助. 如下的函数可以做到这一点:

``` css

import signal

def signal_numtoname (num):
    name = []
    for key in signal.__dict__.keys():
        if key.startswith("SIG") and getattr(signal, key) == num:
            name.append (key)
    if len(name) == 1:
        return name[0]
    else:
        return str(num)

```

</li>  
  
</ul>


