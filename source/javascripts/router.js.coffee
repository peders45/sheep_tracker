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