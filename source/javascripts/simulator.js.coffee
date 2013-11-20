#= require ./libs/jquery-2.0.3.min
#= require ./libs/underscore.min.js
#= require ./libs/backbone.min.js
#= require ./libs/handlebars
#= require ./libs/thorax.js
#= require ./libs/moment.min.js
#= require ./libs/spin.min.js
#= require ./config.js
#= require_self
#= require_tree ./helpers
#= require_tree ./models
#= require_tree ./collections
#= require ./simulator/simulator

# Defines a global object SheepTracker
# that contains references to all the views,
# models, collections, routes and templates
@SheepTracker =
  Views: {}
  Models: {}
  Collections: {}
  Router: {}
  templates: {}

# Start the Backbone.history so that the
# History Push State API get initiated
Backbone.history.start()