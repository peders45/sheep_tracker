class SheepTracker.Views.Activities extends Thorax.View

  template: SheepTracker.templates.activities

  initialize: ->
    # Creates a new instance of the activity items 
    # view. This will be rendered inside the acitivties view
    @activityItemsView = new SheepTracker.Views.ActivityItem({@collection, @delegate})