class SheepTracker.Views.Notifications extends Thorax.View

  className: "notifications"
  template: Handlebars.compile("<div></div>")
  notificationTemplate: SheepTracker.templates.notification
  events:
    "click .notification-close": "clear"
  
  add: (message, type) ->
    @$el.append(@notificationTemplate({message, type}))

  clear: (e) =>
    $(e.currentTarget.parentNode).remove()
