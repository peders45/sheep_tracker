class SheepTracker.Views.Notifications extends Thorax.View

  className: "notifications"
  template: SheepTracker.templates.notifications
  events:
    collection:
      "add": "render"
    "click .notification-close": "close"

  initialize: ->
    @collection = new SheepTracker.Collections.Notifications()
    
  add: (message, type) ->
    @collection.add({type, message})
    
    setTimeout(=>
      @collection.pop()
    , 4000)
  
  close: (e) ->
    id = e.currentTarget.parentNode.getAttribute("data-model-cid")
    model = @collection.get(id)
    model.destroy()