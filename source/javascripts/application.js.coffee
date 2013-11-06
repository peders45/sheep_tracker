#= require ./libs/jquery-2.0.3.min
#= require ./libs/underscore.min.js
#= require ./libs/backbone.min.js
#= require ./libs/handlebars
#= require ./libs/thorax.js
#= require ./libs/moment.min.js
#= require ./libs/spin.min.js
#= require ./config.js
#= require_self
#= require ./router.js
#= require_tree ./helpers
#= require_tree ./models
#= require_tree ./collections
#= require ./views/list_items
#= require ./views/list
#= require ./views/map
#= require ./views/notifications
#= require_tree ./views
#= require ./init.js

@SheepTracker =
  Views: {}
  Models: {}
  Collections: {}
  Router: {}
  templates: {}