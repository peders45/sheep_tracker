class SheepTracker.Views.Activities extends Thorax.View

  template: SheepTracker.templates.activities

  initialize: ->
    @activityItemsView = new SheepTracker.Views.ActivityItem({@collection, @delegate})