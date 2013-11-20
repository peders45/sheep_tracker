class SheepTracker.Views.History extends Thorax.View

  className: "history"
  template: SheepTracker.templates.history

  initialize: ->
    # Store the sheep collection in a separate variable
    sheep = @collection

    # Create a new collection variable for all activities
    # and fetch them from the server
    @collection = new SheepTracker.Collections.Activities()
    @collection.fetch()

    # Create a header view and pass the sheep collection
    # and set the delegate to the history view
    @headerView = new SheepTracker.Views.Header({collection: sheep, delegate: this})
    
    # Create a view to display all the activities
    @activitiesView = new SheepTracker.Views.Activities({@collection})

    # Create a new to hold all notifications
    @notificationsView = new SheepTracker.Views.Notifications()

  # Method that the subview can call from the 
  # delegate reference to add notifications
  NotificationDidAppear: (message, type) ->
    # Add a new notification view with 
    # the passed message and type
    @notificationsView.add(message, type)