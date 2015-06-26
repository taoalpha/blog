Array.prototype.getObjectUnique = function(id){
  var a = [],b=[];
  for(var i = 0, l = this.length; i < l; ++i){
     if(b.indexOf(this[i][id])>-1) {
        continue;
     }
     a.push(this[i]);
     b.push(this[i][id]);
  }
  return a;
}

// 重写alert的代码:
window._alert = window.alert;
window.alert = function (msg, showItNow) {    
  if (showItNow) {
    window._alert(msg);
  }
};

jQuery.fn.rotate = function(degrees) {
  $(this).css({'-webkit-transform' : 'rotate('+ degrees +'deg)',
               '-moz-transform' : 'rotate('+ degrees +'deg)',
               '-ms-transform' : 'rotate('+ degrees +'deg)',
               'transform' : 'rotate('+ degrees +'deg)'});
  return $(this);
};

// Get Location of User
function getLocation() {
  var weatherData = $.cookie("weatherData");
  var cLocation = $.cookie("cLocation");
  var path_prefix = location.pathname.split("/")[2];
  var weatherImgUrl = $.cookie(path_prefix+"weatherImgUrl");
  if(!weatherImgUrl){
      randomImage(path_prefix)
  }else{
      $(".aside").css("background-image","url("+weatherImgUrl+")");
  }
  if(weatherData){
      updateWeather(JSON.parse(weatherData),"cookie");
      return
  }else if(cLocation){
      updateWeather(cLocation,"cityname");
      return
  }
  if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(updateWeather,showError);
  } else { 
      alert("Geolocation is not supported by this browser.");
  }
}

// Support customize location
function customLocation(){
  $('.location').find("span").text("");
  $('input#cLocation').show().focus();
}

// Update the location
function updateLocation(){
  var cLocation = $('input#cLocation').val();
  $.cookie("cLocation",cLocation,{path:"/",expires:7});
  updateWeather(cLocation,"cityname");
}

// Update the weather information
function updateWeather(position,flag){
  var weatherUrl = "";
  if(flag == "cityname") {
      weatherUrl = "http://api.openweathermap.org/data/2.5/weather?q="+position+"&lang=zh_cn&units=metric";
  }else if (flag == "cookie"){
      updateWeatherPart(position);
      return
  }else{
      weatherUrl = "http://api.openweathermap.org/data/2.5/weather?lat="+position.coords.latitude+"&lon="+position.coords.longitude+"&lang=zh_cn&units=metric";
  }
  $.ajax({
    url: weatherUrl, 
    dataType: 'jsonp',
    timeout: 1000 * 3, // 3 sec
    success: function(data) {
      $.cookie("weatherData",JSON.stringify(data),{expires:0.05,path:'/'});
      updateWeatherPart(data);
    },
    error: function() {
      // if fail then retry
      updateWeather(position,flag);
    }
  })
}


// Update the weather part in the page
function updateWeatherPart(data){
  var dt = data["dt"]*1000;
  var day = new Date(dt).getDate()
  var month = new Date(dt).getMonth()
  var Dcharacters = ["","一","二","三","四","五","六","七","八","九","十"]
  var Mcharacters = ["","十","二十","三十"]
  var ZdataM = Mcharacters[Math.floor(month/10)]+Dcharacters[month % 10+1]
  var ZdataD = Mcharacters[Math.floor(day/10)]+Dcharacters[day % 10]
  var Edata = new Date(dt).toDateString()

  $('.location span').text(data.name);
  $('input#cLocation').hide();
  $('h2.weather-cn').html(ZdataM+"月"+ZdataD+"日: <span>"+data["weather"][0]["description"]+"</span>");
  $('h3.weather-en').html(Edata+": <span>"+data["weather"][0]["main"]+"</span>");
}

// Show the error code
function showError(error) {
  switch(error.code) {
      case error.PERMISSION_DENIED:
          console.log("You denied the request for Geolocation.");
          updateWeather("beijing","cityname")
          break;
      case error.POSITION_UNAVAILABLE:
          console.log("Location information is unavailable.");
          updateWeather("beijing","cityname")
          break;
      case error.TIMEOUT:
          console.log("The request to get user location timed out.");
          updateWeather("beijing","cityname")
          break;
      case error.UNKNOWN_ERROR:
          console.log("An unknown error occurred.");
          updateWeather("beijing","cityname")
          break;
  }
}
// add limitation for tags and picked 8 or 10 tags randomly everytime

function randomTags(flag){
  var originArray = $('ul.tags').find('a.tag')
  if(flag=="showall"){originArray.show();return}
  originArray.eq(0).show();
  for (i=0;i<10;i++){
      var index = Math.floor(Math.random()*originArray.length)+1
      originArray.eq(index).show();
  }
}

// Create random image for image frame.
function randomImage(path){
  var topwallppr = "https://api.desktoppr.co/1/wallpapers/random";
  var dailywallppr = "http://www.dailywallppr.com/img/"+ Math.floor(Math.random()*2320+1)+".jpg"
  $.ajax({
    url: topwallppr, 
    dataType: 'jsonp',
    timeout: 1000 * 3, // 3 sec
    success: function(data) {
      $(".aside").css("background-image","url("+data.response.image.url+")");
      $.cookie(path+"weatherImgUrl",data.response.image.url,{expires:0.05,path:'/blog'})
    },
    error: function() {
      // if fail then retry
      randomImage(path);
    }
  })
}

// Load pageview counts from Google Analytics

function getPageViewCount(dataurl){
  if (dataurl === undefined) {
    dataurl = 'https://taoalpha-github-page.appspot.com/query?id=ahZzfnRhb2FscGhhLWdpdGh1Yi1wYWdlchULEghBcGlRdWVyeRiAgICAgICACgw'
  }
  $.ajax({
    url: dataurl, 
    dataType: 'jsonp',
    timeout: 1000 * 3, // 3 sec
    success: function(data) {
      parsePageViewData(data.rows);
    },
    error: function() {
      // if fail to get up-to-date data from GAE, get cached local version
      console.log('Failed to get pageview from GAE!');
        $.ajax({
          url: '/blog/pageview.json',
          dataType: 'json',
          success: function(data) {
            console.log('Local page view backup file.');
            parsePageViewData(data.rows);
          }
        })
      }
  })
}

function parsePageViewData(rows){
  if (rows === undefined) {
    return;
  }
  $('.post').each(function() {
    var myPath = $(this).children('h2').children('a').attr('href');
    if (myPath) {
      //myPath = myPath.slice('http://taoalpha.github.io'.length);
      //myPath = myPath;
      var len = rows.length;
      var cnt = 0;
      for (var i = 0; i < len; ++i) {
        var thatPath = rows[i][0];
        var queryId = thatPath.indexOf('?');
        var mainPath = queryId >= 0 ? thatPath.slice(0, queryId) : thatPath;
        if (thatPath === myPath || mainPath === myPath || mainPath === myPath + 'index.html' || myPath === mainPath + 'index.html') {
            cnt += parseInt(rows[i][1]);
        }
      }
      if (cnt){
        $(this).find('span.viewcount').html('<i class="fa fa-eye"></i>'+cnt);
      }
    }
  });
}

// load my wish books from douban
function showMyWishBooks(){
  var bookapi = "https://api.douban.com/v2/book/user/129154019/collections?status=wish&tag=MyWish";
  $.ajax({
    url: bookapi, 
    dataType: 'jsonp',
    timeout: 1000 * 3, // 3 sec
    success: function(data) {
      parseBookDatas(data.collections);
    },
    error: function() {
      // if fail to get up-to-date data from douban, get cached local version
      console.log('Failed to get pageview from Douban!');
        $.ajax({
          url: '/blog/doubanbooks.json',
          dataType: 'json',
          success: function(data) {
            console.log('Local mybooks.data backup file.');
            parseBookDatas(data.collections);
          }
        })
    }
  })
}

function parseBookDatas(data){
  var template = "<li class='book_item'><a href='__book_url__' alt='__book_alt_title__'><img src='__book_img__'><span>__book_title__</span></a></li>"
  $.each(data,function(key,item){
    var bookitem = template.replace("__book_url__",item.book.alt).replace("__book_alt_title__",item.book.alt_title).replace("__book_title__",item.book.title).replace("__book_img__",item.book.images.large);
    $('.books').append(bookitem);
  });
}

function search(query){
  var inverted_index = JSON.parse($('p#indexdata').text());
  var result = [];
  var dict = $('p#worddicts').text().split(",");
  var stop = ["the","of","is","and","to","in","that","we","for","an","are","by","be","as","on","with","can","if","from","which","you","it","this","then","at","have","all","not","one","has","or","that","的","了","和","是","就","都","而","及","與","著","或","一個","沒有","我們","你們","妳們","他們","她們","是否"];
  query = query.toLowerCase().replace(/[(^\s+)(\s+$)]/g,"");
  var splitwords = [];
  $.each(dict,function(k,v){
    if(query.indexOf(v)>-1){
      splitwords.push(v);
    }
  })
  if(splitwords.length){
    $.each(splitwords,function(k,v){
      result = result.concat(inverted_index[v]); 
    })
    showSearchResult(result.getObjectUnique('post_url'));
  }else{
    $('ul.article-list').empty().append('<li class="post"><h2>无结果, 请更换查询词</h2></li>');
  }
}

function showSearchResult(data){
  $('ul.article-list').empty();
  var template = '<li class="post"><h2><a href="__post_url__">__post_title__</a></h2><summary class="title-excerpt">__post_desc__</summary><div class="post-info"><span class="author"><i class="fa fa-user"></i><a href="__post_author_url__">__post_author__</a></span><span class="category"><i class="fa fa-briefcase"></i><a href="__post_category_url__">__post_category__</a></span><span class="postdate"><i class="fa fa-history"></i>__post_date__</span><span class="viewcount"></span></div></li>';
  $.each(data,function(k,v){
    var child = template.replace("__post_url__","/blog"+v.post_url).replace("__post_title__",v.post_title).replace("__post_desc__",v.post_content+"...").replace("__post_author_url__","/blog/author/"+v.post_author).replace("__post_author__",v.post_author).replace("__post_category_url__",v.post_category == "blog"? "/blog":"/blog/"+v.post_category).replace("__post_category__",v.post_category).replace("__post_date__",v.post_date.replace('00:00:00 +0800',''));
    $('ul.article-list').prepend(child);
  })
}

// function for sending emails
function sendMail(msg){
$.ajax({
  type: 'POST',
  url: 'https://mandrillapp.com/api/1.0/messages/send.json',
  data: {
    'key': 'JMwEKDDW1NuLbxUrK4ELhQ',
    'message': {
      'from_email': msg.sender_mail,
      'from_name' : msg.sender_name,
      'to': [
          {
            'email': 'zzgary92@gmail.com',
            'name': 'TaoAlpha',
            'type': 'to'
          }
        ],
      'autotext': 'true',
      'subject': msg.subject,
      'html': msg.content
    }
  }
  }).done(function(response) {
    showAlert("success","Thanks for your contribution!"); 
  }).fail(function(data){
    showAlert("fail","Sorry! Failed to send the email. Please retry!");
  });
}

function showAlert(status,msg,duration){
  if(!duration) duration = 5000;
  $('div.notification').stop().fadeIn().removeClass('fail success alert').addClass(status).html(msg).show().fadeOut(duration);
}
