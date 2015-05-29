$(function(){
  $(".filter").on("click", function () {
    var $this = $(this);
    // if we click the active tab, do nothing
    if ( !$this.hasClass("active") ) {
      $(".filter").removeClass("active");
      $this.addClass("active"); // set the active tab
      // get the data-rel value from selected tab and set as filter
      var $filter = $this.data("rel"); 
      // if we select view all, return to initial settings and show all
      $filter == 'all' ? 
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
