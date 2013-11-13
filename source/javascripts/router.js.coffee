class @SheepTracker.Router extends Backbone.Router

  routes:
    "": "index"
    "history": "history"
    "invite": "invite"
    ":id": "sheep"

  initialize: ->
    @collection = new SheepTracker.Collections.Sheep()
    @collection.fetch(
      {
        error: (data, request) ->
          if request.status == 403
            window.location = "login.html"
      }
    )

  index: ->
    @reset()
    @indexView = new SheepTracker.Views.Index({@collection})
    @indexView.appendTo("body")

  sheep: (id) ->
    @reset()
    @model = new SheepTracker.Models.Sheep({@collection, id: id})
    @model.fetch(
      {
        error: =>
          @sheepMissingView = new SheepTracker.Views.SheepMissing({@collection})
          @sheepMissingView.appendTo("body")
        success: =>
          @sheepView = new SheepTracker.Views.Sheep({@collection, @model})
          @sheepView.appendTo("body")
      }
    )

  history: ->
    @reset()
    @historyView = new SheepTracker.Views.History({@collection})
    @historyView.appendTo("body")

  invite: ->
    @reset()
    @inviteView = new SheepTracker.Views.Invite({@collection})
    @inviteView.appendTo("body")

  reset: ->
    @indexView?.destroy()
    @sheepView?.destroy()
    @sheepMissingView?.destroy()
    @historyView?.destroy()
    @inviteView?.destroy()