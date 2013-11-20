class SheepTracker.Views.Invite extends Thorax.View

  className: "sheep"
  template: SheepTracker.templates.invite
  events:
    "submit form": "_onSubmit"

  initialize: ->
    # Create a header view and pass the sheep collection
    # and set the delegate to the history view
    @headerView = new SheepTracker.Views.Header({@collection, delegate: this})
    
    # Create a new to hold all notifications
    @notificationsView = new SheepTracker.Views.Notifications()

  _onSubmit: (e) ->
    e.preventDefault()

    # Serialize all the data in the form elements
    attributes = @serialize()

    # Validate that the user filled out both fields 
    if attributes.email == "" || attributes.message == ""
      @showError("Please fill out both fields")
      return

    # Send an Ajax request to the server with
    # the serialized data. Display form messages
    # based on the response
    $.ajax
      type: "post"
      url: "#{SERVER_URL}/invite"
      data: attributes
      success: (data) =>
        @showMessage(data)
      error: (data) =>
        @showError(data.statusText)

  # Display the error message
  showError: (data) ->
    @$el.find(".error-message").html(data).addClass("visible")

  # Display the success message
  showMessage: (data) ->
    @$el.find(".success-message").html(data).addClass("visible")

  # Method that the subview can call from the 
  # delegate reference to add notifications
  NotificationDidAppear: (message, type) ->
    # Add a new notification view with 
    # the passed message and type
    @notificationsView.add(message, type)