#= require ../libs/jquery-2.0.3.min
#= require ../libs/underscore.min.js
#= require ../libs/backbone.min.js
#= require ../libs/handlebars
#= require ../libs/thorax.js
#= require ../config.js

class RegisterView extends Thorax.View

  template: Handlebars.compile(document.getElementById("register").innerHTML)
  className: "auth"
  events:
    "submit form": "_onSubmit"

  _onSubmit: (e) ->
    e.preventDefault()
    attributes = @serialize()

    $.ajax
      type: "post"
      url: "#{SERVER_URL}/register"
      data: attributes
      success: (data) =>
        @showMessage(data)
      error: (data) =>
        @showError()

  showError: (data) ->
    @$el.find(".error-message").addClass("visible")

  showMessage: (data) ->
    @$el.find(".success-message").html(data).addClass("visible")

view = new RegisterView()
view.appendTo("body")