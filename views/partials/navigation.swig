
<nav class="side-nav">
  <ul class="social">
    <li><a class="github" href="{{ view.links.github }}">GitHub / Install</a></li>
    <li><a class="twitter" href="{{ view.links.twitter }}">Twitter</a></li>
    <li><a class="gitter" href="{{ view.links.gitter }}">Gitter</a></li>
  </ul>

  <a class="logo-container" href="{{ view.library.homepage }}">
    <img alt="{{ view.library.name }} Logo" class="logo" src="{{ view.logoPath }}">
  </a>

  <ul class="list">
    {% for group_name, group in data.byGroupAndType %}
      <ul>
        <h2 class="type-title"> {{group_name}} </h2>
        {% for type, items in group %}
          {% if type == "mixin" %}
            {% include "type_list.swig" %}
          {% endif %}
        {% endfor %}
          {% for type, items in group %}
            {% if type == "function" %}
              {% include "type_list.swig" %}
            {% endif %}
          {% endfor %}
          {% for type, items in group %}
            {% if type == "variable" %}
              {% include "type_list.swig" %}
            {% endif %}
          {% endfor %}
      </ul>
    {% endfor %}
  </ul>
</nav>
