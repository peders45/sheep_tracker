class SheepTracker.Views.SheepMissing extends Thorax.View

  className: "sheep"
  template: SheepTracker.templates.sheepMissing

  initialize: ->
    # Set the id based on the URL hash
    @id = window.location.hash

    # Create a header view and pass the model 
    # and set the delegate to the sheep missing view
    @headerView = new SheepTracker.Views.Header({@model, delegate: this})