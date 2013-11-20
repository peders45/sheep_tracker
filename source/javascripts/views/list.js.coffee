class SheepTracker.Views.List extends Thorax.View

  template: SheepTracker.templates.list

  initialize: ->
    # Create a new collection view for all the
    # list item, and passes a reference to this
    # view as the delegate
    @listItemsView = new SheepTracker.Views.ListItems({@collection, @delegate})

  # Public method that other view can call to
  # filter the view
  filter: (value) ->
    # Call the method setQuery on the list item view
    @listItemsView.setQuery(value)