# Defines a new model for activities
class SheepTracker.Models.Activity extends Thorax.Model

  # Set the default data structure
  defaults: ->
    return {
      event: null
      sheep: null
      farm: null
      time: new Date()
    }
