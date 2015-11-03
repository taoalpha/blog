---
layout: post
title: Implement LRU Cache in JavaScript
category: tech 
description: This is one step for my whole implement-everything-in-javascript journey.
tags: [JS,LRU] 
series: Implement in JS
author: taoalpha
language: en
---

## Introduction

LRU which is short for least recently used is a popular algorithm in cache. The basic idea is always put your items in order of used time, and when you insert new item into the fullfilled chache,remove the least recently used item in your memory.


## Implementation

### O(n)

At first, I plan to use a hashtable and a list with all keys to achieve it, and I did, but the time cost apparently too large: O(n) since I have to search the list to get the key and then get the value from the hashtable.

Here is the code:

{% highlight javascript %}
// constructor
var LRUCache = function(capacity){
  // save all key-value pairs in this hashtable
  this.bucket = {}
  // save all keys in the stack with the order of last used time
  this.keys = []
  this.capacity = capacity
  this.length = 0
}

LRUCache.prototype.updateKey = function(key){
  // update the position of this key in keys 
  var keyIndex = this.keys.indexOf(key)
  this.keys[keyIndex] = undefined
  // update the key to the head of the stack
  this.keys.push(key)
}
LRUCache.prototype.get = function(key){
  if(this.bucket.hasOwnProperty(key)){
    this.updateKey(key)
    return this.bucket[key]
  }else{
    return -1
  }
}

LRUCache.prototype.set = function(key,value){
  if(this.capacity <= 0){console.log("no memory to save 1 item");return}
  // update exist item 
  if(this.bucket.hasOwnProperty(key)){
    this.bucket[key] = value
    this.updateKey(key)
    return
  }
  
  // if the bucket is fullfilled, remove the least recently used item
  if(this.length >= this.capacity){
    var dKey = this.keys.shift()
    while(!dKey){
      // if the dKey is undefined, shift() again
      dKey = this.keys.shift()
    }
    delete this.bucket[dKey]
  }

  // add new item and update the length
  this.bucket[key] = value
  this.keys.push(key)
  this.length ++
}
{% endhighlight %}

Can we do better ? Definitely. We can optimize it to O(1) if we use double linked list to achieve the same function.

### O(1)

If we reconstruct the LRUCache with a map and a bunch of nodes, we can implement the LRUCache with O(1).(Since we need to get the value by key, so it has to be a hashtable)

Why? Since we can save the key and value in the node, and save all key-node pairs in the hashtable, and now we can get the value by key using hashtable, and we also have a list of nodes with order of last used time and the update on a linked list can be O(1).

Here is the code:

{% highlight javascript %}

/*
 * Illustration of the design:
 *
 *       entry             entry             entry             entry
 *       ______            ______            ______            ______
 *      | tail |.newer => |      |.newer => |      |.newer => | head |
 *      |  A   |          |  B   |          |  C   |          |  D   |
 *      |______| <= older.|______| <= older.|______| <= older.|______|
 *
 */

var LRUCache = function(capacity){
  this.capacity = capacity
  this.length = 0
  this.map = {}
  // save the head and tail so we can update it easily
  this.head = null
  this.tail = null
}

LRUCache.prototype.node = function(key,value){
  this.key = key
  this.val = value
  this.newer = null
  this.older = null
}

LRUCache.prototype.get = function(key){
  if(this.map.hasOwnProperty(key)){
    this.updateKey(key)
    return this.map[key].val
  }else{
    return -1
  }
}
LRUCache.prototype.updateKey = function(key){
  var node = this.map[key]
  // break the chain and reconnect with newer and older
  if(node.newer){
    node.newer.older= node.older
  }else{
    this.head = node.older
  }

  if(node.older){
    node.older.newer = node.newer
  }else{
    this.tail = node.newer
  }

  // replace the node into head - newest
  node.older = this.head
  node.newer = null
  if(this.head){
    this.head.newer = node
  }
  this.head = node

  // if no items in the bucket, set the tail to node too.
  if(!this.tail){
    this.tail = node
  }
}

LRUCache.prototype.set = function(key,value){
  var node = new this.node(key,value)
  // update the value for exist entries
  if(this.map.hasOwnProperty(key)){
    this.map[key].val = value
    this.updateKey(key)
    return
  }
  if(this.length >= this.capacity){
    // remove the least recently used item
    var dKey = this.tail.key
    this.tail = this.tail.newer
    if(this.tail){
      this.tail.older = null
    }
    delete this.map[dKey]
    this.length --
  }

  // insert node into the head
  node.older = this.head
  // if have head, we need re-connect node with other nodes older than head
  if(this.head){
    this.head.newer = node
  }
  this.head = node
  // if no tail which means first insert, set the tail to node too
  if(!this.tail){
    this.tail = node
  }
  this.map[key] = node
  this.length ++
}
{% endhighlight %}

Now we can achieve set, get both with O(1).


## Summary

Here is some other implementations from others, if you are interested in it, check it yourself.

- [LRU by Chrisr NG](http://chrisrng.svbtle.com/lru-cache-in-javascript)
- [LRU by rsms](https://github.com/rsms/js-lru/blob/master/lru.js)
