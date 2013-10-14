#= require ../libs/jquery-2.0.3.min
#= require ../libs/spin.min.js
#= require ../config.js

container = document.getElementById "container"
options =
  lines: 12,
  length: 4,
  radius: 15,
  width: 3,
  color: "#888",
  top: 'auto',
  left: 'auto'

new Spinner(options).spin(container)

validateUser = ->
  $.ajax
    type: "get"
    url: "#{SERVER_URL}/validate"
    success: (data) =>
      window.location = "sheep.html"
    error: (data) =>
      window.location = "login.html"

validateUser()