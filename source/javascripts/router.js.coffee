class @SheepTracker.Router extends Backbone.Router

  routes:
    "": "index"
    ":id": "sheep"

  index: ->
    @indexView?.destroy()
    @sheepView?.destroy()
    @indexView = new SheepTracker.Views.Index()
    @indexView.appendTo("body")

  sheep: (id) ->
    @indexView?.destroy()
    @sheepView?.destroy()
    @sheepView = new SheepTracker.Views.Sheep({id: id})
    @sheepView.appendTo("body")