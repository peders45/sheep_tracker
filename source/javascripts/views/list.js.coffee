class SheepTracker.Views.List extends Thorax.View

  template: SheepTracker.templates.list

  initialize: ->
    @collection = new SheepTracker.Collections.Sheep()
    @collection.fetch()

view = new SheepTracker.Views.List()
view.appendTo(document.getElementById("sheep"))