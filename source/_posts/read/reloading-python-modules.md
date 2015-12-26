category: dandp
description: ''
date: 2015-02-16 8:00:00
title: Reloading Python Modules
tags: [python,翻译文章,应用推荐与技巧,coding]
---

<p><a href="http://www.indelible.org/ink/python-reloading/">Reloading Python Modules</a>是一篇10年的老文了. 不过正好最近有看到Python中reload的相关介绍, 推荐了本文, 特地译来加深记忆以及分享给大家:</p>

<p>Python众多优点中的一个就是可以对代码模块进行重载. 这就允许了开发者即便在Python的编译器运行状态下也可以修改Python代码了. 通常来说,  只需要把对应要重载的模块对象传入 <a href="http://docs.python.org/3.1/library/imp.html#imp.reload">imp.reload()函数</a>中即可(python 2.x中是通过直接<a href="http://docs.python.org/2.6/library/functions.html#reload">reload()</a>来实现). </p>

<p>不过这里面还有几个潜在的复杂问题.</p>

<p>如果一个模块中引入了重载模块的一些symbols, 那么这些symbols不会自动重载. 比如, 我们有一个包含了常量 INTERVAL = 5的A模块, 而模块B则引入了这一常量, 比如通过(from A import INTERVAL). 那么如果我们修改INTERVAL = 10, 然后重载A模块的话, 在B模块中的INTERVAL以及所有基于INTERVAL的值都不会自动更新的.</p>

<p>解决这一问题的办法就是我们要把B模块也重载一些. 但是要注意的是一定要在A模块重载完后重载B, 不然的话, B还是不能按照更新后的A来执行.</p>

<p><a href="http://pyunit.sourceforge.net/">PyUnit</a>则通过引入了一个 <a href="http://pyunit.sourceforge.net/notes/reloading.html">rollback
importer</a>的方式来处理这类问题. 它会通过重写python的全局引入 <strong>import</strong>而将引入规则"rolls back"到之前的状态.  这一方法在让编译器还原到前一测试点上非常便捷, 但是却不能算是一个解决实时代码重载的好方法, 因为那些为加载的模块还是不能自动的重载.</p>

<p>下述介绍了一个很好的模块重载解决方法, 目的是让这一过程更加自动化, 更加透明以及可靠.</p>

<h4>Recording Module Dependencies</h4>

<p>在重载前一定要清楚各个模块之间依赖关系, 这样才能很好的设计重载的顺序. 理想的方法是建立一个模块之间的依赖关系图谱. 这可以通过引入一个自定义的import, 并且在程序常规代码部分引入它来实现.</p>

<p>import builtins</p>


``` css
_baseimport = builtins.__import__
_dependencies = dict()
_parent = None

def _import(name, globals=None, locals=None, fromlist=None, level=-1):
    # Track our current parent module.  This is used to find our current
    # place in the dependency graph.
    global _parent
    parent = _parent
    _parent = name

    # Perform the actual import using the base import function.
    m = _baseimport(name, globals, locals, fromlist, level)

    # If we have a parent (i.e. this is a nested import) and this is a
    # reloadable (source-based) module, we append ourself to our parent's
    # dependency list.
    if parent is not None and hasattr(m, '__file__'):
        l = _dependencies.setdefault(parent, &lt;input type=checkbox&gt;)
        l.append(m)

    # Lastly, we always restore our global _parent pointer.
    _parent = parent

    return m

builtins.__import__ = _import
</code>
```


<p>这里把内置的<strong>import</strong>函数(在_baseimport类中)做了简单的修改. 它能够跟踪当前的母模块(依赖模块), 也就是进行import操作的模块. 而最顶层的模块自然是没有依赖模块的.</p>

<p>而一旦一个模块被成功的引入后, 它就会自动的加入到依赖模块的依赖列表中去. 你可能注意到上述代码中只是关注了那些基于文件的模块 内置的那些扩展则都被忽略了, 这是因为内置的模块是不能够被重载的.</p>

<p>这就给我们了一个完整的模块依赖关系链, 我们就能够轻松的获取到某个模块相关的所有依赖模块了:</p>


``` css
def get_dependencies(m):
    """Get the dependency list for the given imported module."""
    return _dependencies.get(m.__name__, None)
</code>
```


<h4>Reloading Modules</h4>

<p>在知道了相关的依赖模块关系后, 我么就可以建立一个依赖模块重载路线了:</p>


``` css
import imp

def _reload(m, visited):
    """Internal module reloading routine."""
    name = m.__name__

    # Start by adding this module to our set of visited modules.  We use
    # this set to avoid running into infinite recursion while walking the
    # module dependency graph.
    visited.add(m)

    # Start by reloading all of our dependencies in reverse order.  Note
    # that we recursively call ourself to perform the nested reloads.
    deps = _dependencies.get(name, None)
    if deps is not None:
        for dep in reversed(deps):
            if dep not in visited:
                _reload(dep, visited)

    # Clear this module's list of dependencies.  Some import statements
    # may have been removed.  We'll rebuild the dependency list as part
    # of the reload operation below.
    try:
        del _dependencies[name]
    except KeyError:
        pass

    # Because we're triggering a reload and not an import, the module
    # itself won't run through our _import hook.  In order for this
    # module's dependencies (which will pass through the _import hook) to
    # be associated with this module, we need to set our parent pointer
    # beforehand.
    global _parent
    _parent = name

    # Perform the reload operation.
    imp.reload(m)

    # Reset our parent pointer.
    _parent = None

def reload(m):
    """Reload an existing module.

    Any known dependencies of the module will also be reloaded."""
    _reload(m, set())
</code>
```


<p>上述reload()函数通过递归方式去按照相反顺序依次reload所有和这一模块相关的模块, 而最后再reload以下自身. 它通过<strong>visited</strong>属性的设置来避免出现无限死循环. 同时在reload的时候它会自动重建模块的依赖关系, 来确保他们能精确的反映出模块的更新状态.</p>

<h4>Custom Reloading Behavior</h4>

<p>有时候reload模块的时候可能需要执行一些其他的操作或者逻辑. 比如, 重新初始化一些预加载的状态. 而为了支持这一点, 我们需要让我们的reload函数去寻找一个模块级函数<strong>reload</strong>(). 这一函数可以在一个成功的重载后被调用, 且能保留重载前的状态.</p>

<p>这种情况下, 我们就不能简单的直接调用imp.reload()了:</p>


``` css
# If the module has a __reload__(d) function, we'll call it with a
# copy of the original module's dictionary after it's been reloaded.
callback = getattr(m, '__reload__', None)
if callback is not None:
    d = _deepcopy_module_dict(m)
    imp.reload(m)
    callback(d)
else:
    imp.reload(m)
</code>
```


<p>其中<code>_deepcopy_module_dict()</code>的作用是帮助我们避免<code>deepcopy()</code>一些不支持或者不需要的数据.</p>


``` css
def _deepcopy_module_dict(m):
    """Make a deep copy of a module's dictionary."""
    import copy

    # We can't deepcopy() everything in the module's dictionary because
    # some items, such as '__builtins__', aren't deepcopy()-able.
    # To work around that, we start by making a shallow copy of the
    # dictionary, giving us a way to remove keys before performing the
    # deep copy.
    d = vars(m).copy()
    del d['__builtins__']
    return copy.deepcopy(d)
</code>
```


<h4>Monitoring Module Changes</h4>

<p>对于重载而言, 能够自动检测模块的变化而进行自动重载那是最好不过了. 那么, 实际上我们确实有很多方式来检测一个文件的变化情况. 这里使用的是一个后台线程以及 <a href="http://docs.python.org/library/os.html#os.stat">stat()</a>这个系统函数的调用来检测文件上一次修改时间, 从而确定其更新状态. 一旦检测到一个文件被更新, 那么就会把这一文件名加入到一个 <a href="http://docs.python.org/library/queue.html">thread-safe queue</a></p>


``` css
import os, sys, time
import queue, threading

_win = (sys.platform == 'win32')

class ModuleMonitor(threading.Thread):
    """Monitor module source file changes"""

    def __init__(self, interval=1):
        threading.Thread.__init__(self)
        self.daemon = True
        self.mtimes = {}
        self.queue = queue.Queue()
        self.interval = interval

    def run(self):
        while True:
            self._scan()
            time.sleep(self.interval)

    def _scan(self):
        # We're only interested in file-based modules (not C extensions).
        modules = [m.__file__ for m in sys.modules.values()
                if '__file__' in m.__dict__]

        for filename in modules:
            # We're only interested in the source .py files.
            if filename.endswith('.pyc') or filename.endswith('.pyo'):
                filename = filename[:-1]

            # stat() the file.  This might fail if the module is part
            # of a bundle (.egg).  We simply skip those modules because
            # they're not really reloadable anyway.
            try:
                stat = os.stat(filename)
            except OSError:
                continue

            # Check the modification time.  We need to adjust on Windows.
            mtime = stat.st_mtime
            if _win32:
                mtime -= stat.st_ctime

            # Check if we've seen this file before.  We don't need to do
            # anything for new files.
            if filename in self.mtimes:
                # If this file's mtime has changed, queue it for reload.
                if mtime != self.mtimes[filename]:
                    self.queue.put(filename)

            # Record this filename's current mtime.
            self.mtimes[filename] = mtime
</code>
```


<p>此外还可以通过调用原生操作系统的相关函数, 比如 <a href="http://msdn.microsoft.com/en-us/library/aa365261%28VS.85%29.aspx">Win32 Directory Change Notification</a>之类的函数.</p>

<p>加上我们的reloader()部分:</p>


``` css
import imp
import reloader

class Reloader(object):

    def __init__(self):
        self.monitor = ModuleMonitor()
        self.monitor.start()

    def poll(self):
        filenames = set()
        while not self.monitor.queue.empty():
            try:
                filenames.add(self.monitor.queue.get_nowait())
            except queue.Empty:
                break
        if filenames:
            self._reload(filenames)

    def _reload(self, filenames):
        modules = [m for m in sys.modules.values()
                if getattr(m, '__file__', None) in filenames]

        for mod in modules:
            reloader.reload(mod)
</code>
```


<p>在这一模型中, reloader需要循环执行来检测文件的状态, 从而能够计时的响应. 最简单的则是:</p>


``` css
r = Reloader()
while True:
    r.poll()
    time.sleep(1)
</code>
```


<p>想要看源代码的可以前往:  <a href="https://github.com/jparise/python-reloader">complete source code</a> 本身代码也发布到Python Package Index中, 名称为  <a href="http://pypi.python.org/pypi/reloader/">reloader</a></p>
