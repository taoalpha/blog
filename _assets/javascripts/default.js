var rotation = 0;
var OpenInNewWindow = false;
$(function(){
  $('.follow').click(function(e){
    e.preventDefault();
    $(this).animate({  borderSpacing: -90 }, {
      step: function(now,fx) {
        $(this).css('-webkit-transform','rotate('+now+'deg)'); 
        $(this).css('-moz-transform','rotate('+now+'deg)');
        $(this).css('transform','rotate('+now+'deg)');
      },
      duration:'fast'
    },'linear');

    $(this).toggleClass("active");

    if($('.home-contact').is(':visible')){
      $('.home-contact').slideUp(100);
    }else{
      $('.home-contact').slideDown(100);
    }
  });

  $('#togglemusic').click(function(e){
    e.preventDefault();
    console.log("music");
    $(this).find('i').toggleClass("rotate");

    if($('#musicbar').is(':visible')){
      $('#musicbar').find('iframe').attr('src','http://music.163.com/outchain/player?type=0&id=78822606&auto=0&height=32');
      OpenInNewWindow = false;
      $('#musicbar').slideUp(300);
    }else{
      $('#musicbar').find('iframe').attr('src','http://music.163.com/outchain/player?type=0&id=78822606&auto=1&height=32');
      OpenInNewWindow = true;
      $('#musicbar').slideDown(300);
    }
  });

  $('a').on('click',function(e){
    // if music is playing, open the link in new window
    if($(this).attr('id') == "togglemusic") return;
    if(!OpenInNewWindow) return;
    e.preventDefault();
    var newlink = $(this).attr("href");
    if(newlink && newlink != "javascript:;"){
      window.open(newlink,"something");
    }
  });

  // for the series part
  $('.series h2,.series .expand,.series .collapse').on('click',function(e){
    e.stopPropagation();
    $('.series ul').slideToggle(300);
    $('.series .expand').toggle();
    $('.series .collapse').toggle();
  })

  $('i.reloadimage').on('click',function(){
    var path_prefix = location.pathname.split("/")[2];
    randomImage(path_prefix);
  })

  $(".filter").on("click", function () {
    var $this = $(this);
    // if we click the active tab, do nothing
    if ( !$this.hasClass("active") ) {
      $(".filter").removeClass("active");
      $this.addClass("active"); // set the active tab
      // get the data-rel value from selected tab and set as filter
      var $filter = $this.data("rel"); 
      // if we select view all, return to initial settings and show all
      $filter.toLowerCase() == 'all' ? 
          $(".post")
          .not(":visible")
          .fadeIn() 
      : // otherwise
          $(".post")
          .fadeOut(0)
          .filter(function () {
              // set data-filter value as the data-rel value of selected tab
              return $(this).data("filter").split(" ").indexOf($filter)!=-1; 
          })
          // set data-fancybox-group and show filtered elements
          .fadeIn(1000); 
    } // if
  }); // on
})
