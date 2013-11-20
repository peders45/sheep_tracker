class SheepTracker.Views.FilterBar extends Thorax.View

  className: "filter-bar"
  template: SheepTracker.templates.filterBar

  # Bind event on keypress in the filter bare input
  events:
    "keypress .filter-bar-input": "search"

  search: (e) ->
    # Check if the user press enter
    if e.which == 13
      
      # Get the value from the input
      query = e.currentTarget.value
      
      # Call the delegate method FilterBarDidChangeValue
      # and passes in the query string
      @delegate?.FilterBarDidChangeValue?(query)