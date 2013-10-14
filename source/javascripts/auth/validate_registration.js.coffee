#= require ../libs/jquery-2.0.3.min
#= require ../libs/spin.min.js

container = document.getElementById "container"
console.log container
registrationCode = window.location.hash.slice(1)
options =
  lines: 12,
  length: 4,
  radius: 15,
  width: 3,
  color: "#888",
  top: 'auto',
  left: 'auto'

spinner = new Spinner(options).spin(container)

validateRegistration = ->
  $.ajax
    type: "get"
    url: "http://localhost:8888/validate_registration/#{registrationCode}"
    success: (data) =>
      window.location = "login.html"
    error: (data) =>
      $(".error-message").addClass("visible")
      spinner.stop()

validateRegistration()