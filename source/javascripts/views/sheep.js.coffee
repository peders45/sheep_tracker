class SheepTracker.Views.Sheep extends Thorax.View

  className: "sheep"
  template: SheepTracker.templates.sheep
  events:
    "click .sheep-action-delete": "clear"
    "click .sheep-action-edit": "edit"
    model:
      # Bind event on when the model changes
      # and renders the view 
      change: "render"

  initialize: ->

    # Create a view to display the map and passes the 
    # model to only display this sheep
    @mapView = new SheepTracker.Views.Map({@model})
   
    # Create a header view and pass the sheep collection
    # and set the delegate to the  sheep view
    @headerView = new SheepTracker.Views.Header({@collection, @model, delegate: this})
    
    # Create a new to hold all notifications
    @notificationsView = new SheepTracker.Views.Notifications()

  render: ->
    super
    # Call the addMap method after the view rendered
    @mapView?.addMap()

  # Method that the subview can call from the 
  # delegate reference to add notifications
  NotificationDidAppear: (message, type) ->
    # Add a new notification view with 
    # the passed message and type
    @notificationsView.add(message, type)

  clear: (e) ->
    e.preventDefault()

    # Destroy the model which tells the server
    # to delete it from the database
    @model.destroy(
      {
        # Redirect the user back to the sheep list
        # if the model was successfully deleted
        success: ->
          window.location = window.location.href.split('#')[0]
      }
    )
    
    return false

  edit: (e) ->
    e.preventDefault()

    # Create a new form view for the model to be edited
    @formView = new SheepTracker.Views.Form({@model, delegate: this})
    @formView.appendTo("body")