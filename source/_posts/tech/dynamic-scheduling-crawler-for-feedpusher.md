date: 2016-01-12 7:00:00
title: Dynamic scheduling crawler for FeedPusher
category: tech
description: how to crawl subscriptions more intelligiently
tags: [js]
author: taoalpha
---

As I promised, I have been working on refactoring the feedpusher with pure JS/nodeJS from last week. Now I have set up the basic database struture and spider which has already been running for one week with 80 sites and 8k feeds stored into my mongodb on raspberry pi.

Today, I jsut set up a new process to crawl the updates which I called dynamic scheduling which means now the spider can decide whether this site needs to be recrawled this time or not by itself. Why? Most important reason is that as the number of sites goes bigger, the time it crawles all sites is longer, and also crawl every site everytime is not a good way.

Now I will explain how I do that with nodeJS.

## Theory
Our purpose is let the spider decide when to crawl a specific website/rss link, or in another word, everytime the spider runs, it needs to decide which website should be recrawled this time.

### What data I have
Now I have and I can store some data into my database that may be good for this purpose, but we want to use as few as possible, so I decide to use these two attributes:

- lastCrawled: time I last crawled this website;
- updateDuration: the duration between two continuous crawl of this site;

### Dynamic Scheduling
The lastCrawled is pretty simple and we don’t have a lot things can do with it. But the updateDuration is the core of the dynamic scheduling, since we can increase it and tell the spider that this site needs a longer duration before next crawling and vice versa.

So the basic idea is:

**The larger the updateDuration is, the longer the website get recrawled.**

### Rules
- When to crawl: if current time minus the time lastCrawled is longer than the updateDuration, then the website needs to be recrawled;
- Motivate: if this round of crawling got any updates(new feeds) of this website, then we decrease the updateDuration of this website which is like motivating this website because of the updates;
- Penalize: if this round of crawling got no updates(new feeds) of this website, then we increase the updateDuration of this website which is like penalizing this website because of the later update than expected;

### Results
Based on these simple rules, the updateDuration of one site would be dynamic changing and will reflect the frequency of a website updates in some level.

## Coding
The coding part is pretty stright forward, but since the spider need get a lot of data from the mongodb, so you might need a lot promises to make sure the order of different processes is under your control.

I will put the Pseudocode here, if you are interested in the real code, you can check my feedpusher code refactoring repo :)

### Pseudocode
This is not a real pseudocode… but I believe you can bare with that :)

``` javascript
// feed is the object of my core class I used for this spider

feed.db.open((err, db) =>{
  // connect with database
  var allSites = [] // store all sites we crawled this time in order to update the lastCrawled and updateDuration later

  // find all sites from the database
  feed.findAllSites().then((data) => {
    var curTime = moment()
    // Need use promise to make sure all finished before you update the lastCrawled and updateDuration
    return Promise.all(data.filter( (v) => {
      // filter all sites that the time from lastCrawled has passed the updateDuration
      return (((curTime - moment(v.lastCrawled)) / 3600 / 1000) > v.updateDuration)
    })
    .map( (v) =>{
      // crawl and store each feedUrl which is the link of the rss
      allSites.push(v.feedUrl)
      return feed.crawler(v.feedUrl)
    }) )
  })
  .then( ()=>{
    // update the lastFCrawled for all sites
    return feed.updateCrawled(allSites)
  },(reason)=>{
    console.log("Broken at crawler")
    console.log(reason)
    db.close()
  })
  .then( ()=>{
    console.log(feed.stats)
    feed.updateDuration(allSites).then( () => {
      // Now update the updateDuration for all sites
      db.close()
    },(reason)=>{
      console.log("Broken at updatedDuration")
      console.log(reason)
      db.close()
    })
  },(reason)=>{
    console.log("Broken at updatedCrawled")
    console.log(reason)
    db.close()
  })
})
```
Yup! currently it works pretty good! :)
