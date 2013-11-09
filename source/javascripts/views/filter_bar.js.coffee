class SheepTracker.Views.FilterBar extends Thorax.View

  className: "filter-bar"
  template: SheepTracker.templates.filterBar
  events:
    "keypress .filter-bar-input": "search"

  search: (e) ->
    if e.which == 13
      query = e.currentTarget.value
      @delegate?.FilterBarDidChangeValue?(query)
