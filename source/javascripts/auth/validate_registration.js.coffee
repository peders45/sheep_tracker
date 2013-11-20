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
spinner = new Spinner(options).spin(container)

# Get the registration code passed by the
# server in the URL
registrationCode = window.location.hash.slice(1)

# Send an Ajax request to validate the registration
# process. Redirect the user to the index page
# if it successfully validated. Display an error 
# message if not
validateRegistration = ->
  $.ajax
    type: "get"
    url: "#{SERVER_URL}/validate_registration/#{registrationCode}"
    success: (data) =>
      window.location = "login.html"
    error: (data) =>
      $(".error-message").addClass("visible")
      spinner.stop()

# Validate the registration. This will be called when 
# the user open the registration link from the email 
validateRegistration()