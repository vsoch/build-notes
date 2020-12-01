---
layout: page
title: Papers
css: ["about.css", "animate.css", "morphext.css"]
js: ["morphext.min.js", "about.js"]
permalink: /papers/
---

<div class="thi-columns">
  <ul class="tag-post">
  {% for paper in site.papers %}
    <a class="post-title" href="{{ site.baseurl }}{{ paper.url }}">
      <li>
        {{ paper.title }} 
      </li>
    </a>
  {% endfor %}
  </ul>
</div>

See [all references here]({{ site.baseurl }}/references/).
