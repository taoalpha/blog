class @Puzzles
  constructor: (flag) ->
    # compatibility for localStorage, will show error meesage for creating if false
    @compatibility = @compatibility_check()
    # puzzles from gist, will save to localStorage in order to reduce the requests
    @apidata = {}
    # url of gist which i save all puzzles into
    @gisturl = ''
    # data added by user from browser and saved into localStorage
    @localdata = {}
    # combine apidata and localdata, won't save into localStorage
    @alldata = {}
    # the time of last update, will save into localStorage
    @updateTime = new Date()
    # statistics about the puzzles
    @statistic = {}

    # initilize
    if flag == "all"
      @getFromlocalStorage()
      @getFromAPI()

  compatibility_check:() ->

    ###
    Check the compatibility of browser!
    ###
    try
      return 'localStorage' of window && window['localStorage'] != null
    catch
      return false

  notif:(msg) ->
    _alert(msg)

  merge:() ->

    ###
    Merge two data set into one, no overwrite on apidata set
    ###

    return "Not a validate Object" if typeof(@apidata) != "object" or typeof(@localdata) != "object"
    @alldata[i] = @apidata[i] for i of @apidata
    for i of @localdata
      if @alldata.hasOwnProperty(i)
        for j of @localdata[i]
          if not @alldata[i].hasOwnProperty(j)
            @alldata[i][j] = @localdata[i][j]
      else
        @alldata[i] = @localdata[i]
    @statistical()

  statistical:() ->

    ###
    Statistical things about the puzzles
    ###
    @statistic['number_of_blocks'] = Object.keys(@alldata).length
    @statistic['number_of_puzzles'] = 0
    @statistic['number_of_check_puzzles'] = 0
    @statistic['number_of_ongoing_puzzles'] = 0
    @statistic['distribution'] = {}
    renderHTML = ''
    for i of @alldata
      if not @statistic['distribution'][i]
        @statistic['distribution'][i] = {}
        @statistic['distribution'][i].ongoing = 0
        @statistic['distribution'][i].check = 0
      dateStringL = new Date(i).toString().split(" ")
      renderHTML += "<div class='timeline-wrapper' id='#{i.replace(/-/g,'')}'><h2 class='timeline-time date-title'><span class='puzzles-title'>#{dateStringL.slice(0,2).join(",")} #{dateStringL.slice(2,4).join(",")}</span><span class='count'>#{Object.keys(@alldata[i]).length} puzzles</span></h2>"
      for j of @alldata[i]
        @statistic['number_of_puzzles'] += 1
        if @alldata[i][j].status == 'check'
          @statistic['number_of_check_puzzles'] += 1
          @statistic['distribution'][i].check += 1
        if @alldata[i][j].status == 'ongoing'
          @statistic['number_of_ongoing_puzzles'] += 1
          @statistic['distribution'][i].ongoing += 1
        answer = @alldata[i][j].answer
        if not @alldata[i][j].answer
          answer = "Type here to write your answers. If the answer is too long, please use a link."
        renderHTML += "<dl class='timeline-series #{@alldata[i][j].status}'><dt id=#{i.replace(/-|:/g,'')}#{j.replace(/-|:/g,'')} class='timeline-event'><a class='closed puzzle_title'>#{@alldata[i][j].title}</a><span><i class='fa fa-check fa-2x'></i></span></dt><dd class='timeline-event-content puzzle_detail' id='#{i.replace(/-|:/g,'')}#{j.replace(/-|:/g,'')}EX'><p class='puzzle-desc'>#{@alldata[i][j].desc}</p><p contentEditable='true' class='editanswer'>#{answer}</p></dd></dl>"
      renderHTML += "</div><br class='clear'>"
    @renderPuzzles(renderHTML)

  sort:() ->

    return

  getFromAPI:() ->

    ###
    Get the puzzles stored in github as a gist.
    ###
    _this = @
    $.ajax {
      url:"https://api.github.com/gists/a0f243d7b54e77bca43d"
      dataTyle:"jsonp"
      success:(res)->
        _this.apidata = JSON.parse(res.files['puzzles.json'].content)
        _this.merge()
    }

  getFromlocalStorage:() ->

    ###
    Get all puzzles stored in the browser.
    ###

    if not @compatibility
      @notif("Sorry, your browser doesn't support localStorage which we use to save datas locally ! Please update or change a new browser! ")
      #@localdata = {}
      return

    @localdata = JSON.parse(localStorage["local_puzzles"]) if localStorage["local_puzzles"]?

  createPuzzle:(puzzle) ->

    ###
    Create a new puzzle and save it into localStorage
    ###

    if not @compatibility
      @notif("Sorry, your browser doesn't support localStorage which we use to save datas locally ! Please update or change a new browser! ")
      return

    date = new Date()
    date_title = "#{date.getFullYear()}/#{date.getMonth()+1}/#{date.getDate()}"
    time_title = "#{date.getHours()}:#{date.getMinutes()}:#{date.getSeconds()}"
    # save into localdata
    @localdata[date_title] = {} if not @localdata[date_title]
    @localdata[date_title][time_title] = puzzle
    @saveLocaldata()
    # save into alldata too.
    @alldata[date_title] = {} if not @alldata[date_title]
    @alldata[date_title][time_title] = puzzle
    @renderSinglePuzzle(date_title,@localdata[date_title])

  saveLocaldata:() ->

    ###
    Save datas into localStorage
    ###

    localStorage.setItem "local_puzzles",JSON.stringify(@localdata)

  pushToGist: () ->

    ###
    Push all puzzles to Gist and create an anonymous gist.
    Save the final link into @gisturl
    ###
    postdata = {
      "description": 'a gist created for recording all puzzles from TaoAlpha blog'
      'public': true
      'files': {
        'puzzles.json': {
          'content': "#{JSON.stringify(@alldata)}"
        }
      }
    }
    _this = @
    $.ajax {
      url:"https://api.github.com/gists"
      type:"POST"
      data:JSON.stringify(postdata)
      dataType:"json"
      success:(res) ->
        _this.gisturl = res.html_url
    }

  renderSinglePuzzle:(date_title,puzzle) ->

    ###
    Render single puzzle into the page.
    ###

    renderHTML = "<dl class='timeline-series #{puzzle.status}'><dt id=#{date_title.replace(/-|:/g,'')}#{time_title.replace(/-|:/g,'')} class='timeline-event'><a class='closed puzzle_title'></a><span><i class='fa fa-check fa-2x'></i></span></dt><dd class='timeline-event-content puzzle_detail' id='#{date_title.replace(/-|:/g,'')}#{time_title.replace(/-|:/g,'')}EX'><p class='puzzle-desc'>#{puzzle.description}</p><p contentEditable='true' class='editanswer'>Type here to write your answers. If the answer is too long, please use a link.</p></dd></dl>"

    $('#'+date_title).append(renderHTML)


  renderPuzzles:(renderHTML) ->

    ###
    Render all puzzles into the page
    ###

    $('#timeline').empty().append(renderHTML)
    @updateStatus()

  updateStatus:() ->

    ###
    Update the statistic data on page, eg: number of check puzzles, number of ongoing puzzles and whether a puzzle-block is check or ongoing
    ###
    distribution = @statistic['distribution']
    $('div.namespace').find('span.check i').text(@statistic['number_of_check_puzzles']).end().find('span.ongoing i').text(@statistic['number_of_ongoing_puzzles'])
    for i of distribution
      if distribution[i].check > 0 and distribution[i].ongoing == 0
        $('#'+i.replace(/-|:/g,'')).addClass("check")
      else
        $('#'+i.replace(/-|:/g,'')).addClass("ongoing")
