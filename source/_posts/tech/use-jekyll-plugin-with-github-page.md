date: 2015-05-29 2:00:00
title: 在 Github Pages 中使用Jekyll插件
category: tech 
description: 如何取巧的绕过 Github Pages 的 safe 模式, 从而使用 Jekyll 丰富的插件体系更好的服务于你的 blog
tags: [jekyll,plugin,github page]
author: taoalpha
---

## Github Page的jekyll

  Github Page对jekyll的支持是很到位的, 唯一的不足可能也是其本身基于安全考虑而使得jekyll始终都是运行在safe模式, 目前[放开的插件列表非常有限], 所以很多jekyll的插件都无法使用. 当然, 单纯支持的几个插件或者不用插件也是完全可以做出很好的效果的, 不过个人比较喜欢折腾, 所以虽然目前只有一个可有可无的压缩需求, 也为了以后的大肆折腾干脆一步到位~ 哈哈 当然, 如果以后github能够开放插件就最好啦.

## jekyll plugin

  作为一个流行的静态blog, jekyll的社区和支持者也是非常众多的, 大家可以在github上搜索jekyll就能找到很多jekyll的插件了. 当然, 你也可以前往[Jekyll-Plugins], 这算是一个jekyll plugin的集合地了~ 优点类似[VimAwesome]的感觉哈哈.

## 集成plugin的jekyll与github page

  闲话少说, 在github page不支持插件的情况下, 我们该如何选择呢? 

  - 换: github page主要是因为安全因素而强迫jekyll服务必须在safe下运行, 那么我们换一个服务器的话自然就完全由我们自己可控了, 或者换一个支持jekyll的公共服务即可;
  - 推: github page对jekyll的支持, 本质上还是对静态网页的支持, 所以如果我们在本地编译好jekyll然后把build后的`_site`文件夹推送到github page上也是肯定可以的;
  - 绕: 如果你觉得每次这么推送比较痛苦, 而且还是想要把jekyll部分的代码也放在github上的话, 那么可以考虑用一个绕一些的办法, 通过github本身支持project page, 结合**推**的办法, 我们就可以新建一个repo, 然后在master分支管理原始代码, 在gh-pages分支存放生成的site代码. 然后通过`xxx.github.io/repo-name`来访问了.

  本次主要介绍的是第三种方法:**绕**. 主要是便于管理~

### 新建repo
  
  首先新建一个repo, 这一步你可以在github上完成, 也可以通过命令行直接执行:

``` bash
curl -u 'github_name' https://api.github.com/user/repos -d "{\"name\":\"$repo_name\"}"
# 替换github_name为你的用户名, $repo_name为你想要的repo名称
```

### 迁移原站以及修改配置

创建好repo后, 就可以开始转移你已经放置在github page的jekyll主体了. 首先, 初始化你的新repo(以blog为例):

``` bash
mkdir blog
cd blog
touch README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin git@github.com:your_username/blog.git
git push -u origin master
```

接下来, copy 你原路径下所有和jekyll相关的文件到blog下, 这一步代码就省略了~

文件转移后, 就需要修改一下jekyll的`_config.yml`以及一些引用代码来适应新的博客结构:

- baseurl: 因为路径修改, 所以这里需要设定以下baseurl, 从而确保后面的资源应用都正常;
- permalink: 这里要视情况而定, 因为我之前的页面中设定的也是blog作为二级目录, 所以这里修改到project page后, 继续保留blog的话, 博文的链接就会变成`/blog/blog/xxxx`了, 所以这里permalink去除了blog;
- 资源引用: 如果后面模板等部分使用了对应的相对路径引用资源的话, 这里就需要做对应的修改(比如从"/js/xxx"到"/blog/js/xxx"), 这里推荐都是用`site.baseurl`来引用,方便修改;

修改完相关的配置和路径后, 基本迁移部分就做的差不多了.

### 本地测试

  同样的, 虽然我们把jekyll转移到了project page里面, 我们本地测试环境还是照样需要的. 如果你是通过`_config.yml`中的`baseurl`来修改的资源引用, 那么你就可以直接继续使用`jekyll serve`来查看本地环境, 这个时候会自动转换server address到`http://127.0.0.1:4000/blog/`(你对应的baseurl).

  但是如果你不是通过baseurl, 而是手动更改代码中的资源引用的话, 那么这里你直接运行`jekyll serve`的话, 就可能遇到css引用失败等等错误, 这个时候你可以通过jekyll的`--baseurl``参数来指定baseurl.

  另外, 因为jekyll自身的问题, 一旦设定baseurl后, 你的首页访问只能通过`http://localhost:4000/blog/index.html`, 而不能使用`http://localhost:4000/blog`... [爱莫能助]

### 添加Rakefile实现自动推送

  一切调整妥当后, 我们就可以push到github中, 然后将build的site文件夹推送到gh-pages分支了~ 听起来就挺麻烦的是吗... 哈哈, 我们也有简单的办法实现自动的推送更新, 那就是Rakefile, 你需要在根路径下新建一个Rakefile文件, 然后复制下述代码到其中即可:

``` ruby
    require 'rubygems'
    require 'rake'
    require 'rdoc'
    require 'date'
    require 'yaml'
    require 'tmpdir'
    require 'jekyll'

    desc "Generate blog files"
    task :generate do
      #Jekyll::Site.new(Jekyll.configuration({
      #  "source"      => ".",
      #  "destination" => "_site"
      #})).process
      system "bundle exec jekyll build"
      # fix the problem caused by updating the modules to the latest version
    end


    desc "Generate and publish blog to gh-pages"
    task :publish => [:generate] do
      Dir.mktmpdir do |tmp|
        system "mv _site/* #{tmp}"
        system "git checkout -B gh-pages"
        system "rm -rf *"
        system "mv #{tmp}/* ."
        message = "Site updated at #{Time.now.utc}"
        system "git add ."
        system "git commit -am #{message.shellescape}"
        system "git push origin gh-pages --force"
        system "git checkout master -f"
        system "echo yolo"
      end
    end

task :default => :publish
```

上述代码就是用来帮助你简化发布环节的~ 当然你要是用shell自己写也是没问题的哈哈哈

<blockquote class="special update" markdown="1" data-flag="gotsomeupdateshere">

### Update

这里遗留了一个问题就是在切换分支的过程中因为会`rm -rf *`, 所以我们在master分支定义在`.gitignore`的文件就会丢失了. 比如我用`bower`管理的各种包, 就会因为这个而在每次`rake`之后丢失...

为了解决这个问题, 我们需要修改以下上述的rakefile:

``` ruby
      Dir.mktmpdir do |tmp|
        system "mv _site #{tmp}"
        # 这里需要改成将_site整个文件夹移动到tmp
        system "mv _assets/vendors #{tmp}"
        # 然后把你需要保留的位于ignore中的文件也移动到tmp去
        system "git checkout -B gh-pages"
        system "rm -rf *"
        system "mv #{tmp}/_site/* ."
        # 这里就要变成移动tmp/_site下的所有文件到当前分支了
        message = "Site updated at #{Time.now.utc}"
        system "git add ."
        system "git commit -am #{message.shellescape}"
        system "git push origin gh-pages --force"
        system "git checkout master -f"
        system "mv #{tmp}/vendors ./_assets/"
        # 在checkout到master之后, 再把对应的保留文件移回来即可.
        system "echo yolo"
        # 这里就可以执行一些别的小命令, 比如我就会让它每次cat一下我的todo.log, 然后就能知道下一步要做什么了哈哈 
      end
```

恩, 这样一来, 就不用每次rake完还需要我们自己bower install一下了, 尤其是面对我们修改了dependencies的代码的情况, 就更加适用了~

</blockquote>


## 插件安装
  
  根据jekyll插件的设定, 主要有三种插件安装的方式:

  - 在根目录下新建`_plugins`文件夹, 然后把对应的`*.rb`插件文件放进去就行了;
  - 在`_config.yml`文件中增加一个`gems`关键字, 然后把要引用的插件用数组形式存储其中即可;
  - 在`Gemfile`中添加相关的插件;

  三种方法都可以, 甚至完全可以同时使用~ 


恩~ 快去安装插件去吧!


[放开的插件列表非常有限]: https://help.github.com/articles/using-jekyll-plugins-with-github-pages/ "Using Jekyll Plugins with GitHub Pages"
[Jekyll-Plugins]: http://www.jekyll-plugins.com/ "Jekyll Plugins"
[VimAwesome]: http://vimawesome.com/ "Vim Plugins"
[爱莫能助]: http://jekyllrb.com/docs/troubleshooting/#base-url-problems "base-url problem of jekyll"
