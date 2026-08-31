---
layout: page
title: tags
permalink: /tags/
---

{%- assign sorted_tags = site.tags | sort -%}
{%- for tag in sorted_tags -%}
  {%- assign tag_name = tag[0] -%}
  {%- assign tag_posts = tag[1] -%}
<h2 class="year-heading" id="{{ tag_name | slugify }}">{{ tag_name }} <span class="tag-count">{{ tag_posts.size }}</span></h2>
<ul class="post-list">
  {%- for post in tag_posts -%}
  <li>
    <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
    <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
  </li>
  {%- endfor -%}
</ul>
{%- endfor -%}
