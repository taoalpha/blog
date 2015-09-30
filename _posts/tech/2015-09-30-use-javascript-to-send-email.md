---
layout: post
title: Use only JavaScript to send email
category: tech
description: Want to send email in some static website? Now you can. Send an email using only JavaScript.
tags: [js,mandrill,email]
author: taoalpha
language: en
---

Want to send an email in your static website without any server languages support? Seems impossible. But now you can do that using only JavaScript. Wonderful? I will show you how to do that.

## Tools we need

- **Mandrill**: they provide the mail service that you can call using javascript;
- **website**: the website you want to do this;

## Preparation

First, you need sign up for [Mandrill](https://mandrillapp.com/) to enable the service and get an API key to use. It's easy, just follow the guide of the website and click the 'Get API Keys' when you enter your dashboard.

## Main Function

After you created your api key, you can just copy it and use the template list below to create the `sendMail` function:


{% highlight javascript %}
function sendMail(msg){
  $.ajax({
    type: "POST",
    url: "https://mandrillapp.com/api/1.0/messages/send.json",
    data: {
      'key': 'YOUR API KEY',
      'message': {
        'from_email': msg.sender_mail,
        'from_name': msg.sender_name,
        'to': [
            {
              'email': msg.receiver_mail,
              'name': msg.receiver_name,
              'type': 'to',
            }
        ],
        'autotext': 'true',
        'subject': msg.subject,
        'html': msg.content
      }
    }
   }).done(function(response) {
     // do what you want to do after the mail was sent
   }).fail(function(response){
     // do what you want to do if it fails to send the email
   });
}
{% endhighlight %}

The template above is using the jQuery as a external library. If you don't like jQuery(why?!!) or you are using something else, just remember to change the request to fit your library.

## DONE

Yeah. That's it. Now you can just create a json object to include all information you need and call the function to send the email!

Pretty easy, Ha.

## Cons

Since your api key will be exposed to everyone, anyone can just grab and use it to send their emails. And for free users, mandrill will provide 12k free emails every month and has a limitation as 150 per hour. So once you find someone is stealing your quota, disable your api key and change to a new one immediately.

Besides, if you are sure you are only using this service from several ip address. You can set them in the API Key settings. Then it would be much safer.
