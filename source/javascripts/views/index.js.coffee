class SheepTracker.Views.Index extends Thorax.View

  className: "index"
  template: SheepTracker.templates.index

  initialize: ->
    # Create a header view and pass the sheep collection
    # and set the delegate to the index view
    @headerView = new SheepTracker.Views.Header({@collection, delegate: this})

    # Create a view to display the map
    @mapView = new SheepTracker.Views.Map({@collection})

    # Create a view to display a list of all sheep
    # and pass a reference to this view as the delegate
    @listView = new SheepTracker.Views.List({@collection, delegate: this})

    # Create a view for the filter bar and pass
    # a reference to this view as the delegate
    @filterBarView = new SheepTracker.Views.FilterBar({delegate: this})

    # Create a new to hold all notifications
    @notificationsView = new SheepTracker.Views.Notifications()

  # Method that the subview can call from the 
  # delegate reference to trigger the filter bar
  FilterBarDidChangeValue: (value) ->
    # Filter the sheep in the list view 
    @listView.filter(value)

    # Toggle the class that hides the map
    # based on the value of the length
    @$el.toggleClass("no-map", value.length != 0) 

  # Method that the subview can call from the 
  # delegate reference to add notifications
  NotificationDidAppear: (message, type) ->
    # Add a new notification view with 
    # the passed message and type
    @notificationsView.add(message, type)