title: Add SSL to your github pages with customized domain
date: 2016-02-11 12:45:06-05:00
category: tech
tags: [SSL, Github Pages, DNS]
---

Since Google announced that [HTTPS as a ranking signal](https://googlewebmastercentral.blogspot.com/2014/08/https-as-ranking-signal.html), all the webmasters including the people like me owns a personal website starts considering moving from HTTP to HTTPS.

There are plenty of ways to add SSL to your website, most of host service providers will provide the SSL for you, you just need to pay for it :). If you don't want to pay and also can access your server from SSH, you may try [Let's Encrypt](https://letsencrypt.org) which is a free and open certificate authority.

If you are using github pages, you should be fine already since github pages has already supported HTTPS since [2014/4 GitHub Pages Now (Sorta) Supports HTTPS, So Use It](https://konklone.com/post/github-pages-now-sorta-supports-https-so-use-it).

But if you are using customized domain, you need to do some leg work to make it support SSL, and free. :)

### SSL

What is SSL (Secure Sockets Layer) ? According to google: 

> SSL is the standard security technology for establishing an encrypted link between a web server and a browser. This link ensures that all data passed between the web server and browsers remain private and integral.

About how to encrypt the data, you can [check here to read more](https://en.wikipedia.org/wiki/RSA_(cryptosystem)).

### CloudFlare

[CloudFlare](https://www.cloudflare.com/) is like a service that help you improve the performance of your website, like dynamic dns, analytics ... and security like SSL. So it is the easiest way to move your website to HTTPS

### Moving to HTTPS

Here is a really good post about how to move the HTTP to HTTPS. [Set Up SSL on Github Pages With Custom Domains for Free](https://sheharyar.me/blog/free-ssl-for-github-pages-with-custom-domains/)

I just summarize some important steps as follow:

- Sign up in CloudFlare
- Add your site
- Confirm the records including the A and CNAME (you can add some new or delete some wrong ones)
- Get the new nameserver from cloudflare
- Replace the nameserver in your domain provider(where you buy the domain from)
- Sit and wait

### Default as HTTPS

If you want to redirect all your users to HTTPS version, you can achieve that with a little script:

``` javascript
var host = "yoursite.com";
if ((host == window.location.host) && (window.location.protocol != "https:")) {
  window.location.protocol = "https";
}
```

{% blockquote Updates %}

If you change to HTTPS, you can not load resources through http request, so remember to change your resources to https too.

If you have some api calls which don't have a https version, you have to figure out some ways to solve that. Here I have three solutions may be helpful:

- S1: Replace with another similar service
  if you can find some alternatives, you may just replace the old http service with new https alternative, you may need to change your code as well since the api may have some little difference.
- S2: Proxy
  if you host your website on a server which you have access to it, you may build your own proxy and replacing the old request with your proxy(like forwarding all http request to your proxy, and forwarding retrieved data back to your site).
- S3: Cookie trick
  if you are using a static website host like github pages, and your data is pretty small and doesn't change so frequently. You may can use cookie trick : everytime when someone loads the page, check the cookie, if already got, load your site through https, otherwise, load with http and retrieve the data and store in cookie. So if your users have the cookie, they will always in HTTPS protocol and the data would be renderred perfectly.

Currently, the weather information I show on my website is using openweathermap and I have only http version if I don't want to pay them :) So I use the cookie trick to store the information in cookie during your first visit(or the first visit after the cookie expired), every visit after that will be redirected to HTTPS automatically. :)

{% endblockquote %}
