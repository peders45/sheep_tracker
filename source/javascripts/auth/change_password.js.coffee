#= require ../libs/jquery-2.0.3.min
#= require ../libs/underscore.min.js
#= require ../libs/backbone.min.js
#= require ../libs/handlebars
#= require ../libs/thorax.js
#= require ../config.js

class ChangePasswordView extends Thorax.View

  template: Handlebars.compile(document.getElementById("change-password").innerHTML)
  className: "auth"
  events:
    "submit form": "_onSubmit"

  initialize: ->
    unless @id = window.location.hash.slice(1)
      @redirect()

  render: ->
    super

  _onSubmit: (e) ->
    e.preventDefault()
    document.getElementById("reset-code").value = @id
    attributes = @serialize()
    
    $.ajax
      type: "post"
      url: "#{SERVER_URL}/change_password"
      data: attributes
    success: (data) =>
        @redirect()
      error: (data) =>
        @showError()

  showError: (e) ->
    @$el.addClass("error")
    @$el.find(".error-message").show()

  redirect: ->
    window.location = "index.html"

view = new ChangePasswordView()
view.appendTo("body")