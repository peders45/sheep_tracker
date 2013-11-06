$templates = $("[type=\"text/x-handlebars\"]")
for template in $templates
  name = template.getAttribute "data-template"
  SheepTracker.templates[name] = Handlebars.compile template.innerHTML
