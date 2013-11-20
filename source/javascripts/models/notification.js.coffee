# Defines a new model for notifications
class SheepTracker.Models.Notification extends Thorax.Model

  # Set the default data structure
  defaults: ->
    return {
      type: null
      message: null
    }
