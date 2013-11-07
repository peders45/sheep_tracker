class SheepTracker.Views.Sheep extends Thorax.View

  className: "sheep"
  template: SheepTracker.templates.sheep
  events:
    model:
      "change": "render"
    "click .sheep-action-delete": "clear"
    "click .sheep-action-edit": "edit"
    "click .sheep-state": "state"

  initialize: ->
    @mapView = new SheepTracker.Views.Map({@model})
    @headerView = new SheepTracker.Views.Header({@model, delegate: this})
    @notificationsView = new SheepTracker.Views.Notifications()

  NotificationDidAppear: (message, type) ->
    @notificationsView.add(message, type)

  clear: (e) ->
    e.preventDefault()
    @destroy()
    @redirect()
    return false

  edit: (e) ->
    e.preventDefault()
    @formView = new SheepTracker.Views.Form({@model, delegate: this})
    @formView.appendTo("body")

  state: (e) ->
    if @model.get("state") == 1
      @model.set("state": 0)
      @model.save()