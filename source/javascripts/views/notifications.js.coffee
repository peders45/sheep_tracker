class SheepTracker.Views.Notifications extends Thorax.View

  className: "notifications"
  template: Handlebars.compile("<div></div>")
  notificationTemplate: SheepTracker.templates.notification
  events:
    "click .notification-close": "remove"
  
  add: (message, type) ->
    @$el.append(@notificationTemplate({message, type}))

  remove: (e) =>
    $(e.currentTarget.parentNode).remove()
