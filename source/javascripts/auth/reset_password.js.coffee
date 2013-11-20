#= require ../libs/jquery-2.0.3.min
#= require ../libs/underscore.min.js
#= require ../libs/backbone.min.js
#= require ../libs/handlebars
#= require ../libs/thorax.js
#= require ../config.js

class ResetPasswordView extends Thorax.View

  # Find and compile the reset password template
  # set the classname of the the view 
  # and bind events on form submit
  template: Handlebars.compile(document.getElementById("reset-password").innerHTML)
  className: "auth"
  events:
    "submit form": "_onSubmit"

  render: ->
    super
    # Store two variables containing the 
    # form message DOM elements
    @$errorMessage = @$el.find(".error-message")
    @$successMessage = @$el.find(".success-message")
    
  _onSubmit: (e) ->
    e.preventDefault()

    # Serialize all the data in the form elements
    attributes = @serialize()

    # Send an Ajax request to the server with
    # the serialized data. Display form messages
    # based on the response
    $.ajax
      type: "post"
      url: "#{SERVER_URL}/reset_password"
      data: attributes
      success: (data) =>
        @showMessage(data)
      error: (data) =>
        @showError()

  # Display the error message
  showError: (data) ->
    @$successMessage.removeClass("visible")
    @$errorMessage.addClass("visible")

  # Display the success message
  showMessage: (data) ->
    @$errorMessage.removeClass("visible")
    @$successMessage.html(data).addClass("visible")

# Create a new instance of the view 
# and appends it to the body
view = new ResetPasswordView()
view.appendTo("body")