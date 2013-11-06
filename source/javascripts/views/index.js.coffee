class SheepTracker.Views.Index extends Thorax.View

  className: "index"
  template: SheepTracker.templates.index

  initialize: ->
    @collection = new SheepTracker.Collections.Sheep()
    @collection.fetch()
    @headerView = new SheepTracker.Views.Header({@collection, delegate: this})
    @mapView = new SheepTracker.Views.Map({@collection})
    @listView = new SheepTracker.Views.List({@collection})
    @filterBarView = new SheepTracker.Views.FilterBar({delegate: this})
    @notificationsView = new SheepTracker.Views.Notifications()

  FilterBarDidChangeValue: (value) ->
    @listView.filter(value)
    @$el.toggleClass("no-map", value.length != 0) 

  NotificationDidAppear: (message, type) ->
    @notificationsView.add(message, type)