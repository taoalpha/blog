date: 2015-06-20 1:00:00
title: A simple python script to analyse all ips in nginx access log
category: tech 
description: This is an old post which I post it on my previous blog several months ago, mainly about how I use python to analyse my nginx log to get all visitors' ip and details to let me know which university had visited my portfolio.
tags: [python,nginx] 
author: taoalpha
language: en
---

I wrote this script and this post several months ago on my [previous blog](http://callmet.zzgary.info), mainly used during my application. And I think it is pretty useful. So I move it in and hope it can help you in some way.

=============The Origin==============

As time gets closer to the March, I feel more and more nervous… And since most of HCI programs I submitted require you submit your portfolio website, I want to keep watching my nginx access log and get a summary about where all the accesses come from. So I wrote a simple python script to get all the ips from the nginx-access.log and analyse the ip with the json API provided by ipinfo.io.

Here is the script, anyone who want to get more information about your access ip and also don’t want or don’t know how to use the google analysis maybe can give a try:

{% gist fe3934f7ffc7c095ab40 %}

before you run this script, you should create two empty output files: ipdetails.txt, errorips.txt in this example. you can change the filename if you want, just remember to change the name in script too.

Hope this script can help you! Thanks. Have a nice day!

=================PS==================

You can find some spamips from the internet, and almost most of them are pretty large, maybe 30-50 megabytes~ And according to my experience, I think it would be alright if you don't import the spamips file~

