class SheepTracker.Views.List extends Thorax.View

  template: SheepTracker.templates.list

  initialize: ->
    @listItemsView = new SheepTracker.Views.ListItems({@collection})

  filter: (value) ->
    @listItemsView.setQuery(value)