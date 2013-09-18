class SheepTracker.Views.Index extends Thorax.View

  template: SheepTracker.templates.index
  events:
    "click .add-sheep": "showForm"

  initialize: ->
    @listView = new SheepTracker.Views.List()
    @filterBarView = new SheepTracker.Views.FilterBar({delegate: this})

  showForm: ->
    @formView = new SheepTracker.Views.Form({delegate: this})
    @formView.appendTo("body")

  FilterBarDidChangeValue: (value) ->
    @listView.filter(value)

view = new SheepTracker.Views.Index()
view.appendTo("body")