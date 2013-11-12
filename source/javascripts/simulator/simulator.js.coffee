class SimulatorView extends Thorax.View

  template: Handlebars.compile(document.getElementById("simulator").innerHTML)
  className: "simulator"
  events:
    "change .simulator-list-item-select": "change"

  change: (e) ->
    select = e.currentTarget
    el = select.parentNode
    id = el.getAttribute("data-model-id")
    state = e.currentTarget.value

    model = @collection.get(id)
    model.set({state})

    $.ajax
      type: "GET"
      url: "#{SERVER_URL}/sheep/#{id}/#{state}"
      success: (data) =>
        @render()

  initialize: ->
    @collection = new SheepTracker.Collections.Sheep()
    @collection.fetch()

view = new SimulatorView()
view.appendTo("body")