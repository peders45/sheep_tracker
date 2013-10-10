#= require ../libs/jquery-2.0.3.min
#= require ../libs/spin.min.js

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
    url: "http://localhost:8888/validate"
    success: (data) =>
      window.location = "sheep.html"
    error: (data) =>
      window.location = "login.html"

validateUser()