class SheepTracker.Views.Sheep extends Thorax.View

  className: "sheep"
  template: SheepTracker.templates.sheep
  events:
    "click .sheep-action-delete": "clear"
    "click .sheep-action-edit": "edit"
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
    @model.destroy(
      {
        success: ->
          window.location = window.location.href.split('#')[0]
      }
    )
    
    return false

  edit: (e) ->
    e.preventDefault()
    @formView = new SheepTracker.Views.Form({@model, delegate: this})
    @formView.appendTo("body")