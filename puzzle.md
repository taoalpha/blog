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
    <span class="check"><i class="fa fa-check fa-1x">9</i></span>
    <span class="ongoing"><i class="fa fa-hourglass-half fa-1x">7</i></span>
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
      var puzzle = new Puzzles("all")
      $.timeliner({});
      $('.venobox').venobox();
    });

  </script>
