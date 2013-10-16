#= require ../libs/jquery-2.0.3.min
#= require ../libs/underscore.min.js
#= require ../libs/backbone.min.js
#= require ../libs/handlebars
#= require ../libs/thorax.js
#= require ../config.js

class InviteView extends Thorax.View

  className: "auth"
  template: Handlebars.compile(document.getElementById("invite").innerHTML)
  events:
    "submit form": "_onSubmit"

  _onSubmit: (e) ->
    e.preventDefault()
    attributes = @serialize()

    $.ajax
      type: "post"
      url: "#{SERVER_URL}/invite"
      data: attributes
      success: (data) =>
        @showMessage(data)
      error: (data) =>
        @showError()

  showError: (data) ->
    @$el.find(".error-message").addClass("visible")

  showMessage: (data) ->
    @$el.find(".success-message").html(data).addClass("visible")


view = new InviteView()
view.appendTo("body")