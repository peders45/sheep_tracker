class SheepTracker.Views.Header extends Thorax.View

  className: "header"
  template: SheepTracker.templates.header
  events:
    "click .add-sheep": "showForm"
    "click .logout": "logout"

  initialize: ->
    @attacked = 0

  showForm: (e) ->
    e.preventDefault()
    @formView = new SheepTracker.Views.Form({@collection, @delegate})
    @formView.appendTo("body")
    return false

  logout: (e) ->
    $.ajax
      type: "get"
      url: "#{SERVER_URL}/logout"
      success: (data) ->
        window.location = "index.html"
      error: (data) ->
        window.location = "index.html"