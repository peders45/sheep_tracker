class SheepTracker.Views.Notifications extends Thorax.View

  className: "notifications"
  template: SheepTracker.templates.notifications
  events:
    collection:
      "add": "render"
    "click .notification-close": "close"

  initialize: ->
    # Create a new collection that holds all the 
    # notification models
    @collection = new SheepTracker.Collections.Notifications()
    
  add: (message, type) ->
    # Add a model to the collection
    # view the type and message passed
    @collection.add({type, message})
    
    # Set a timeout of 4s that remove the
    # model from the collection
    @timeout = setTimeout(=>
      @collection.pop()
    , 4000)

    undefined
  
  close: (e) ->
    # Get the model id from the data-model-id attribute
    id = e.currentTarget.parentNode.getAttribute("data-model-cid")
    
    # Get the model from the collection based on the id
    model = @collection.get(id)

    # Remove the notification if the user clicked the 
    # close button
    model.destroy()

  destroy: ->
    super
    # Clear the timeout if the user navigates
    # away before the timeout triggered
    window.clearTimeout(@timeout)