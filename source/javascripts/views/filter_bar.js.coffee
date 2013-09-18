class SheepTracker.Views.FilterBar extends Thorax.View

  className: "filter-bar"
  template: SheepTracker.templates.filterBar
  events:
    "keyup .filter-bar-input": "_keyup"

  _keyup: (e) ->
    query = e.currentTarget.value
    @delegate?.FilterBarDidChangeValue?(query)
