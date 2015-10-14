---
layout: home_base
title: All Puzzles Confuse me!
function: puzzle
author: taoalpha
permalink: /puzzle/
id: puzzle
---
<div class="puzzle-top">
  <div class="namespace">
    <h1>MY PUZZLES</h1>
    <span class="check"><i class="fa fa-check fa-1x">0</i></span>
    <span class="ongoing"><i class="fa fa-hourglass-half fa-1x">0</i></span>
  </div>
  <div class="newbutton">+</div>
</div>
<div id="timeline" class="timeline-container"></div>

{% stylesheet puzzle %}

<link rel="stylesheet" href="https://technotarek.com/timeliner/js/vendor/venobox/venobox.css">
<script src='https://technotarek.com/timeliner/js/vendor/venobox/venobox.min.js'></script>
{% javascript timeliner %}
{% javascript puzzle %}
<script>
    $(document).ready(function() {
      puzzle = new Puzzles("all")
      $(document).on('click','p.editanswer',
        function(){
          var ele = $(this);
          var text = ele.text();
          var placeholder= ele.attr("placeholder")
          if (text ==  placeholder){
            ele.html("")
          }
        }
      );
      $(document).on('blur','p.editanswer',
        function(){
          var ele = $(this);
          var text = ele.text();
          var placeholder= ele.attr("placeholder")
          if (text ==  ''){
            ele.html(placeholder)
          }else{
            puzzle.savePuzzleAnswer(ele.closest('div.timeline-wrapper').attr("data-date"),ele.closest('dl.timeline-series').attr("data-time"),text);
          }
        }
      );
      $(document).on('click','dt.timeline-event span',function(e){
        e.stopPropagation();
        e.preventDefault();
        var ele = $(this)
        var status = ""
        if(ele.closest('dl.timeline-series').hasClass("check")){
          status = "ongoing"
          ele.closest('dl.timeline-series').removeClass("check").addClass("ongoing")
        }else{
          status = "check"
          ele.closest('dl.timeline-series').removeClass("ongoing").addClass("check")
        }
        puzzle.updatePuzzleStatus(ele.closest('div.timeline-wrapper').attr("data-date"),ele.closest('dl.timeline-series').attr("data-time"),status);
      });
      $.timeliner({});
      $('.venobox').venobox();
    });

  </script>
