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
    when 0 then "#{@name} is healthy" 
    when 1 then "#{@name} is under attack" 
    when 2 then "#{@name} is dead" 
  return message
)

Handlebars.registerHelper("stateName", (state) ->
  message = switch state
    when 0 then "#{@name}" 
    when 1 then "#{@name} is under attack" 
    when 2 then "#{@name} is dead" 
  return message
)

Handlebars.registerHelper("genderLabel", (gender) ->
  message = switch parseInt(gender, 10)
    when 0 then "Male" 
    when 1 then "Female"  
  return message
)

Handlebars.registerHelper("isHealthy", (state) ->
  if parseInt(state, 10) == 0 then "selected" else ""
)

Handlebars.registerHelper("isUnderAttack", (state) ->
  if parseInt(state, 10) == 1 then "selected" else ""
)

Handlebars.registerHelper("isDead", (state) ->
  if parseInt(state, 10) == 2 then "selected" else ""
)