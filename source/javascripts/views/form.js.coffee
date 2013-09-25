class SheepTracker.Views.Form extends Thorax.View

  template: SheepTracker.templates.form
  events:
    "click .modal-close": "destroy",
    "click .modal-overlay": "destroy"
    "submit form": "_onSubmit"

  initialize: ->
    $(document).on("keyup", @_keyup)

  _keyup: (e) =>
    if e.which == 27
      @destroy()

  _onSubmit: (e) =>
    e.preventDefault()
    attributes = @serialize()
    if @collection.create(attributes, {wait: true})
      @destroy()
