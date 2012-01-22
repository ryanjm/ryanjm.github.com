---
layout: archive
title: Categories
header: Posts By Category
group: example-page
---

<ul class="archive">
  {% assign categories_list = site.categories %}
  {% include categories_list.html %}
</ul>

<hr />

{% for category in site.categories %} 
  <h2 id="{{ category[0] }}-ref">{{ category[0] | join: "/" }}</h2>
  <ul class="archive indent">
    {% assign pages_list = category[1] %}  
    {% include pages_list.html %}
  </ul>
{% endfor %}

