class SheepTracker.Views.ListItems extends Thorax.CollectionView
  itemTemplate: SheepTracker.templates.listItem

  itemFilter: (model, index) ->
    if @query
      nameIndex = model.get("name").toLowerCase().indexOf(@query.toLowerCase())
      weightIndex = model.get("weight").toString().indexOf(@query)
      return (nameIndex != -1 || weightIndex != -1)
    return true

  setQuery: (@query) ->
    @collection.trigger("filter")
