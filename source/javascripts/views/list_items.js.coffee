class SheepTracker.Views.ListItems extends Thorax.CollectionView
  
  itemTemplate: SheepTracker.templates.listItem
  
  # Bind events on the links in the list
  events:
    "click .sheep-list-item-remove": "clear"
    "click .sheep-list-item-edit": "edit"
    "click .sheep-list-item": "redirect"

  # This method listens to the filter event 
  # which is triggered from the setQuery method
  itemFilter: (model, index) ->
    # Check if the query variable is set
    if @query
      # Check if the models contains a substring of the query
      nameIndex = model.get("name").toLowerCase().indexOf(@query.toLowerCase())
      weightIndex = model.get("weight").toString().indexOf(@query)
      return (nameIndex != -1 || weightIndex != -1)
    return true

  setQuery: (@query) ->
    # Trigger the filter event that the itemFilter
    # method listens to
    @collection.trigger("filter")

  clear: (e) ->
    # Stop the event bubbling from continuing 
    # and prevents the link from redirecting
    e.preventDefault()
    e.stopImmediatePropagation()

    # Get the model id from the data-model-id attribute
    id = e.currentTarget.parentNode.getAttribute "data-model-id"

    # Get the model from the collection based on the id
    model = @collection.get(id)

    # Create a new success message
    message = notifications.deleted.replace("%s", model.get("name"))
    
    # Create a new success messages and tells the delegate
    # class to show the success notification 
    @delegate?.NotificationDidAppear?(message, "success")
    
    # Remove the model from the collection. This
    # tells the server to delete the sheep
    model.destroy({wait: true})
    return false

  edit: (e) ->
    e.preventDefault()
    e.stopImmediatePropagation()

    # Get the model id from the data-model-id attribute
    id = e.currentTarget.parentNode.getAttribute "data-model-id"
    
    # Get the model from the collection based on the id
    model = @collection.get(id)

    # Create a new form view for the model to be edited
    @formView = new SheepTracker.Views.Form({@collection, model, @delegate})
    @formView.appendTo("body")

    return false

  redirect: (e) ->
    # Get the model id from the data-model-id attribute
    id = e.currentTarget.getAttribute "data-model-id"

    # Change the URL hash to the id of the sheep. This
    # will redirect the user to the sheep view for this model
    window.location.hash = id