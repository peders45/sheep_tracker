#= require ../libs/jquery-2.0.3.min
#= require ../libs/spin.min.js
#= require ../config.js

# Options for the spinner object
# created with the Spin.js library
container = document.getElementById "container"
options =
  lines: 12,
  length: 4,
  radius: 15,
  width: 3,
  color: "#888",
  top: 'auto',
  left: 'auto'

# Create a new instance of the Spinner
# object and append it to the container element
new Spinner(options).spin(container)

# Send an Ajax request to validate if the user
# is logged in. If logged in redirect to the 
# sheep view. If not logged in redirect to the 
# login view
validateUser = ->
  $.ajax
    type: "get"
    url: "#{SERVER_URL}/validate"
    success: (data) =>
      window.location = "sheep.html"
    error: (data) =>
      window.location = "login.html"

# Validate the user. This will be called
# each time the user is sent to index.html
validateUser()