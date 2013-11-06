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

Handlebars.registerHelper("stateClass", (state) ->
  classname = switch state
    when 0 then "normal" 
    when 1 then "attack" 
    when 2 then "dead" 
  return classname
)

Handlebars.registerHelper("stateMessage", (state) ->
  message = switch state
    when 0 then "Daisy is healthy!" 
    when 1 then "Daisy is under attack!" 
    when 2 then "Daisy is dead." 
  return message
)