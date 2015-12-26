date: 2015-11-19 4:00:00
title: preventDefault and stopPropagation in JS
category: tech 
description: This post will tell you when you should use preventDefault and stopPropagation in JS.
tags: [JS,jQuery,propagation] 
author: taoalpha
language: en
---

## Introduction

When we deal with event on DOM, jQuery always very helpful. But javascript has this mechanic called event bubbling is quite annoying. So be careful when you deal with them.

## Event Bubbling

We all know DOM elements can be nested inside each other which is great for structure. But it causes some troubles when you want to deal with the event on the children and parent separately. Because if we do nothing with that, the event like 'click' happened on children will trigger the same event for parents too, which is event bubbling.

## Event Capturing

All browsers except IE<9, there are two stages of event processing, one is event bubbling, another is event capturing. Opposite with event bubbling, the event capturing will go down along the html structure and trigger the corresponding event. And by default: All methods of event handling ignore the caputiring phase. Using addEventListener with last argument true is only the way to catch the event at capturing.

## How to deal with them

In JavaScript, we have two handy fucntions called stopPropagation() and preventDefault() can help us deal with the event bubbling and event capturing. Former one can stop the event bubbling so click or other events happened on children won't affect parents events. Latter one can prevent default event handlers defined in this element so you can rewrite the event handlers by youself.

## When you need deal with them

When you need deal with event bubbling? It depends, but most times, you will deal with that when you want to assign events on an area instead of a specific elements.

## Summary

Event bubbling and capturing are really cool stuffs and let you do some fantastic things. But also they are pretty annoying that may cause a lot troubles when you want to detect the bugs in your code...
