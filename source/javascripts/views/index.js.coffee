class SheepTracker.Views.Index extends Thorax.View

  className: "index"
  template: SheepTracker.templates.index
  events:
    "click .add-sheep": "showForm"

  initialize: ->
    @mapView = new SheepTracker.Views.Map()
    @listView = new SheepTracker.Views.List()
    @filterBarView = new SheepTracker.Views.FilterBar({delegate: this})

  showForm: (e) ->
    @formView = new SheepTracker.Views.Form({delegate: this})
    @formView.appendTo("body")
    return false

  FilterBarDidChangeValue: (value) ->
    @listView.filter(value)
    $("body").toggleClass("map", value.length == 0)
  

view = new SheepTracker.Views.Index()
view.appendTo("body")