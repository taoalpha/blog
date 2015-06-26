---
layout: post
category: tech
series: Patch Series from Previous Blog
description: ''
title: Patch-Day36-sublime下的python环境配置
tags: [python,sublime,Patch]
---

 sublime作为新兴的编辑器最近也是越来越火, 很多人都开始使用并且很快的喜欢上了这个编辑器, 而sublime本身也不负重望, 在变得越来越易用的同时也越来越强大, 还记得以前有人说过, vim的插件扩展模式是vim得以辉煌的最大原因. 而sublime也是如此, 其本身的丰富属性是它广受好评的一点, 但更重要的原因就是sublime非常丰富的插件.

 sublime如今已经发布版本3很久了, 不过因为插件的原因很多人还停留在2, 其实顺手就行, 版本倒是其次了~~ sublime本身不收费即可使用全部功能, 只会时不时的弹出欢迎购买的对话框~

 说道sublime的插件, 就必须先说一package control! 这个是开启sublime神器生涯的第一站!

 <a href="https://sublime.wbond.net/installation" target="_blank">这里有一个安装package control的介绍, 非常详细!</a>我就不多说了~

这里主要介绍下python和sublime的配合:

<ul>
    <li>主题: 强烈推荐Tomorrow Night,很友好, 很舒服~ 安装方法就是在package control中搜索Tomorrow Night就行了(下面的包也都是这样~);</li>
    <li>All Autocomplete: 将sublime本身局限在当前文档的自动完成扩展到所有打开的文件之中~ 这样对于project级别的工程有很大的好处~</li>
    <li>sublimeCodeIntel: 此工具支持很多种语言的自动完成, 包括python, 有了它, sublime就可以变成一个非常简单的IDE了~</li>
    <li>sublimerepl: 支持你直接在编辑器中运行python, 方便调试;</li>
    <li>pylinter: 帮助你检测你的python代码是否符合规范~</li>
    <li>Preference:
        <ul>
            <li>User全局:
                
{% highlight python %}

                    {
    // Colors
    "color_scheme": "Packages/Tomorrow Color Schemes/Tomorrow-Night.tmTheme",
    "theme": "Soda Dark.sublime-theme",

    // Font
    "font_face": "Ubuntu Mono",
    "font_size": 16.0,
    "font_options": ["subpixel_antialias", "no_bold"],
    "line_padding_bottom": 0,
    "line_padding_top": 0,

    // Cursor style - no blinking and slightly wider than default
    "caret_style": "solid",
    "wide_caret": true,

    // Editor view look-and-feel
    "draw_white_space": "all",
    "fold_buttons": false,
    "highlight_line": true,
    "auto_complete": false,
    "show_minimap": false,
    "show_full_path": true,

    // Editor behavior
    "scroll_past_end": false,
    "highlight_modified_tabs": true,
    "find_selected_text": true,

    // Word wrapping - follow PEP 8 recommendations
    "rulers": [ 72, 79 ],
    "word_wrap": true,
    "wrap_width": 80,

    // Whitespace - no tabs, trimming, end files with \n
    "tab_size": 4,
    "translate_tabs_to_spaces": true,
    "trim_trailing_white_space_on_save": true,
    "ensure_newline_at_eof_on_save": true,

    // Sidebar - exclude distracting files and folders
    "file_exclude_patterns":
    [
        ".DS_Store",
        "*.pid",
        "*.pyc"
    ],
    "folder_exclude_patterns":
    [
        ".git",
        "__pycache__",
        "env",
        "env3"
    ]
}
                
{% endhighlight %}
</li>
            <li>pylinter.sublime-settings: 推荐写在user里:
                
{% highlight python %}

                    {
    // Configure pylint's behavior
    "pylint_rc": "/Users/daniel/dev/pylintrc",

    // Show different icons for errors, warnings, etc.
    "use_icons": true,

    // Automatically run Pylinter when saving a Python document
    "run_on_save": true,

    // Don't hide pylint messages when moving the cursor
    "message_stay": true
}                    }
                
{% endhighlight %}
</li>
        </ul>
    </li>
</ul>
综上, 通过上述的设置后, 你的sublime和你的python就会配合的非常圆满了~哈
截图为证:
<a href="http://callmet.zzgary.info/wp-content/uploads/2014/01/sublime-python.png"><img src="http://callmet.zzgary.info/wp-content/uploads/2014/01/sublime-python.png" alt="sublime-python" width="493" height="245" class="size-full wp-image-1196" /></a>

