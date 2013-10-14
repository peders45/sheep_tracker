#= require ../libs/jquery-2.0.3.min
#= require ../libs/underscore.min.js
#= require ../libs/backbone.min.js
#= require ../libs/handlebars
#= require ../libs/thorax.js
#= require ../config.js

class LoginView extends Thorax.View

  template: Handlebars.compile(document.getElementById("login").innerHTML)
  className: "auth"
  events:
    "submit form": "_onSubmit"

  _onSubmit: (e) ->
    e.preventDefault()
    attributes = @serialize()

    $.ajax
      type: "post"
      url: "#{SERVER_URL}/login"
      data: attributes
      success: (data) =>
        @redirect()
      error: (data) =>
        @showError()

  showError: (e) ->
    @$el.addClass("error")
    @$el.find(".error-message").addClass("visible")

  redirect: ->
    window.location = "index.html"

view = new LoginView()
view.appendTo("body")