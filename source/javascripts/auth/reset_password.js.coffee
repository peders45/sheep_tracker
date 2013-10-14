#= require ../libs/jquery-2.0.3.min
#= require ../libs/underscore.min.js
#= require ../libs/backbone.min.js
#= require ../libs/handlebars
#= require ../libs/thorax.js
#= require ../config.js

class ResetPasswordView extends Thorax.View

  template: Handlebars.compile(document.getElementById("reset-password").innerHTML)
  className: "auth"
  events:
    "submit form": "_onSubmit"

  render: ->
    super
    @$errorMessage = @$el.find(".error-message")
    @$successMessage = @$el.find(".success-message")
    
  _onSubmit: (e) ->
    e.preventDefault()
    attributes = @serialize()

    $.ajax
      type: "post"
      url: "#{SERVER_URL}/reset_password"
      data: attributes
      success: (data) =>
        @showMessage(data)
      error: (data) =>
        @showError()

  showError: (data) ->
    @$successMessage.removeClass("visible")
    @$errorMessage.addClass("visible")

  showMessage: (data) ->
    @$errorMessage.removeClass("visible")
    @$successMessage.html(data).addClass("visible")

view = new ResetPasswordView()
view.appendTo("body")