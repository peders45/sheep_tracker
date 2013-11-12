class SheepTracker.Views.Sheep extends Thorax.View

  className: "sheep"
  template: SheepTracker.templates.sheep
  events:
    "click .sheep-action-delete": "clear"
    "click .sheep-action-edit": "edit"
    "click .sheep-state": "state"
    model:
      change: "render"

  initialize: ->
    @mapView = new SheepTracker.Views.Map({@model})
    @headerView = new SheepTracker.Views.Header({@collection, delegate: this})
    @notificationsView = new SheepTracker.Views.Notifications()

  render: ->
    super
    @mapView?.addMap()

  NotificationDidAppear: (message, type) ->
    @notificationsView.add(message, type)

  clear: (e) ->
    e.preventDefault()
    @model.destroy()
    window.location.hash = ""
    return false

  edit: (e) ->
    e.preventDefault()
    @formView = new SheepTracker.Views.Form({@model, delegate: this})
    @formView.appendTo("body")

  state: (e) ->
    if @model.get("state") == 1
      @model.set("state": 0)
      @model.save()