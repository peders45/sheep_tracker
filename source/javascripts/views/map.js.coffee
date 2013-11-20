class SheepTracker.Views.Map extends Thorax.View
  
  className: "sheep-map"
  template: SheepTracker.templates.map
  events:
    "click .map-info-button": "click"
    collection:
      # Bind event on when a model gets added to 
      # a collection and adds a marker
      add: "addMarker"

  initialize: ->
    # Creates empty object to contain markers and sounds
    @_sounds = {}
    @_markers = {}

    # Hack to get around bug in Google Maps 
    # https://code.google.com/p/gmaps-api-issues/issues/detail?id=1448
    setTimeout(_.bind(@addMap, this), 1)

  addMap: ->
    # Set the center of the map
    @mapCenter = new google.maps.LatLng(63.423604, 10.298174)

    # Creates a new info view
    @infowindow = new google.maps.InfoWindow({maxWidth: 200})

    # Define custom markers for each of the sheep states
    @images = 
      default:  @markerImage("sheep@2x.png", 40, 38, 20, 20)
      attacked: @markerImage("sheep_attacked@2x.png", 67, 65, 20, 20)
      dead:     @markerImage("sheep_dead@2x.png", 40, 42, 20, 20)

    # Create a new map in the view element
    # with the ROADMAP type and zoom level 14
    @map = new google.maps.Map(@el, {
      center: @mapCenter
      mapTypeId: google.maps.MapTypeId.ROADMAP
      zoom: 14
      scrollwheel: false
    })

    # Render a marker if a model was passed
    if @model
      @renderModel()

  renderModel: ->
    # Get the current position of the model
    position = @model.get("position")
    # Set the position to be the map center to center the sheep
    @mapCenter = new google.maps.LatLng(position[0], position[1])

    # Add the marker for the model
    @addMarker(@model)

    # Renders a route with the last 5 sheep positions
    @renderRoute()

    # Set the map center 
    @map.setCenter(@mapCenter)

  addMarker: (model) ->
    # Hack to get around bug in Google Maps 
    # https://code.google.com/p/gmaps-api-issues/issues/detail?id=1448
    setTimeout(=>

      # Get the position of the model
      position = model.get("position")

      # Create a new marker on the models posotion 
      # and append it to the markers object 
      @_markers[model.cid] = marker = new google.maps.Marker({
        position: new google.maps.LatLng(position[0], position[1])
        map: @map,
        icon: @images.default
      })

      # Show the info window if the user clicks the marker
      google.maps.event.addListener(marker, 'click', => 
        @openInfoWindow(model)
      )

      # Set the state of the marker to update the marker image
      @setState(model)

    , 1)

  markerImage: (image, width, height, offsetWidth=0, offsetHeight=0) ->
    # Create a new marker image 
    position = new google.maps.Size(width, height)
    offset = new google.maps.Point(offsetWidth, offsetHeight)
    new google.maps.MarkerImage("images/#{image}", null, null, offset, position)

  renderRoute: ->
    # Get the previous positions of the model
    positions = @model.get("positions")
    lines = []

    # Loop through all positions and draw a line between
    # each point
    for position, index in positions
      coor = position.position.split(",")
      
      # Create a marker for each position
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(coor[0], coor[1])
        icon: @markerImage("sheep_position@2x.png", 18, 18, 9, 9)
        map: @map
      })

      # Append the point to the lines array
      lines.push(new google.maps.LatLng(coor[0], coor[1]))

    # Get the current position of the model and append
    # it to the lines array
    currentPosition = @model.get("position")
    lines.push(new google.maps.LatLng(currentPosition[0], currentPosition[1]))

    # Create a new line between all of the previous points
    line = new google.maps.Polyline({
      path: lines
      strokeColor: "#0090ff"
      strokeOpacity: 1.0
      strokeWeight: 3
    })

    # App the line to the map
    line.setMap(@map)

  openInfoWindow: (model) ->
    # Set the content for the info window nad 
    # append show it on the map
    content = SheepTracker.templates.mapInfoWindow(model.attributes)
    @infowindow.setContent(content)
    @infowindow.open(@map, @_markers[model.cid])

  setState: (model) ->
    # Get the state of the model
    state = model.get("state")

    # If the sheep is under attack
    if state == 1
      # Create a new audio element and play it
      @_sounds[model.cid] = sound = @_audioPlayer()
      sound.play()

      # Get the marker based on the mode id and 
      # set the marker image to attacked and add 
      # a bounce animation
      if marker = @_markers[model.cid]
        marker.setIcon(@images.attacked)
        marker.setAnimation(google.maps.Animation.BOUNCE)

    # If the sheep is healthy or dead
    else
      # Remove the sound 
      if sound = @_sounds[model.cid]
        sound.pause()
        sound.currentTime = 0
        delete @_sounds[model.cid]

      # Set the marker to the default image and
      # remove the bounce animation
      if marker = @_markers[model.cid]
        marker.setIcon(@images.default)
        marker.setAnimation(null)

    # If the sheep is dead set the icon
    # to the dead marker image
    if state == 2
      marker.setIcon(@images.dead)

  _audioPlayer: ->
    # Create a new audio element with the sheep sound
    sound = new Audio("audio/sheep.wav")
    sound.loop = true
    sound.volume = 0.2
    sound

  click: (e) ->
    e.preventDefault()
    # Get the model id based on the data-model-id
    id = e.currentTarget.getAttribute("data-model-id")

    # Redirect to the sheep view with the id
    window.location.hash = id

  destroy: ->
    # Stop all sounds from playing when the view 
    # is destroyed
    for key, sound of @_sounds
      sound.pause()
      sound.currentTime = 0
    super
