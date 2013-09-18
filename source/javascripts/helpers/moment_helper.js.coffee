Handlebars.registerHelper("humanizeYears", (date) ->
  moment.duration(date, "years").humanize()
)