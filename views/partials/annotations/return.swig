{% if item.return %}
  <h3 class="sub-heading">Returns</h3>
  <p class="item-description">{% if item.return.description %}{{ item.return.description | safe }}{% endif %}
  {% if item.return.type == '*' %}
    Any
  {% else %}
    {{ item.return.type | split('|') | trim | capitalize | join(', ') }}
  {% endif %}
  </p>
{% endif %}
