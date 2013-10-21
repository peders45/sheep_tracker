Handlebars.registerHelper("humanizeYears", (date) ->
  age = moment(new Date()).diff(moment(date),'years')
  if age > 1 then "#{age} years" else "#{age} year"
)

Handlebars.registerHelper("formatDate", (date) ->
  moment(date).format("MM/DD/YYYY")
)

Handlebars.registerHelper("maleIsChecked", (gender) ->
  if gender == 0 then "checked" else ""
)

Handlebars.registerHelper("femaleIsChecked", (gender) ->
  if gender == 1 then "checked" else ""
)