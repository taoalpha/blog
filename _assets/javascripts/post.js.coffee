$ ->
  isMobile =
    Android: ->
        navigator.userAgent.match(/Android/i)
    BlackBerry: ->
        navigator.userAgent.match(/BlackBerry/i)
    iOS: ->
        navigator.userAgent.match(/iPhone|iPad|iPod/i)
    Opera: ->
        navigator.userAgent.match(/Opera Mini/i)
    Windows: ->
        navigator.userAgent.match(/IEMobile/i)
    any: ->
        (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows())

    # $('pre').addClass('prettyprint linenums')
    # 添加Google code Hight需要的class

  do ->
    ie6 = $.browser.msie && $.browser.version=="6.0" if $.browser?
    initHeading = ->
      h2 = []
      h3 = []
      h2index = 0
      $.each $('.entry h2, .entry h3'),(index,item) ->
        if item.tagName.toLowerCase() == 'h2'
          h2item = {}
          h2item.name = $(item).text()
          h2item.id = 'menuIndex'+index
          h2.push(h2item)
          h2index++
        else
          h3item = {}
          h3item.name = $(item).text()
          h3item.id = 'menuIndex'+index
          if !h3[h2index-1]
            h3[h2index-1] = []
          h3[h2index-1].push(h3item)
        item.id = 'menuIndex' + index
      {h2:h2,h3:h3}

    genTmpl = ->
      h1txt = $('h1').text()
      tmpl = "<ul><li class='h1'><a href='#'>#{h1txt}</a></li>"
      heading = initHeading()
      h2 = heading.h2
      h3 = heading.h3

      for i in [0..h2.length-1]
        tmpl += "<li><a href='#' data-id=#{h2[i].id}>#{h2[i].name}</a></li>"
        if h3[i]?
          for j in [0..h3.length-1]
            tmpl += "<li class='h3'><a href='#' data-id=#{h3[i][j].id}>#{h3[i][j].name}</a></li>"
      tmpl += '</ul>'

    genIndex = ->
      tmpl = genTmpl()
      indexCon = '<div id="menuIndex" class="sidenav"></div>'
      $(indexCon).insertBefore(".comments")
      $('#menuIndex')
        .append($(tmpl))
        .delegate 'a','click',(e)->
          e.preventDefault()
          selector = if $(this).attr('data-id') then "##{$(this).attr('data-id')}" else 'h1'
          scrollNum = $(selector).offset().top
          $('body, html').animate({ scrollTop: scrollNum-30 }, 400, 'swing')

    waitForFinalEvent = do ->
      timers = {}
      (callback, ms, uniqueId) ->
        uniqueId = "Don't call this twice without a uniqueId" if !uniqueId
        clearTimeout (timers[uniqueId]) if timers[uniqueId]
        timers[uniqueId] = setTimeout(callback, ms)

    if $('.entry h2').length > 1 && !isMobile.any() && !ie6
      genIndex()
      $(window).load ->
        scrollTop = []
        $.each $('#menuIndex li a'),(index,item) ->
          selector = if $(item).attr('data-id') then "##{$(item).attr('data-id')}" else 'h1'
          top = $(selector).offset().top
          scrollTop.push(top)
        menuIndexTop = $('#menuIndex').offset().top
        menuIndexLeft = $('#menuIndex').offset().left

        $(window).scroll ->
          waitForFinalEvent ->
            nowTop = $(window).scrollTop()
            length = scrollTop.length
            index = 0

            if nowTop+20 > menuIndexTop
              $('#menuIndex').css
                position:'fixed'
                top:'20px'
                left:menuIndexLeft
            else
              $('#menuIndex').css
                  position:'static'
                  top:0
                  left:0
            if nowTop+60 > scrollTop[length-1]
              index = length
            else
              for i in [0..length-1]
                if nowTop+60 <= scrollTop[i]
                  index = i
                  break
            $('#menuIndex li').removeClass('on')
            $('#menuIndex li').eq(index-1).addClass('on')

        $(window).resize ->
          $('#menuIndex').css
            position:'static'
            top:0
            left:0
          menuIndexTop = $('#menuIndex').offset().top
          menuIndexLeft = $('#menuIndex').offset().left
          $(window).trigger('scroll')
          $('#menuIndex').css('max-height',$(window).height()-80)

    # 用js计算屏幕的高度
    $('#menuIndex').css('max-height',$(window).height()-80)

  # prettyPrint()
