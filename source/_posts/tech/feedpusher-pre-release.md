title: FeedPusher Pre-Alpha-Release
date: 2016-01-23 16:26:45-05:00
category: tech
tags: [FeedPusher, NodeJS]
---

As getting close the the end of the winter break, I'm almost ready to release the alpha version of new feedpusher :).

Here is some declaration before I release the first version :)

- Instead of a public service, the first one or maybe several versions would be invitation only since the the service host on my raspberry pi, can not handle too many requests;
- Also because I will host it on my raspberry pi until the beta version, so during the alpha, maybe the service will be kind of unstable but once I have some new and fancy functions, I will add to it... :) ;
- And I will release all source code including the spider, and maybe write a series posts about how to set up one for youself (actually I have done that, [here is the link to my feedpusher refactor branch](https://github.com/taoalpha/feedpusher/tree/refactor), all updates will synchronize to this branch);
- Normally I wouldn't record any personal information except for your standard user profile, but I will record the person who add the site first as a trace to track contributions :) ;
- If you really want to use it or test it, please [send me an email to ask for an invitation code](mailto:tao@taoalpha.me), otherwise, you can use `test@mail.com` and `test2016` to log in and have fun, remember tell me all your suggestions if you have :)

Here is the basic functions the first released version will cover:

- Common:
  - Sign in;
  - Add;
  - Delete;
  - Load more;
  - Read;
  - Mark as read(automatically);
  - Skip all read items;
  - Reload as requested;
- tablet or middle sized screen:
  - Read within the page;
  - Check the x-frame-option, show tips when there is some CORS limitation;
- Mobile or small screen:
  - Nothing special
- Chrome App:
  - Use webview;
- Chrome Extension:
  - Not this time;

Since you have read all these bullshit... :) Now you can try the demo with the test email and password I mentioned before.

[Here is the Demo](http://feedpusher.taoalpha.me/#/rss)

:) Thanks!
