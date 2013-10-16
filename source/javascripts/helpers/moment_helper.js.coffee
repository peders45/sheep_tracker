Handlebars.registerHelper("humanizeYears", (date) ->
  age = moment(new Date()).diff(moment(date),'years')
  if age > 1 then "#{age} years" else "#{age} year"
)