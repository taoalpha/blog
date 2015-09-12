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
<div id="timeline" class="timeline-container">
  <button class="timeline-toggle hide">+ expand all</button>
  <div class="timeline-wrapper ongoing">
    <h2 class="timeline-time date-title">
      <span class='puzzles-title'>Thur, Sep 9th, 2015</span>
      <span class="count">2 puzzles</span>
    </h2>
    <dl class="timeline-series">
      <dt id="824201453158PM" class='timeline-event'>
        <a class="closed puzzle_title" style="font-size: 1.0em;">Why can not use call or apply for setTimeout function to change the scope for setTimeout? </a>
        <span class="check"><i class="fa fa-check fa-2x"></i></span>
      </dt>
      <dd class="timeline-event-content puzzle_detail" id="824201453158PMEX">
        <p class="puzzle-desc">We can use call and apply to change the scope of a function, but why we can not use it on setTimeout?</p>
        <p contentEditable="true" class='editanswer'>Type here to write your answers. If the answer is too long, please use a link.</p>
      </dd>
    </dl>
    <dl class="timeline-series">
      <dt id="824201453152PM" class='timeline-event'>
        <a class="closed puzzle_title" style="font-size: 1.0em;">Why can not use call or apply for setTimeout function to change the scope for setTimeout? </a>
        <span class="ongoing"><i class="fa fa-check fa-2x"></i></span>
      </dt>
      <dd class="timeline-event-content puzzle_detail" id="824201453152PMEX">
        <p class="puzzle-desc">We can use call and apply to change the scope of a function, but why we can not use it on setTimeout?</p>
        <p contentEditable="true" class='editanswer'>Type here to write your answers. If the answer is too long, please use a link.</p>
      </dd>
    </dl>
  </div>
  <br class="clear">
  <div class="timeline-wrapper check">
    <h2 class="timeline-time date-title">
      <span class='puzzles-title'>Thur, Sep 9th, 2015</span>
      <span class="count">2 puzzles</span>
    </h2>
    <dl class="timeline-series">
      <dt id="824201453158PM" class='timeline-event'>
        <a class="closed puzzle_title" style="font-size: 1.0em;">Why can not use call or apply for setTimeout function to change the scope for setTimeout? </a>
        <span class="check"><i class="fa fa-check fa-2x"></i></span>
      </dt>
      <dd class="timeline-event-content puzzle_detail" id="824201453158PMEX">
        <p class="puzzle-desc">We can use call and apply to change the scope of a function, but why we can not use it on setTimeout?</p>
        <p contentEditable="true" class='editanswer'>Type here to write your answers. If the answer is too long, please use a link.</p>
      </dd>
    </dl>
    <dl class="timeline-series">
      <dt id="824201453152PM" class='timeline-event'>
        <a class="closed puzzle_title" style="font-size: 1.0em;">Why can not use call or apply for setTimeout function to change the scope for setTimeout? </a>
        <span class="check"><i class="fa fa-check fa-2x"></i></span>
      </dt>
      <dd class="timeline-event-content puzzle_detail" id="824201453152PMEX">
        <p class="puzzle-desc">We can use call and apply to change the scope of a function, but why we can not use it on setTimeout?</p>
        <p contentEditable="true" class='editanswer'>Type here to write your answers. If the answer is too long, please use a link.</p>
      </dd>
    </dl>
  </div>
  <br class="clear">
</div>

{% stylesheet puzzle %}

<link rel="stylesheet" href="https://technotarek.com/timeliner/js/vendor/venobox/venobox.css">
<script src='https://technotarek.com/timeliner/js/vendor/venobox/venobox.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.2/handlebars.min.js'></script>
{% javascript timeliner %}
<script>
    $(document).ready(function() {
      $.timeliner({});
      $('.venobox').venobox();
    });

  </script>
