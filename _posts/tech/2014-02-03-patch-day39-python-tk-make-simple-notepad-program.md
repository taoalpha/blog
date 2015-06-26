---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day39-python-Tk制作简易记事程序
tags: [python,pyhook,coding,Patch,tk,记事]
---

好多天不用python, 尤其是最近写js写的特别多, 猛地一用起python, 竟然连for loop都忘记怎么写了...哈哈

闲来抽空写了一个简单的记事程序, 可以在任何时刻快捷呼出, 快捷查看. 起因很简单, 是因为要用stickynotes, 结果不知道为啥每次打开都会自动崩溃...而且觉得不够方便, 于是乎...正好准备看看python的gui部分, 所以就当练手把~(后来发现重启一次电脑后stickynotes的问题就没有了~)

tk全程是tkinter, 是python内置的gui module. 除了tk之外, 还有类似pyqt, wxpython等非常好用的第三方gui module. 相比这两者, tk更为简单, 更适合初学者上手. 但是, 界面也相对简陋, 控件也比较少... 但是满足这一次的需求还是没问题的~

从tk官网上copy了其中feet to meters的代码, 略作修改, 就有了记事的主程序界面:


{% highlight python %}

    def calculate(*args):
        with open("notes.txt","a") as fl:
            text = str(datetime.datetime.today())+"\t\t"+feet.get()+"\n\n"
            fl.write(text)
        root.destroy()
    //用以记录相应的信息到文本之中.
    root = Tk()
    root.title("notes")

    mainframe = ttk.Frame(root, padding="3 3 12 12")
    mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
    mainframe.columnconfigure(0, weight=1)
    mainframe.rowconfigure(0, weight=1)

    feet = StringVar()

    feet_entry = ttk.Entry(mainframe, width=100, textvariable=feet)
    feet_entry.grid(column=1, row=2, columnspan=3,sticky=(W, E))
    // 输入框, 这种表格的布局结构确实很方便的, 让我立刻就想到目前主流的几个html框架: bootstrap等都采用的这种方式~
    ttk.Label(mainframe, text="Things I want to writedown:").grid(column=1, row=1, sticky=W)
    // 一个文本label
    for child in mainframe.winfo_children(): child.grid_configure(padx=5, pady=5)
    // 用以为所有子元件增加一些间距
    root.geometry('620x70+300+300')
    // 控制窗口在屏幕的位置, 似乎只有绝对距离而没有相对..这一点比较尴尬.
    root.wm_attributes('-topmost',1)
    // 置顶
    root.tkraise('.')
    root.focus()
    // 上述部分的目的是用来让弹出窗口默认激活, 自动置为当前窗口;
    feet_entry.focus_force()
    // 焦点自动转移到输入框之中;
    root.bind('<Return>', calculate)
    root.mainloop()
    
{% endhighlight %}

运行就能跳出一个窗口用以记录了~ 具体的一些细节都记录在了注释中~

接下来主要是全局呼出的问题, 这一部分需要用pyHook这个库, 来监测全局的键盘事件.

{% highlight python %}

    def OnMouseEvent(event):
    return True

def OnKeyboardEvent(event):
    if (event.Alt == 32 and event.KeyID == 112):
        callapp()
    // 将之前的tk部分封装到一个函数中, 调用它即可
    if (event.Alt == 32 and event.KeyID == 113):
        sys.exit(0)
    //设置全局的退出快捷键
    return True

hm = pyHook.HookManager()
hm.KeyDown = OnKeyboardEvent
hm.HookKeyboard()
// 监测键盘事件

if __name__ == '__main__':

    import pythoncom
    pythoncom.PumpMessages()
    // 这一个是为了让脚本持续运行, 除非主动关闭.

{% endhighlight %}

以上基本就完成了基础的功能, 可以在运行此程序后, 按下设定的快捷键(本例中是Alt+F1), 然后就能调出tk的窗口记事了.
后面则主要是针对这一方法做了一些基本的优化:

{% highlight python %}

import win32api, win32gui
ct = win32api.GetConsoleTitle()
hd = win32gui.FindWindow(0,ct)
win32gui.ShowWindow(hd,0)
// 上述是为了在py脚本运行的时候自动最小化而设置的;
if (event.Alt == 32 and event.KeyID == 114):
    showapp()
通过同样第一个记事tk的方法, 可以做一个简单的查看窗口, 同样调用即可.

{% endhighlight %}

如此基本实现了最简单的记事功能, 整体界面如下:

<a href="http://callmet.zzgary.info/wp-content/uploads/2014/02/notes1.png"><img src="http://callmet.zzgary.info/wp-content/uploads/2014/02/notes1.png" alt="记事界面" width="636" height="109" class="size-full wp-image-1269" /></a>

<a href="http://callmet.zzgary.info/wp-content/uploads/2014/02/notes2.png"><img src="http://callmet.zzgary.info/wp-content/uploads/2014/02/notes2.png" alt="查看记录界面" width="596" height="439" class="size-full wp-image-1270" /></a>
