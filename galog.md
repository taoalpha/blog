---
layout: home_base
title: GA Log Analytic
function: log-analyse
author: taoalpha
permalink: /galog/
id: galog-page
---
<style>
/************** GA log page ************/
article.galog ul {
  padding-left: 0px;
}

article.galog li.post.overall {
  height: 210px;
}

article.galog summary{
  margin-bottom: 20px;
}

article.galog li.overall summary ul li {
  width: 28%;
  float: left;
  margin: 0 20px 20px 0px;
  background-color: #F1F1F1;
  border-top: 4px solid #9E9E9E;
  color: #242424;
  font-weight: normal;
  padding: 7px;
}

article.galog li.overall summary span.itemname {
  font-size: 10px;
}

article.galog li.overall summary span.itemname i {
  margin-left: 5px;
}

article.galog li.overall summary span.count {
  font-size: 19px;
  text-shadow: 1px 1px 0 #FFF;
  padding: 8px 0px;
  display: block;
  font-weight: 700;
}
.pure-table {
    animation: float 5s infinite;
    border: 1px solid #cbcbcb;
    border-collapse: collapse;
    border-spacing: 0;
    box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
    empty-cells: show;
    border-radius: 3px;
}
.pure-table a {
    color: #242424;
    outline: 0;
    text-decoration: none;
}
.pure-table td {
    border-left: 1px solid #cbcbcb;
}
.pure-table td,
.pure-table th {
    font-size: inherit;
    margin: 0;
    overflow: visible;
    padding: 6px 12px;
}
.pure-table th:last-child {
    padding-right: 0;
}
.pure-table th:last-child span {
    margin: 1px 15px 0 15px;
    float:right;
}
.pure-table thead th {
    border-bottom: 4px solid #9ea7af;
    border-right: 1px solid #343a45;
}
.pure-table tbody th {
    background: rgb(242, 242, 242);
    border-left: 1px solid rgb(203, 203, 203);
}
.pure-table td:first-child,
.pure-table th:first-child {
    border-left-width: 0
}
.pure-table td:last-child {
    white-space: normal;
    width: auto;
    word-break: break-all;
    word-wrap: break-word;
}
.pure-table thead {
    background: #242424;
    color: #FFF;
    text-align: left;
    text-shadow: 0px -1px 0px #000;
    vertical-align: bottom;
}
.pure-table td {
    background-color: #FFF
}
.pure-table td.num {
    text-align: right
}
.pure-table .sub td {
    background-color: #F2F2F2;
}
.pure-table tbody{
  color: #777;
  font-size:12px;
}
.pure-table tbody tr:nth-of-type(n+10){
  display:none;
}
.pure-table tbody tr:hover,
.pure-table-striped tr:nth-child(2n-1) td {
    background-color: #f4f4f4
}
.pure-table tr {
    border-bottom: 1px solid #ddd;
}
.pure-table thead tr {
    border: 1px solid rgb(52, 58, 69);
} 

</style>

<nav id="bread">
  <h2>Site Logs for last 30 days:</h2>
</nav>
<article class="galog">
  <ul class="article-list">
    <li class="post overall">
      <h4>overall analyzed requests</h4>
      <summary>
      </summary>
    </li>
    <li class="post Path">
      <h4>Top requests</h4>
      <summary>
      <table class="pure-table">
        <thead>
        </thead>
        <tbody>
        </tbody>
      </table>
     </summary>
    </li>

    <li class="post Referer">
      <h4>Top referers</h4>
      <summary>
        <table class="pure-table">
          <thead>
          </thead>
          <tbody>
          </tbody>
        </table>
     </summary>
    </li>

    <li class="post OS">
      <h4>Top Operating Systems</h4>
      <summary>
        <table class="pure-table">
          <thead>
          </thead>
          <tbody>
          </tbody>
        </table>
     </summary>
    </li>

    <li class="post Browser">
      <h4>Top Browsers</h4>
      <summary>
        <table class="pure-table">
          <thead>
          </thead>
          <tbody>
          </tbody>
        </table>
     </summary>
    </li>

    <li class="post Country">
      <h4>Top Countries</h4>
      <summary>
        <table class="pure-table">
          <thead>
          </thead>
          <tbody>
          </tbody>
        </table>
     </summary>
    </li>
  </ul>
</article>

<script>getGALogFile();</script>
