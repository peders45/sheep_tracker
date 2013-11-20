class SimulatorView extends Thorax.View

  # Find and compile the simulator template,
  # set the classname of the the view 
  # and bind events on click and change
  template: Handlebars.compile(document.getElementById("simulator").innerHTML)
  className: "simulator"
  events:
    "change .simulator-list-item-select": "change"
    "click .simulator-button": "click"

  # Gets fired when the user changes the 
  # value of a dropdown 
  change: (e) ->
    # Get the select element that the user updated
    # and saves the parent element, id and state
    select = e.currentTarget
    el = select.parentNode
    id = el.getAttribute("data-model-id")
    state = e.currentTarget.value

    # Find the model in the collection based on
    # the id and updates the state 
    model = @collection.get(id)
    model.set({state})

    # Send an Ajax request to update the state
    # and re-render the view on success
    $.ajax
      type: "GET"
      url: "#{SERVER_URL}/sheep/#{id}/#{state}"
      success: (data) =>
        @render()

  initialize: ->
    # Creates a new collection and fetches
    # all the sheep models
    @collection = new SheepTracker.Collections.Sheep()
    @collection.fetch()

  # Gets fired when the user clicks the simulate button
  click: (e) ->
    e.preventDefault()

    # Create a jQuery object of the button
    # and append a class name ot animate
    $el = $ e.currentTarget
    $el.addClass("animate")

    # Send an Ajax request to initiate the simulation
    $.ajax
      type: "GET"
      url: "#{SERVER_URL}/simulate/"

    # Remove the classname when the animation is
    # complete to allow for it to animate multiple times
    setTimeout(=>
      $el.removeClass("animate")
    , 800)

# Create a new instance of the view 
# and appends it to the body
view = new SimulatorView()
view.appendTo("body")