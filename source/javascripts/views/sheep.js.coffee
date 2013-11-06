class SheepTracker.Views.Sheep extends Thorax.View

  className: "sheep"
  template: SheepTracker.templates.sheep
  events:
    "click .sheep-action-delete": "clear"
    "click .sheep-action-edit": "edit"

  initialize: ->
    @model = new SheepTracker.Models.Sheep({id: @id})
    @model.fetch({error: @redirect})
    @mapView = new SheepTracker.Views.Map({@modal})
    @headerView = new SheepTracker.Views.Header({delegate: this})
    @notificationsView = new SheepTracker.Views.Notifications()

  NotificationDidAppear: (message, type) ->
    @notificationsView.add(message, type)

  redirect: ->
    window.location = "/"

  clear: (e) ->
    e.preventDefault()
    @destroy()
    @redirect()
    return false

  edit: (e) ->
    e.preventDefault()
    @formView = new SheepTracker.Views.Form({@model, delegate: this})
    @formView.appendTo("body")