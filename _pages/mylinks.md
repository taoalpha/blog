---
layout: default 
pname: mylinks
permalink: /mylinks/
---

<section class="index-content mylinks" style="padding:0 0 0 50px;">
  {% assign linksdata = site.data.mylinks %}
  <div class="cate-bar">
      {% assign alltags = linksdata | map: "name" | join:"," | split:","|reverse|push:"All"|reverse %}
      <ul class="tags">
      {% for tag in alltags %}
          <a href="javascript:;" data-rel="{{ tag|replace: " ","-" }}" class="filter tag {% if tag == 'all'  %}active{% endif %}" >{{ tag }}</a>
      {% endfor %}
      </ul>
  </div>
  <div class="link-box">        
  {% for category in linksdata %}
  {% if category.links != null %}
      <ul class="post category" data-filter="{{ category.name|replace: " ","-"}}">
      <h2 class="title">{{ category.name|replace:"-"," " }}</h2>
      {% assign links = category.links | sort: 'order' %}
          {% for link in links %}
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
