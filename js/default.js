var rotation = 0

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
})
