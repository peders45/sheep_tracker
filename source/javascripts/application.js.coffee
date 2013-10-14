#= require ./libs/jquery-2.0.3.min
#= require ./libs/underscore.min.js
#= require ./libs/backbone.min.js
#= require ./libs/handlebars
#= require ./libs/thorax.js
#= require ./libs/moment.min.js
#= require ./libs/spin.min.js
#= require_self
#= require_tree ./helpers
#= require_tree ./models
#= require_tree ./collections
#= require ./views/list_items
#= require ./views/list
#= require ./views/map
#= require_tree ./views

@SheepTracker =
  Views: {}
  Models: {}
  Collections: {}
  templates: {}

$templates = $("[type=\"text/x-handlebars\"]")
for template in $templates
  name = template.getAttribute "data-template"
  SheepTracker.templates[name] = Handlebars.compile template.innerHTML

Backbone.history.start()
