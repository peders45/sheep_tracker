# Finds all the elements with the type text/x-handlebars
# and loops through them. Uses the data-template attribute
# as the name and combiles the template with Handlebars
# Assigns the compiles template to the SheepTracker object

$templates = $("[type=\"text/x-handlebars\"]")
for template in $templates
  name = template.getAttribute "data-template"
  SheepTracker.templates[name] = Handlebars.compile template.innerHTML
