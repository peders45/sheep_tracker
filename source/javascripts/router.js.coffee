# Defines a new Router. The Router defines
# which methods to get called based on the
# URL the user enters. This allow the user to
# navigate around the app without reloading the page
class @SheepTracker.Router extends Backbone.Router

  # Defines which URLs that corresponds to which methods
  routes:
    "": "index"
    "history": "history"
    "invite": "invite"
    ":id": "sheep"

  initialize: ->
    # Creates a new collection of sheep and fetches all
    # of them. This is where all sheep on the entire app
    # is store and synced
    @collection = new SheepTracker.Collections.Sheep()
    @collection.fetch(
      {
        # Checks if the user is Unauthorized and 
        # redirect to the login page
        error: (data, request) ->
          if request.status == 403
            window.location = "login.html"
      }
    )

  index: ->
    @reset()

    # Create a new Index view and append 
    # the element the body. Passes in a reference 
    # to the collection
    @indexView = new SheepTracker.Views.Index({@collection})
    @indexView.appendTo("body")

  sheep: (id) ->
    @reset()

    # Create a new model based on the ID form the 
    # URL and fetches the data from the server
    @model = new SheepTracker.Models.Sheep({@collection, id: id})
    @model.fetch(
      {
        error: =>
          # If the server returns an error we create
          # a new Sheep Missing view. Passes in a reference 
          # to the collection
          @sheepMissingView = new SheepTracker.Views.SheepMissing({@collection})
          @sheepMissingView.appendTo("body")
        success: =>
          # Create a new Sheep view and append 
          # the element the body. Passes in a reference 
          # to the collection
          @sheepView = new SheepTracker.Views.Sheep({@collection, @model})
          @sheepView.appendTo("body")
      }
    )

  history: ->
    @reset()

    # Create a new History view and append 
    # the element the body. Passes in a reference 
    # to the collection
    @historyView = new SheepTracker.Views.History({@collection})
    @historyView.appendTo("body")

  invite: ->
    @reset()

    # Create a new History view and append 
    # the element the body. Passes in a reference 
    # to the collection
    @inviteView = new SheepTracker.Views.Invite({@collection})
    @inviteView.appendTo("body")

  reset: ->
    # Destroys all instances of the views 
    # if they exists
    @indexView?.destroy()
    @sheepView?.destroy()
    @sheepMissingView?.destroy()
    @historyView?.destroy()
    @inviteView?.destroy()