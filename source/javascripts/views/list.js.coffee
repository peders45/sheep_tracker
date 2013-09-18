class SheepTracker.Views.List extends Thorax.View

  template: SheepTracker.templates.list

  initialize: ->
    collection = new SheepTracker.Collections.Sheep()
    @listItemsView = new SheepTracker.Views.ListItems({collection})

  filter: (value) ->
    @listItemsView.setQuery(value)