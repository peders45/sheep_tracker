class SheepTracker.Views.Header extends Thorax.View

  className: "header"
  template: SheepTracker.templates.header

  # Bind event for the navigation items in the header
  events:
    "click .add-sheep": "showForm"
    "click .logout": "logout"

  showForm: (e) ->
    e.preventDefault()

    # Create a new form view when the user click the 
    # register button and append it to the body
    @formView = new SheepTracker.Views.Form({@collection, @delegate})
    @formView.appendTo("body")
    return false

  logout: (e) ->
    # Send a request telling the server to log
    # the current user out and redirects to the index page
    $.ajax
      type: "get"
      url: "#{SERVER_URL}/logout"
      success: (data) ->
        window.location = "index.html"
      error: (data) ->
        window.location = "index.html"