---
layout: page
title: Terms
css: ["about.css", "animate.css", "morphext.css"]
js: ["morphext.min.js", "about.js"]
permalink: /terms/
---

<div class="thi-columns">
  <ul class="tag-post">
  {% for term in site.terms %}
    <a class="post-title" href="{{ site.baseurl }}{{ term.url }}">
      <li>
        {{ term.title }} 
      </li>
    </a>
  {% endfor %}
  </ul>
</div>
