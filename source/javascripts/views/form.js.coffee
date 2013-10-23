#= require ../views/datepicker 

class SheepTracker.Views.Form extends Thorax.View

  template: SheepTracker.templates.form
  events:
    "click .modal-close": "destroy"
    "click .modal-overlay": "destroy"
    "submit form": "_submit"
    "click .sheep-form-cancel": "_cancel"
    "focus .sheep-form-birthday": "_datepickerFocus"
    "blur .sheep-form-birthday": "_datepickerBlur"

  initialize: ->
    $(document).on("keyup", @_keyup)

  render: ->
    super

  _datepickerFocus: (e) =>
    el = e.currentTarget.parentNode
    
    if @datepicker
      @datepicker.show()
    else
      @datepicker = new SheepTracker.Views.Datepicker()
      @datepicker.on("select", @_datepickerSelect)
      @datepickerInput = document.getElementById("birthday")
      el.appendChild(@datepicker.el)

    if date = new Date(@datepickerInput.value)
      @datepicker.select(date)

  _datepickerBlur: (e) =>
    @datepicker?.hide()

  _datepickerSelect: (date, options) =>
    @datepickerInput.value = date._i

  _keyup: (e) =>
    if e.which == 27
      @destroy()

  _submit: (e) =>
    e.preventDefault()
    attributes = @serialize()

    if @model?.set(attributes)
      @model.save()
      @destroy()
      message = notifications.edited.replace("%s", @model.get("name"))
      @delegate?.NotificationDidAppear?(message, "success")

    if @collection?.create(attributes, {wait: true})
      @destroy()
      message = notifications.created.replace("%s", attributes.name)
      @delegate?.NotificationDidAppear?(message, "success")

  _cancel: (e) =>
    e.preventDefault()
    @destroy()