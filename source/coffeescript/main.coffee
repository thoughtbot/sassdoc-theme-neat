class App
  LINK_CLASS = "result-link"

  $items = $("article.item")
  $searchInput = $(".search-field")
  $groupsHandler = $("ul.list h2.type-title")
  $searchForm = $("[data-role=search-form]")
  $suggestionContainer = $(".suggestion-container")
  $suggestions = $(".#{LINK_CLASS}")
  suggestions = []

  searchOptions =
    keys: ["name"]
    threshold: 0.3
    caseSensitive: false

  items = $items.map ->
    $item = $(@)
    name: $item.data "name"
    type: $item.data "type"
    node: $item

  searchEngine = new Fuse items, searchOptions

  constructor: ->
    hljs.initHighlightingOnLoad()
    @initSearch()
    @initGroupsToggle()

  fillSuggestions: (items) ->
    $suggestionContainer.html ""
    suggestions = $.map(items.slice(0, 10), (item) ->
      $item = $("<li />",
        "data-type": item.type
        "data-name": item.name
        "class": "result"
        html: "<a href=\"##{item.name}\" class=\"result-link\"><code>#{item.type.slice(0, 1)}</code>#{item.name}</a>")
      $suggestionContainer.append $item)
    @bindResultClicks()

  search: (term) ->
    @fillSuggestions(searchEngine.search(term))

  bindResultClicks: ->
    self = @
    $(".#{LINK_CLASS}").on 'click', (event) ->
      $target = $(event.target)
      $searchInput.val $target.parent().data "name"
      suggestions = self.fillSuggestions([])

  _hideChilds = (pointer) ->
    pointer.removeClass('shown').css("max-height","55px")

  _showChilds = (pointer) ->
    pointerPosition = pointer.position().top
    ul_max_height   = parseInt(pointer.find('li').length) * 45 + 55;
    pointer.addClass('shown').css("max-height",ul_max_height+"px");
    $('.side-nav').animate({scrollTop:pointerPosition},800);

  initGroupsToggle: ->
    $groupsHandler.on("click", (event) ->
      if    $(this).parent('ul').hasClass('shown')
      then  _hideChilds $(this).parent('ul')
      else  _showChilds $(this).parent('ul')
    )

  initSearch: ->
    self = @
    $searchInput.on("keyup", (event) ->
      if event.keyCode isnt 40 and event.keyCode isnt 38
        currentSelection = -1
        suggestions = self.search $(@).val()
      else
        event.preventDefault()
      return
    ).on "search", ->
        suggestions = self.search $(@).val()





$ ->
  new App
