rotation = 0
OpenInNewWindow = false
$ ->
  $('.follow').click (e) ->
    e.preventDefault()
    $(this).animate
      borderSpacing: -90
      {
      step: (now,fx) ->
        $(this).css('-webkit-transform',"rotate(#{now}deg)")
        $(this).css('-moz-transform',"rotate(#{now}deg)")
        $(this).css('transform',"rotate(#{now}deg)")
      duration:'fast'}
      'linear'

    $(this).toggleClass("active")

    if $('.home-contact').is(':visible')
      $('.home-contact').slideUp(100)
    else
      $('.home-contact').slideDown(100)

  $('#togglemusic').click (e) ->
    e.preventDefault()
    console.log("music")
    $(this).find('i').toggleClass("rotate")

    if $('#musicbar').is(':visible')
      $('#musicbar').find('iframe').attr('src','http://music.163.com/outchain/player?type=0&id=78822606&auto=0&height=32')
      OpenInNewWindow = false
      $('#musicbar').slideUp(300)
    else
      $('#musicbar').find('iframe').attr('src','http://music.163.com/outchain/player?type=0&id=78822606&auto=1&height=32')
      OpenInNewWindow = true
      $('#musicbar').slideDown(300)

  $('a').on 'click',(e) ->
    # if music is playing, open the link in new window except those links with functions binding with.
    return if $(this).attr('href') && $(this).attr('href').indexOf("javascript") == 0
    return if !OpenInNewWindow
    e.preventDefault()
    newlink = $(this).attr("href")
    window.open(newlink,"something") if newlink? and newlink != "javascript:;"

  # for the series part
  $('.series h2,.series .expand,.series .collapse').on 'click',(e) ->
    e.stopPropagation()
    $('.series ul').slideToggle(300)
    $('.series .expand').toggle()
    $('.series .collapse').toggle()

  $('i.reloadimage').on 'click',->
    path_prefix = location.pathname.split("/")[2]
    randomImage(path_prefix)

  $(".filter").on "click", ->
    $this = $(this)
    # if we click the active tab, do nothing
    if not $this.hasClass("active")
      $(".filter").removeClass("active")
      $this.addClass("active") # set the active tab
      # get the data-rel value from selected tab and set as filter
      $filter = $this.data("rel")
      # if we select view all, return to initial settings and show all
      if $filter.toLowerCase() == 'all'
        $(".post").not(":visible").fadeIn()
      else # otherwise
        $(".post").fadeOut(0).filter ->
          # set data-filter value as the data-rel value of selected tab
          return $(this).data("filter").split(" ").indexOf($filter)!=-1;
        # set data-fancybox-group and show filtered elements
        .fadeIn(1000)
