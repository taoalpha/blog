---
layout: post
title: Use Django with Bower and Pipeline
category: tech
description: Integrate bower and coffee-script, sass into django.
tags: [django,python]
author: taoalpha
language: en
---

## Intro

Since I decided to focus on python and JS, I started to dig into these two babies.

I use django as my web framework in python, so how to build a website easier is what I most concerned. I used yeoman for a while, pretty amazing and convenient, especially the bower and compressor, compiler.

So I did some search and study, trying to integrate the bower and compressor, compiler into django since I am getting used to the yeoman workflow.

## How to do that

Python is great for extensions. It has so many modules you can find and build for it. So in order to integrate the bower and compressor, compiler into django, we need two modules:

### [django-bower](https://github.com/nvbn/django-bower)

Just like other modules, you can install django-bower easily through `pip`:

{% highlight shell %}
pip install django-bower
{% endhighlight %}

After you installed , you need add it into your `INSTALLED_APPS` in your project settings with the name is 'djangobower'. And If you don't want to add the component file path by youself, you can use `djangobower.finders.BowerFinder` to do that for you. Just add it into your `INSTALLED_FINDERS`.

You can also set the `BOWER_COMPONENTS_ROOT` to put all your packages into one place. And if you want, you can set the path to bower manually: `BOWER_PATH=path_to_bower`

So after these, how to use it?

Easy, you can manage your packages in your project settings with `BOWER_INSTALLED_APPS=('jquery','bootstrap#4.0.0-alpha',)`, and put all your packages names into it. Just similar to what you did in `bower.json`.

And for installing all the packages, you just need to run `python manage.py bower_install -- --allow-root`(you can get rid of the `-- --allow-root` if you don't receive the sudo error)

And it will install all the packages you have listed in your settings.

The last step and most important step, you need to collect all your static files into your static folder. Just run:
`python manage.py collectstatic`.

Now you can just put 
{% highlight liquid %}
{% raw %}
{% load static %}
{% endraw %}
{% endhighlight %}

in the top of your template files and use

{% highlight liquid %}
{% raw %}
{% static 'static_path_to_you_modlue_file' %} 
{% endraw %}
{% endhighlight %}

anywhere you want.


That's it. Pretty much all about `django-bower`.

### [django-pipeline](https://github.com/cyberdelia/django-pipeline)

Now we got bower, so next step we need to get the compressor and compiler.

I use coffee-script as my pre-processor for JS. It's easy and super cool!!! Strongly recommended!

Bower is a pretty cool package manager, but it has nothing to do with your own scripts or stylesheets or html files. So in order to compress the files to minimize the size of files and to use coffee-script, sass in django. You can install `django-pipeline`.

Just like `django-bower`, you can also install `django-pipeline` with pip:

{% highlight shell%}
pip install django-pipeline
{% endhighlight %}

Same as `django-bower`, you need put some essentials into your project setting file.

{% highlight python%}
INSTALLED_APPS = (
  ...
  'pipeline',
)
STATICFILES_STORAGE = 'pipeline.storage.PipelineCachedStorage'
# if you don't want the version files, you can just use `PipelineStorage` instead of `PipelineCachedStorage`

STATICFILES_FINDERS = (
  ...
  'django.contrib.staticfiles.finders.FileSystemFinder',
  'django.contrib.staticfiles.finders.AppDirectoriesFinder',
  'pipeline.finders.PipelineFinder',
)

STATICFILES_DIRS = (
  'absolute_path_to_your_static_folder',
)
# this will tell finders to find static files in these folders

STATICFILES_STORAGE = 'pipeline.storage.PipelineStorage'

PIPELINE_ENABLED = True
# This will enable the compress

PIPELINE_CSS = {
    'group_name': {
        'source_filenames': (
          'relative_path_to_your_files',
        ),
        'output_filename': 'relative_path_to_your_output_file',
        'extra_context': {
            'media': 'screen,projection',
        },
    },
}
# in source_filenames, the path of your files is relative to your static file dirs, the Finders will look for each folder you set in the STATICFILES_DIRS.
# in output_filename, the path is relative to the STATIC_ROOT you set in your settings.

PIPELINE_JS = {
    'group_name': {
        'source_filenames': (
          'relative_path_to_your_files',
        ),
        'output_filename': 'relative_path_to_your_output_file',
    }
}
# same with css

PIPELINE_COMPILERS = (
    'pipeline.compilers.coffee.CoffeeScriptCompiler',
    'pipeline.compilers.sass.SASSCompiler',
)
# in order to use these compilers, you need install them first !

{% endhighlight %}

After finish the configuration, we can use it. In my case, I create a `customize` folder to store all the customized styles and scripts. So i put this folder into my `STATICFILES_DIRS` and create a simple group in `PIPELINE_CSS`.

After that, just run the `python manage.py collectstatic`. All your file will be copying and moving to your `STATIC_ROOT`.

Same with `django-bower`, you can set the path to `sass` or `coffee-script` manually if you want (like `PIPEPLINE_SASS_BINARY=''`).

In your template, you can either load the file like what you did in `django-bower`(or default way, precisely), or you can load it using `pipeline`:

put 
{% highlight liquid %}
{% raw %}
{% load pipeline %}
{% endraw %}
{% endhighlight %}

into the top of your template files, and use 

{% highlight liquid %}
{% raw %}
{% stylesheet 'group_name'}
{% endraw %}
{% endhighlight %}

 to import the stylesheet, same for javascript with `javascript` keyword.

All done.

## Enjoy it

Now you have bower, coffee-script, sass in your django. Enjoy the modern web coding style!!

Thanks & Best!
