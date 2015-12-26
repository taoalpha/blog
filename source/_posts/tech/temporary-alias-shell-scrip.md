date: 2015-06-05 6:00:00
title: 通过 shell 脚本设定临时 alias 
category: tech 
description: 开发过程中经常会涉及到很多重复性的命令, 对于那些全局性的我们可以在`.bashrc`或者类似文件中设置alias来简化, 那么如果我们只是临时使用的话, 又该如何设置呢?
tags: [shell,alias] 
author: taoalpha
---

## 缘起

对于习惯在命令行下工作的人, 设定方便好用的aliases是必备工作之一. [Github](https://github.com/search?q=aliases&ref=opensearch)上就有很多人分享自己设定的aliases,这里就不多说设定aliases的事情了.

由于最近修改blog, 需要经常在各个路径下跳转, 每次cd的痛不欲生... 于是就捣鼓了下临时alias的问题.

## 如何设置临时aliases

首先, 这里的**临时**的意思是指在当前session内生效的意思. 也就是说我关了当前的terminal或者iterm的tab, 新开一个这些aliases就不会继续生效了. 其生命周期只存在于当前session内. 这样就不会污染了. 方法有两种, 分别介绍如下:

### 利用alias命令

linux 或者 mac os本身都是自带有alias命令的, 支持你在命令中设定临时别名. 

``` bash
alias blog='cd ~/github/blog'
```

如此设定的aliases就是临时别名, 只在当前session内有效. 但是如果你要设定的别名比较多, 或者说你需要在一段时间内都用的话, 这样每次输入就不方便了.

### 写shell脚本

所有直接在命令行里执行的命令都可以写在`.sh`文件里, 然后通过相应的命令来执行. 比如 alias:

``` bash
# temp_alias.sh
alias blog='cd ~/github/blog'
alias css='cd ~/github/blog/_assets/stylesheets'
alias js='cd ~/github/blog/_assets/javascripts'
```

如此写好这个`temp_alias.sh`文件后, 我们就可以执行了.

通常来说, shell脚本的执行都是通过`sh path_to_shell/xxx.sh`来执行的; 但是, 对于alias而言, 因为我们是设定的是**临时**的别名, 而每次`sh`命令的执行都是新开一个session执行对应的命令, 这样的话, 我们的alias都是在那个隐藏的看不见的新开的session中生效, 而不会在当前session中生效, 这样就无法达到我们的目的了. 那么怎么做呢?

如果使用`zsh`或者类似的bash替换程序的人, 看过其`.zshrc`就应该很熟悉`source`这么一个命令了. `source`的含义就是**在当前bash环境下读取并执行文件中的命令**.

``` bash
# temp_alias.sh
alias blog='cd ~/github/blog'

# command
source temp_alias.sh

# 通常source和.是等价的, 所以上述命令也可以写为:
# .
. ./temp_alias.sh
```

## Reference

- [How to set an alias inside a bash shell script](http://stackoverflow.com/questions/2197461/how-to-set-an-alias-inside-a-bash-shell-script)
- [shell:source](http://bash.cyberciti.biz/guide/Source_command)


恩~ shell其实真的有很多东西值得研究的~ 哈哈
