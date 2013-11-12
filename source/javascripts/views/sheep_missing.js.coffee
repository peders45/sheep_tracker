class SheepTracker.Views.SheepMissing extends Thorax.View

  className: "sheep"
  template: SheepTracker.templates.sheepMissing

  initialize: ->
    @id = window.location.hash
    @mapView = new SheepTracker.Views.Map({@model})
    @headerView = new SheepTracker.Views.Header({@model, delegate: this})
    @notificationsView = new SheepTracker.Views.Notifications()

  NotificationDidAppear: (message, type) ->
    @notificationsView.add(message, type)