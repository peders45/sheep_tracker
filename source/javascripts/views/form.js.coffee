class SheepTracker.Views.Form extends Thorax.View

  template: SheepTracker.templates.form
  events:
    "click .modal-close": "destroy",
    "click .modal-overlay": "destroy"

  initialize: ->
    $(document).on("keyup", @_keyup)

  _keyup: (e) =>
    if e.which == 27
      @destroy()
