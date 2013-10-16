class SheepTracker.Views.Header extends Thorax.View

  className: "header"
  template: SheepTracker.templates.header
  events:
    "click .add-sheep": "showForm"
    "click .attack-sheep": "attackSheep"
    "click .logout": "logout"
    "click .invite": "invite"

  initialize: ->
    @attacked = 0

  showForm: (e) ->
    e.preventDefault()
    @formView = new SheepTracker.Views.Form({delegate: this, collection: @collection})
    @formView.appendTo("body")
    return false

  attackSheep: (e) ->
    if model = @collection.at(@attacked++)
      model.set({attack: true})
    else
      @$el.addClass("attack-disabled")

  logout: (e) ->
    $.ajax
      type: "get"
      url: "#{SERVER_URL}/logout"
      success: (data) ->
        window.location = "index.html"
      error: (data) ->
        window.location = "index.html"

  invite: (e) ->
    window.location = "invite.html"