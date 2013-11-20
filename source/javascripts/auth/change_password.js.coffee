#= require ../libs/jquery-2.0.3.min
#= require ../libs/underscore.min.js
#= require ../libs/backbone.min.js
#= require ../libs/handlebars
#= require ../libs/thorax.js
#= require ../config.js
  
class ChangePasswordView extends Thorax.View

  # Find and compile the form template,
  # set the classname of the the view 
  # and bind events on form submit
  template: Handlebars.compile(document.getElementById("change-password").innerHTML)
  className: "auth"
  events:
    "submit form": "_onSubmit"

  initialize: ->
    # Redirect the user if the URL contains an ID
    # and create an @id variable if it exists
    unless @id = window.location.hash.slice(1)
      @redirect()

  render: ->
    super
    # Store two variables containing the 
    # form message DOM elements
    @$errorMessage = @$el.find(".error-message")
    @$successMessage = @$el.find(".success-message")

  _onSubmit: (e) ->
    e.preventDefault()

    # Set the hidden form element for reset code
    # to be the same as the id
    document.getElementById("reset-code").value = @id
    
    # Serialize all the data in the form elements
    attributes = @serialize()
    
    # Send an Ajax request to the server with
    # the serialized data. Display form messages
    # based on the response
    $.ajax
      type: "post"
      url: "#{SERVER_URL}/change_password"
      data: attributes
      success: (data) =>
        @showSuccess(data)
      error: (data) =>
        @showError()

  # Display the error message
  showError: (e) ->
    @$successMessage.removeClass("visible")
    @$errorMessage.addClass("visible")

  # Display the success message
  showSuccess: (data) ->
    @$errorMessage.removeClass("visible")
    @$successMessage.html(data).addClass("visible")

# Create a new instance of the view 
# and appends it to the body
view = new ChangePasswordView()
view.appendTo("body")