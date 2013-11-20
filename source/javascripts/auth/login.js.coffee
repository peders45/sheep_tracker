#= require ../libs/jquery-2.0.3.min
#= require ../libs/underscore.min.js
#= require ../libs/backbone.min.js
#= require ../libs/handlebars
#= require ../libs/thorax.js
#= require ../config.js

class LoginView extends Thorax.View

  # Find and compile the login template
  # set the classname of the the view 
  # and bind events on form submit
  template: Handlebars.compile(document.getElementById("login").innerHTML)
  className: "auth"
  events:
    "submit form": "_onSubmit"

  _onSubmit: (e) ->
    e.preventDefault()

    # Serialize all the data in the form elements
    attributes = @serialize()

    # Send an Ajax request to the server with
    # the serialized data. Redirect the user
    # to the index page if the user successfully
    # logged in. Displays error message if not
    $.ajax
      type: "post"
      url: "#{SERVER_URL}/login"
      data: attributes
      success: (data) =>
        @redirect()
      error: (data) =>
        @showError()

  # Display the error message
  showError: (e) ->
    @$el.addClass("error")
    @$el.find(".error-message").addClass("visible")

  # Redirect the user to the index view
  redirect: ->
    window.location = "index.html"

# Create a new instance of the view 
# and appends it to the body
view = new LoginView()
view.appendTo("body")