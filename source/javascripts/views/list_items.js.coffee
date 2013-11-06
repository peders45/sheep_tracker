class SheepTracker.Views.ListItems extends Thorax.CollectionView
  
  itemTemplate: SheepTracker.templates.listItem
  events:
    "click .sheep-list-item-remove": "clear"
    "click .sheep-list-item-edit": "edit"
    "click .sheep-list-item": "redirect"

  itemFilter: (model, index) ->
    if @query
      nameIndex = model.get("name").toLowerCase().indexOf(@query.toLowerCase())
      weightIndex = model.get("weight").toString().indexOf(@query)
      return (nameIndex != -1 || weightIndex != -1)
    return true

  setQuery: (@query) ->
    @collection.trigger("filter")

  clear: (e) ->
    e.preventDefault()
    id = e.currentTarget.parentNode.getAttribute "data-model-cid"
    @collection.get(id).destroy({wait: true})
    return false

  edit: (e) ->
    e.preventDefault()
    id = e.currentTarget.parentNode.getAttribute "data-model-cid"
    model = @collection.get(id)
    @formView = new SheepTracker.Views.Form({model: model, @delegate})
    @formView.appendTo("body")

  redirect: (e) ->
    id = e.currentTarget.getAttribute "data-model-id"
    window.location.hash = id