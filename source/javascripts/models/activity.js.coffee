class SheepTracker.Models.Activity extends Thorax.Model

  defaults: ->
    return {
      event: null
      sheep: null
      farm: null
      time: new Date()
    }
