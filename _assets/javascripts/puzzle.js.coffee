class @Puzzles
  constructor: (flag) ->
    # compatibility for localStorage, will show error meesage for creating if false
    @compatibility = @compatibility_check()
    # puzzles from gist, will save to localStorage in order to reduce the requests
    @apidata = {}
    # url of gist which i save all puzzles into
    @gisturl = ''
    # all datas we have including the apidata we got from last update and data changed by users.
    @localdata = {}
    # the time of last update, will save into localStorage
    @api_last_update = new Date()
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
    Merge two data set into one, if there is an update on apidata, otherwise we use the localdata only
    ###

    return "Not a validate Object" if typeof(@apidata) != "object" or typeof(@localdata) != "object"
    # Based on localdata and updatit if api changed.
    if not localStorage.getItem("api_last_update") or (Date.parse(localStorage.getItem("api_last_update")) > Date.parse(@api_last_update))
      for i of @apidata
        if @localdata.hasOwnProperty(i)
          for j of @apidata[i]
            if not @localdata[i].hasOwnProperty(j)
              @localdata[i][j] = @api[i][j]
        else
          @localdata[i] = @apidata[i]
      localStorage.setItem "api_last_update",new Date()
      @saveLocaldata()
    @statistical()

  statistical:() ->

    ###
    Statistical things about the puzzles
    ###
    @statistic['number_of_blocks'] = Object.keys(@localdata).length
    @statistic['number_of_puzzles'] = 0
    @statistic['number_of_check_puzzles'] = 0
    @statistic['number_of_ongoing_puzzles'] = 0
    @statistic['distribution'] = {}
    renderHTML = ''
    for i of @localdata
      if not @statistic['distribution'][i]
        @statistic['distribution'][i] = {}
        @statistic['distribution'][i].ongoing = 0
        @statistic['distribution'][i].check = 0
      dateStringL = new Date(i+" 00:00:00").toString().split(" ")
      renderHTML += "<div class='timeline-wrapper' id='#{i.replace(/-/g,'')}' data-date='#{i}'><h2 class='timeline-time date-title'><span class='puzzles-title'>#{dateStringL.slice(0,2).join(",")} #{dateStringL.slice(2,4).join(",")}</span><span class='count'>#{Object.keys(@localdata[i]).length} puzzles</span></h2>"
      for j of @localdata[i]
        @statistic['number_of_puzzles'] += 1
        if @localdata[i][j].status == 'check'
          @statistic['number_of_check_puzzles'] += 1
          @statistic['distribution'][i].check += 1
        if @localdata[i][j].status == 'ongoing'
          @statistic['number_of_ongoing_puzzles'] += 1
          @statistic['distribution'][i].ongoing += 1
        answer = @localdata[i][j].answer
        if not @localdata[i][j].answer
          answer = "Type here to write your answers. If the answer is too long, please use a link."
        renderHTML += "<dl class='timeline-series #{@localdata[i][j].status}' data-time='#{j}'><dt id=#{i.replace(/-|:/g,'')}#{j.replace(/-|:/g,'')} class='timeline-event'><a class='closed puzzle_title'>#{@localdata[i][j].title}</a><span><i class='fa fa-check fa-2x'></i></span></dt><dd class='timeline-event-content puzzle_detail' id='#{i.replace(/-|:/g,'')}#{j.replace(/-|:/g,'')}EX'><p class='puzzle-desc'>#{@localdata[i][j].desc}</p><p contentEditable='true' class='editanswer' placeholder='Type here to write your answers. If the answer is too long, please use a link.'>#{answer}</p></dd></dl>"
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
        data = JSON.parse(res.files['puzzles.json'].content)
        _this.api_last_update = data.lastupdate
        _this.apidata = data.puzzles
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
    date_title = "#{date.getFullYear()}-#{date.getMonth()+1}-#{date.getDate()}"
    time_title = "#{date.getHours()}:#{date.getMinutes()}:#{date.getSeconds()}"
    # save into localdata
    @localdata[date_title] = {} if not @localdata[date_title]
    @localdata[date_title][time_title] = puzzle
    @saveLocaldata()
    @renderSinglePuzzle(date_title,@localdata[date_title])

  saveLocaldata:() ->

    ###
    Save localdata into localStorage
    ###

    localStorage.setItem "local_puzzles",JSON.stringify(@localdata)
    # set the flag to record last update time

  pushToGist: () ->

    ###
    Push all puzzles to Gist and create an anonymous gist.
    Save the final link into @gisturl
    ###
    date = new Date()
    date_title = "#{date.getFullYear()}-#{date.getMonth()+1}-#{date.getDate()}"
    time_title = "#{date.getHours()}:#{date.getMinutes()}:#{date.getSeconds()}"

    postdata = {
      "description": 'a gist created for recording all puzzles from TaoAlpha blog'
      'public': true
      'files': {
        'puzzles.json': {
          'content': "{'lastupdate':'#{date_title} #{time_title}','puzzles':#{JSON.stringify(@localdata)}}"
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

  savePuzzleAnswer:(date_title,time_title,answer) ->

    ###
    Save the answer into localdata
    ###

    @localdata[date_title][time_title].answer = answer
    @saveLocaldata()

  updatePuzzleStatus:(date_title,time_title,status) ->

    ###
    Update the status of puzzle into alladata
    ###
    @localdata[date_title][time_title].status = status
    if status == "check"
      @statistic['distribution'][date_title].check += 1
      @statistic['distribution'][date_title].ongoing -= 1
    else
      @statistic['distribution'][date_title].check -= 1
      @statistic['distribution'][date_title].ongoing += 1
    @updateStatus()
    @saveLocaldata()

  renderSinglePuzzle:(date_title,puzzle) ->

    ###
    Render single puzzle into the page.
    ###

    renderHTML = "<dl class='timeline-series #{puzzle.status}' data-time='#{time_title}'><dt id=#{date_title.replace(/-|:/g,'')}#{time_title.replace(/-|:/g,'')} class='timeline-event'><a class='closed puzzle_title'></a><span><i class='fa fa-check fa-2x'></i></span></dt><dd class='timeline-event-content puzzle_detail' id='#{date_title.replace(/-|:/g,'')}#{time_title.replace(/-|:/g,'')}EX'><p class='puzzle-desc'>#{puzzle.description}</p><p contentEditable='true' class='editanswer' placeholder='Type here to write your answers. If the answer is too long, please use a link.'>Type here to write your answers. If the answer is too long, please use a link.</p></dd></dl>"

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
