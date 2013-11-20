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
    # Bind event on keyup on the documennt
    $(document).on("keyup", @_keyup)

  _datepickerFocus: (e) =>
    # Get the parentNode of the input element
    el = e.currentTarget.parentNode
    
    # Show the datepicker if it already exists
    if @datepicker
      @datepicker.show()
    else
      # Create a new instance of the datepicker and
      # bind event on the select event
      @datepicker = new SheepTracker.Views.Datepicker()
      @datepicker.on("select", @_datepickerSelect)

      # Get the birthday input and append the calendar view
      @datepickerInput = document.getElementById("birthday")
      el.appendChild(@datepicker.el)

    # Select the date in the calendar if the
    # input value is a valid date
    if date = moment(@datepickerInput.value)
      @datepicker.select(date)

  _datepickerBlur: (e) =>
    # Hide the calendar on input blur
    @datepicker?.hide()

  _datepickerSelect: (date, options) =>
    # Select the day in the calendar that matches
    # the input value
    @datepickerInput.value = date._i

  _keyup: (e) =>
    # Check if the key pressed is ESC and
    # destroy the form view
    if e.which == 27
      @destroy()

  _submit: (e) =>
    e.preventDefault()

    # Serializes the data in the form into an object
    attributes = @serialize()

    # Check if a model was to the view and save the updated
    # attributes. This will sync the changes with the server
    @model?.save(attributes, 
      {
        # Wait to render the changes until the server responds
        wait: true
        # If the server returns a HTTP 200 response 
        success: (model, response) =>
          # Create a new success messages and tells the delegate
          # class to show the success notification 
          message = notifications.edited.replace("%s", model.get("name"))
          @delegate?.NotificationDidAppear?(message, "success")
        # If the server returns a HTTP error
        error: (model, response) =>
          # Create a new error message and tells the delegate
          # class to show the error notification
          message = notifications.editedError.replace("%s", attributes.name)
          @delegate?.NotificationDidAppear?(message, "error")
      }
    )

    # If not model was passed the view 
    # and the sheep collection exists
    unless @model
      # Create a new model in the collection with the 
      # attributes in the form inputs
      @collection?.create(attributes,
        {
          # Wait to render the changes until the server responds
          wait: true
          # Display success and error messages
          success: (model, response) =>
            message = notifications.created.replace("%s", attributes.name)
            @delegate?.NotificationDidAppear?(message, "success")
          error: (model, response) =>
            message = notifications.createdError.replace("%s", attributes.name)
            @delegate?.NotificationDidAppear?(message, "error")
        }
      )

    # Destroy the view after the form was submitted
    @destroy()

  _cancel: (e) =>
    e.preventDefault()

    # Detroy the view if the user clicks the cancel button
    @destroy()