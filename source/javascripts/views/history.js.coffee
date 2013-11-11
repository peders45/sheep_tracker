class SheepTracker.Views.History extends Thorax.View

  className: "history"
  template: SheepTracker.templates.history

  initialize: ->
    @collection = new SheepTracker.Collections.Activities()
    @collection.fetch()
    @headerView = new SheepTracker.Views.Header({@collection, delegate: this})
    @activitiesView = new SheepTracker.Views.Activities({@collection})
    @notificationsView = new SheepTracker.Views.Notifications()

  NotificationDidAppear: (message, type) ->
    @notificationsView.add(message, type)