var rotation = 0;
var OpenInNewWindow = false;
// 重写alert的代码:
window._alert = window.alert;
window.alert = function (msg, showItNow) {    
  if (showItNow) {
    window._alert(msg);
  }
};

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
    if(!OpenInNewWindow) return
    e.preventDefault()
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
})
