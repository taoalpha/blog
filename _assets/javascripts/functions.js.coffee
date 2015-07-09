Array::getObjectUnique = (id) ->
  a=b=[];
  add = (data) -> b.push data[id];data
  (add i for i in @ when b.indexOf(i[id]) == -1 )

@._alert = @.alert
@.alert = (msg,showItNow) ->
  @._alert msg if showItNow

jQuery.fn.rotate = (degrees) ->
  rotatecss =
    "-webkit-transform": "rotate(#{degrees}deg)"
    "-moz-transform": "rotate(#{degrees}deg)"
    "-ms-transform": "rotate(#{degrees}deg)"
    "transform": "rotate(#{degrees}deg)"
  $(this).css rotatecss
  $(this)

# Get user's location

@getLocation = ->
  weatherData = $.cookie("weatherData");
  cLocation = $.cookie("cLocation");
  path_prefix = location.pathname.split("/")[2];
  weatherImgUrl = $.cookie(path_prefix+"weatherImgUrl");
  if !weatherImgUrl
    randomImage path_prefix
  else $(".aside").css 'background-image',"url(#{weatherImgUrl})"
  if weatherData
    updateWeather(JSON.parse(weatherData),"cookie");return
  else if cLocation
    updateWeather(cLocation,"cityname");return
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(updateWeather,showError)
  else _alert "Geolocation is not supported by this browser."

# Show Error
@showError = (e) ->
  switch e.code
    when e.PERMISSION_DENIED then console.log "You denied the request for Geolocation."; updateWeather "beijing","cityname"
    when e.POSITION_UNAVAILABLE then console.log "Location information is unavailable."; updateWeather "beijing","cityname"
    when e.TIMEOUT then console.log "The request to get user location timed out."; updateWeather "beijing","cityname"
    when e.UNKNOWN_ERROR then console.log "Unknow error"; updateWeather "beijing","cityname"

# Support customize location
@customLocation = ->
  $('.location').find("span").text("")
  $('input#cLocation').show().focus()

@updateLocation = ->
  cLocation = $('input#cLocation').val()
  $.cookie "cLocation",cLocation,{path:"/",expires:7}
  updateWeather cLocation,"cityname"
  1

# Update the Weather information
@updateWeather = (position, flag) ->
  weatherUrl = ''
  if flag is "cityname"
    weatherUrl = "http://api.openweathermap.org/data/2.5/weather?q=#{position}&lang=zh_cn&units=metric"
  else if flag is "cookie"
    updateWeatherPart position
    return
  else
    weatherUrl = "http://api.openweathermap.org/data/2.5/weather?lat=#{position.coords.latitude}&lon=#{position.coords.longitude}&lang=zh_cn&units=metric"
  $.ajax
    url: weatherUrl
    dataType: 'jsonp'
    timeout: 1000 * 3
    success: (data) ->
      $.cookie("weatherData",JSON.stringify(data),{expires:0.05,path:'/'})
      updateWeatherPart(data)
      1
    error: ->
      # retry if fail
      updateWeather(position,flag)
      0
  1

# update weather in the page
@updateWeatherPart = (data) ->
  dt = data["dt"]*1000
  day = new Date(dt).getDate()
  month = new Date(dt).getMonth()
  Dcharacters = ["","一","二","三","四","五","六","七","八","九","十"]
  Mcharacters = ["","十","二十","三十"]
  ZdataM = Mcharacters[Math.floor(month/10)]+Dcharacters[month % 10+1]
  ZdataD = Mcharacters[Math.floor(day/10)]+Dcharacters[day % 10]
  Edata = new Date(dt).toDateString()

  $('.location span').text(data.name);
  $('input#cLocation').hide();
  $('h2.weather-cn').html "#{ZdataM}月#{ZdataD}日:<span>#{data['weather'][0]["description"]}</span>"
  $('h3.weather-en').html "#{Edata}: <span>#{data['weather'][0]["main"]}</span>"
  1

# Add limitation for tags and pick 8-10 tags randomly everytime

@randomTags = (flag) ->
  originArray = $('ul.tags').find 'a.tag'
  originArray.show() if flag is 'showall'
  originArray.eq(0).show()
  originArray.eq(Math.floor(Math.random()*originArray.length)+1).show() for i in [0..10]
  1

# Create random image for image frame.
@randomImage = (path) ->
  topwallppr = "https://api.desktoppr.co/1/wallpapers/random"
  dailywallppr = "http://www.dailywallppr.com/img/#{Math.floor(Math.random()*2320+1)}.jpg"
  $.ajax
    url: topwallppr
    dataType: 'jsonp'
    timeout: 1000 * 3
    success: (data) ->
      $(".aside").css("background-image","url(#{data.response.image.url})");
      $.cookie(path+"weatherImgUrl",data.response.image.url,{expires:0.05,path:'/blog'})
      1
    error: ->
      # retry if fail
      randomImage(path)
      0
  1

# Load pageview counts from Google Analytics

@getPageViewCount = (dataurl) ->
  if !dataurl
    dataurl = 'https://taoalpha-github-page.appspot.com/query?id=ahZzfnRhb2FscGhhLWdpdGh1Yi1wYWdlchULEghBcGlRdWVyeRiAgICAgICACgw'
  $.ajax
    url: dataurl
    dataType: 'jsonp'
    timeout: 1000 * 3
    success: (data) ->
      parsePageViewData(data.rows)
      1
    error: ->
      # if fail to get up-to-date data from GAE, get cached local version
      console.log('Failed to get pageview from GAE!')
      $.ajax
        url: '/blog/pageview.json'
        dataType: 'json'
        success: (data) ->
          console.log('Local page view backup file.')
          parsePageViewData(data.rows)
          1
      0
  1

@parsePageViewData = (rows) ->
  return if !rows
  $('.post').each ->
    myPath = $(this).children('h2').children('a').attr('href')
    if myPath
      #myPath = myPath.slice('http://taoalpha.github.io'.length);
      #myPath = myPath;
      len = rows.length;
      cnt = 0;
      for i in [0..len-1]
        thatPath = rows[i][0]
        queryId = thatPath.indexOf('?')
        mainPath = if queryId >= 0 then thatPath.slice(0, queryId) else thatPath
        cnt += parseInt(rows[i][1]) if thatPath == myPath or mainPath == myPath or mainPath == myPath + 'index.html' or myPath == mainPath + 'index.html'
      $(this).find('span.viewcount').html("<i class='fa fa-eye'></i>#{cnt}") if cnt
  1

# load my wish books from douban
@showMyWishBooks = ->
  bookapi = "https://api.douban.com/v2/book/user/129154019/collections?status=wish&tag=MyWish"
  $.ajax
    url: bookapi
    dataType: 'jsonp'
    timeout: 1000 * 3
    success: (data) ->
      parseBookDatas data.collections
      1
    error: ->
      # if fail to get up-to-date data from douban, get cached local version
      console.log('Failed to get pageview from Douban!')
      $.ajax
        url: '/blog/doubanbooks.json'
        dataType: 'json'
        success: (data) ->
          console.log('Local mybooks.data backup file.')
          parseBookDatas(data.collections)
          1
      0
  1

@parseBookDatas = (data) ->
  template = "<li class='book_item'><a href='__book_url__' alt='__book_alt_title__'><img src='__book_img__'><span>__book_title__</span></a></li>"
  $.each data,(key,item)->
    bookitem = template.replace("__book_url__",item.book.alt).replace("__book_alt_title__",item.book.alt_title).replace("__book_title__",item.book.title).replace("__book_img__",item.book.images.large)
    $('.books').append(bookitem);
  1

@search = (query) ->
  inverted_index = JSON.parse($('p#indexdata').text())
  result = []
  dict = $('p#worddicts').text().split(",")
  stop = ["the","of","is","and","to","in","that","we","for","an","are","by","be","as","on","with","can","if","from","which","you","it","this","then","at","have","all","not","one","has","or","that","的","了","和","是","就","都","而","及","與","著","或","一個","沒有","我們","你們","妳們","他們","她們","是否"]
  query = query.toLowerCase().replace(/[(^\s+)(\s+$)]/g,"")
  splitwords = []
  $.each dict,(k,v)->
    splitwords.push(v) if query.indexOf(v)>-1
  if splitwords.length
    $.each splitwords,(k,v) ->
      result = result.concat(inverted_index[v])
    showSearchResult result.getObjectUnique('post_url')
  else
    $('ul.article-list').empty().append('<li class="post"><h2>无结果, 请更换查询词</h2></li>')
  1

@showSearchResult = (data) ->
  $('ul.article-list').empty();
  template = '<li class="post"><h2><a href="__post_url__">__post_title__</a></h2><summary class="title-excerpt">__post_desc__</summary><div class="post-info"><span class="author"><i class="fa fa-user"></i><a href="__post_author_url__">__post_author__</a></span><span class="category"><i class="fa fa-briefcase"></i><a href="__post_category_url__">__post_category__</a></span><span class="postdate"><i class="fa fa-history"></i>__post_date__</span><span class="viewcount"></span></div></li>';
  $.each data,(k,v)->
    child = template.replace("__post_url__","/blog#{v.post_url}").replace("__post_title__",v.post_title).replace("__post_desc__","#{v.post_content}...").replace("__post_author_url__","/blog/author/#{v.post_author}").replace("__post_author__",v.post_author).replace("__post_category_url__",if v.post_category == "blog" then "/blog" else "/blog/#{v.post_category}").replace("__post_category__",v.post_category).replace("__post_date__",v.post_date.replace('00:00:00 +0800',''))
    $('ul.article-list').prepend(child)
  1

# function for sending emails
@sendMail = (msg)->
  $.ajax
    type: 'POST'
    url: 'https://mandrillapp.com/api/1.0/messages/send.json'
    data:
      'key': 'JMwEKDDW1NuLbxUrK4ELhQ'
      'message':
        'from_email': msg.sender_mail
        'from_name' : msg.sender_name
        'to': [
            {
              'email': 'zzgary92@gmail.com'
              'name': 'TaoAlpha'
              'type': 'to'
            }
          ]
        'autotext': 'true'
        'subject': msg.subject
        'html': msg.content
  .done (response)->
    showAlert("success","Thanks for your contribution!")
    1
  .fail (data)->
    showAlert("fail","Sorry! Failed to send the email. Please retry!")
    0
  1

# galog

@getGALogFile = (dataurl) ->
  if !dataurl
    dataurl = 'https://taoalpha-github-page.appspot.com/query?id=ahZzfnRhb2FscGhhLWdpdGh1Yi1wYWdlchULEghBcGlRdWVyeRiAgICAq_OHCgw&format=json'
  $.ajax
    url: dataurl
    dataType: 'jsonp'
    timeout: 1000 * 3
    success: (data) ->
      parseGALog(data)
      1
    error: ->
      # if fail to get up-to-date data from GAE, get cached local version
      console.log('Failed to get GA Log File from GAE!')
      $.ajax
        url: '/blog/accesslog.json'
        dataType: 'json'
        success: (data) ->
          console.log('Local page view backup file.')
          parseGALog(data)
          1
      0
  1

@parseGALog = (data) ->
  overalldata = {}
  overalldata.tpv = data["totalsForAllResults"]["ga:pageviews"]
  overalldata.tuv = data["totalsForAllResults"]["ga:uniquePageviews"]
  overalldata.datasize = parseFloat(JSON.stringify(data).length/8/1024).toFixed(2)
  overalldata.referer = []
  overalldata['404'] = 0

  requestdata = {}
  refererdata = {}
  osdata = {}
  browserdata = {}
  countrydata = {}

  temp_data = data.rows
  $.each temp_data,(k,v) ->
    overalldata.referer.push(v[0]) if v[0] not in overalldata.referer
    overalldata['404'] += parseInt(v[7]) if v[5] == "/blog/404"

    if !requestdata[v[5]]
      requestdata[v[5]] = {}
      requestdata[v[5]]["pv"] = parseInt(v[7])
      requestdata[v[5]]["uv"] = parseInt v[8]
    else
      requestdata[v[5]]["pv"] += parseInt v[7]
      requestdata[v[5]]["uv"] += parseInt v[8]

    if !countrydata[v[3]]
      countrydata[v[3]] = {}
      countrydata[v[3]]["pv"] = parseInt v[7]
      countrydata[v[3]]["uv"] = parseInt v[8]
    else
      countrydata[v[3]]["pv"] += parseInt v[7]
      countrydata[v[3]]["uv"] += parseInt v[8]

    if !refererdata[v[0]]
      refererdata[v[0]] = {}
      refererdata[v[0]]["pv"] = parseInt v[7]
      refererdata[v[0]]["uv"] = parseInt v[8]
    else
      refererdata[v[0]]["pv"] += parseInt v[7]
      refererdata[v[0]]["uv"] += parseInt v[8]

    if !osdata[v[2]]
      osdata[v[2]] = {}
      osdata[v[2]]["pv"] = parseInt v[7]
      osdata[v[2]]["uv"] = parseInt v[8]
    else
      osdata[v[2]]["pv"] += parseInt v[7]
      osdata[v[2]]["uv"] += parseInt v[8]

    if !browserdata[v[1]]
      browserdata[v[1]] = {}
      browserdata[v[1]]["pv"] = parseInt v[7]
      browserdata[v[1]]["uv"] = parseInt v[8]
    else
      browserdata[v[1]]["pv"] += parseInt v[7]
      browserdata[v[1]]["uv"] += parseInt v[8]

  # render overall part
  $('li.overall').find('summary').html "<ul><li><span class='itemname'><i class='fa fa-bar-chart'></i>total pageviews</span> <span class='count'>#{overalldata.tpv}</span></li><li><span class='itemname'><i class='fa fa-bar-chart'></i>total unique visitors</span> <span class='count'>#{overalldata.tuv}</span></li><li><span class='itemname'><i class='fa fa-bar-chart'></i>referrers</span> <span class='count'>#{overalldata.referer.length}</span></li><li><span class='itemname'><i class='fa fa-bar-chart'></i>total 404</span> <span class='count'>#{overalldata['404']}</span></li><li><span class='itemname'><i class='fa fa-bar-chart'></i>log size</span> <span class='count'>#{overalldata.datasize}kb</span></li><li><span class='itemname'><i class='fa fa-bar-chart'></i>log source</span> <span class='count'>ga</span></li></ul>"

  showLogData(requestdata,parseInt(overalldata.tpv),parseInt(overalldata.tuv),'Path')
  showLogData(refererdata,parseInt(overalldata.tpv),parseInt(overalldata.tuv),'Referer')
  showLogData(osdata,parseInt(overalldata.tpv),parseInt(overalldata.tuv),'OS')
  showLogData(browserdata,parseInt(overalldata.tpv),parseInt(overalldata.tuv),'Browser')
  showLogData(countrydata,parseInt(overalldata.tpv),parseInt(overalldata.tuv),'Country')

@showLogData = (rq,ptotal,utotal,id) ->
  script = "if($(this).hasClass('expanded')){$(this).removeClass('expanded').closest('thead').next('tbody').find('tr:nth-of-type(n+10)').hide();}else{$(this).addClass('expanded').closest('thead').next('tbody').find('tr').show()}"
  thead = "<tr><th>PageViews</th><th>%</th><th>Unique PageViews</th><th>%</th><th class=''>__title__<span onclick=#{script}><i class='fa fa-expand'></i></span></th></tr>"
  tbodyitem = "<tr class='root'><td class='num'>__value_1__</td><td>__value_2__</td><td class='num'>__value_3__</td><td>__value_4__</td><td>__value_5__</td></tr>"
  tbody = ''

  $.each rq, (k,v) ->
    tbody += tbodyitem.replace('__value_1__',v['pv']).replace('__value_2__',(v['pv']/ptotal*100).toFixed(2)).replace('__value_3__',v['uv']).replace('__value_4__',(v['uv']/utotal*100).toFixed(2)).replace('__value_5__',k)

  $('li.'+id).find('thead').html thead.replace('__title__',id)
  $('li.'+id).find('tbody').html tbody

@showAlert = (status,msg,duration) ->
  duration = 5000 if duration?
  $('div.notification').stop().fadeIn().removeClass('fail success alert').addClass(status).html(msg).show().fadeOut(duration)
