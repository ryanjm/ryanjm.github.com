---
layout: archive
title : Archive
header : Post Archive
group: example-page
---

<ul class="archive">
  {% assign pages_list = site.posts %}
  {% include pages_list.html %}
</ul> 