class SheepTracker.Views.Index extends Thorax.View

  template: SheepTracker.templates.index

  initialize: ->
    @listView = new SheepTracker.Views.List()
    @filterBarView = new SheepTracker.Views.FilterBar({delegate: this})

  FilterBarDidChangeValue: (value) ->
    @listView.filter(value)

view = new SheepTracker.Views.Index()
view.appendTo("body")