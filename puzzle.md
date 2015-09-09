---
layout: home_base
title: All Puzzles Confuse me!
function: puzzle
author: taoalpha
permalink: /puzzle/
id: puzzle
---
<article class="container">
  <h1>Tao's Puzzles</h1>
  <div id="timeline" class="timeline-container">
    <button class="timeline-toggle">+ expand all</button>
    <div class="timeline-wrapper">
      <h2 class="timeline-time"><span>9/08/2014</span></h2>
      <dl class="timeline-series"> <dt id="824201453158PM" class='timeline-event'><div class="arrow" style="display: none;"></div><a class="closed" style="font-size: 1.0em;">Why can not use call or apply for setTimeout function to change the scope for setTimeout? </a><div class="cross"></div></dt>
          <dd class="timeline-event-content" id="824201453158PMEX" style="">
              <h3>9/08/2015, 12:31:58 PM</h3>
              <p>We all know that we can use call() or apply() to change the scope of a function, but why we can not use it on setTimeout function?</p>
              <br class="clear">
              <div class="edit"><a href="#edit_box" class="editthis cboxElement">Edit this</a></div>
          </dd>
      </dl>
    </div>
    <br class="clear">
  </div>
</article>

{% stylesheet puzzle %}

<link rel="stylesheet" href="https://technotarek.com/timeliner/js/vendor/venobox/venobox.css">
<script src='https://technotarek.com/timeliner/js/vendor/venobox/venobox.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.2/handlebars.min.js'></script>
{% javascript timeliner %}
<script>
    $(document).ready(function() {
      $.timeliner({
        timelineContainer:'#timeline',
      });
      $('.venobox').venobox();
    });

  </script>
