class @SheepTracker.Router extends Backbone.Router

  routes:
    "": "index"
    "history": "history"
    ":id": "sheep"

  index: ->
    @indexView?.destroy()
    @sheepView?.destroy()
    @historyView?.destroy()
    
    @indexView = new SheepTracker.Views.Index()
    @indexView.appendTo("body")

  sheep: (id) ->
    @indexView?.destroy()
    @sheepView?.destroy()
    @historyView?.destroy()

    @model = new SheepTracker.Models.Sheep({id: id})
    @model.fetch(
      {
        error: =>
          window.location = "/"
        success: =>
          @sheepView = new SheepTracker.Views.Sheep({@model})
          @sheepView.appendTo("body")
      }
    )

  history: ->
    @indexView?.destroy()
    @sheepView?.destroy()
    @historyView?.destroy()

    @historyView = new SheepTracker.Views.History()
    @historyView.appendTo("body")