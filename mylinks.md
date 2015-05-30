---
layout: default 
pname: mylinks
permalink: /mylinks/
---

<section class="index-content mylinks" style="padding:0 0 0 50px;">
  {% assign linksdata = site.data.mylinks %}
  <div class="cate-bar">
      {% assign tags = "all" %}
      {% for post in linksdata %}
          {% unless tags contains post.name %}
              {% capture tags %}{{ tags }}|{{ post.name }}{% endcapture %}
          {% endunless %}
      {% endfor %}
      {% assign alltags = tags | split: '|' %}
      <ul class="tags">
      {% for tag in alltags %}
          <a href="javascript:;" data-rel="{{ tag }}" class="filter tag {% if tag == 'all'  %}active{% endif %}" >{{ tag|replace:"-"," " }}</a>
      {% endfor %}
      </ul>
  </div>
  <div class="link-box">        
  {% for category in linksdata %}
  {% if category.links != null %}
      <ul class="post category" data-filter="{{ category.name }}">
      <h2 class="title">{{ category.name|replace:"-"," " }}</h2>
          {% for link in category.links %}
        <li>
            <a href="{{ link.link }}" target="something">{{ link.title }}{% if link.desc != null %}<span class="sub-title">{{ link.desc }}</span>{% endif %}</a>
        </li>
          {% endfor %}
      </ul>
  {% endif %}
  {% endfor %}
  </div>
</section>
<script type="text/javascript">randomTags("showall")</script>
{% javascript home %}
