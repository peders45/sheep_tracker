class SheepTracker.Views.Invite extends Thorax.View

  className: "sheep"
  template: SheepTracker.templates.invite
  events:
    "submit form": "_onSubmit"

  initialize: ->
    @headerView = new SheepTracker.Views.Header({@collection, delegate: this})
    @notificationsView = new SheepTracker.Views.Notifications()

  _onSubmit: (e) ->
    e.preventDefault()
    attributes = @serialize()

    $.ajax
      type: "post"
      url: "#{SERVER_URL}/invite"
      data: attributes
      success: (data) =>
        @showMessage(data)
      error: (data) =>
        @showError(data.statusText)

  showError: (data) ->
    @$el.find(".error-message").html(data).addClass("visible")

  showMessage: (data) ->
    @$el.find(".success-message").html(data).addClass("visible")

  NotificationDidAppear: (message, type) ->
    @notificationsView.add(message, type)