date: 2016-04-22 7:00:00
title: Two-way and one-way data binding
category: tech
description: Two-way and one-way data binding
tags: [data binding]
author: taoalpha
---

## Write Ahead
I start learning React recently, and since I haven’t written Angular code for several weeks, I guess I need to review some basic concepts during the self-learning :)

The first book which I am reading is Mastering React, it is pretty good, and I think if you want to learn React, you can start from this one.

## Data Binding
If you have ever used react or angular before, you should have heard about the words more or often. So what is data binding ?

{% blockquote WikiPedia https://en.wikipedia.org/wiki/Data_binding Data Binding from Wikipedia %}

Data binding is a general technique that binds data sources from the provider and consumer together and synchronizes them. This is usually done with two data/information sources with different languages as in XML data binding. In UI data binding, data and information objects of the same language but different logic function are bound together.
{% endblockquote %}

Want to simplify it ? I think we can consider the data binding as a connection between Model and View which would be the web UI in web field (most times). And then synchronize the data between Model and View.

Depends on the direction of the data flow and the limitation on the frequency of the flow, we have several different ways of data binding.

### Two-way data binding
This one is pretty intuitive since that is what most people believe synchronization means.

- Data always flows between Model and View
- For Data in Model:
  - Gets propagated to View
  - If have Data Modifications: Propagated immediately and reflected in View
- For Data in View:
  - Gets propagated to Model
  - If have Data Modifications: Propagated immediately and reflected in Model

So if we use two-way data binding, we always have the same data in Model and View.

### One-way data binding
Sometimes you will think two-way binding is too complex and may cause some confusion. Then you will like the idea of one-way binding, the data only flows from Model to View.

- Data always flows from Model to View
- For Data in Model:
  - Gets propagated to View
  - If have Data Modifications: Propagated immediately and reflected in View
- For Data in View:
  - No propagation happens (back to scope) for any data change

This is what react is using.

### One-time data binding
Sometimes you may just want to send the data and only do it once, you may want to use one-time data binding.

- Data only flows from Model to View once
- For Data in Model:
  - Gets propagated to View (only once for the first time)
  - If have Data Modifications: No Propagation
- For Data in View:
  - No propagation happens (back to scope) for any data change

## Conclude
Angular will be the first choice if you want to be familiar with all three different ways or you need different binding methods in your web app. If you want to simplify your data flow of your app, you may try React, even though you may write more codes to achieve the same thing you can do with one line code in Angular(two-way binding).