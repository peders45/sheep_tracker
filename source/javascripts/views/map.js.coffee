class SheepTracker.Views.Map extends Thorax.View
  
  className: "sheep-map"
  template: SheepTracker.templates.map
  events:
    collection:
      add: "addMarker"
      "change": "attack"
    "click .map-info-button": "click"

  initialize: ->
    @_sounds = {}
    @_markers = {}

  render: ->
    super
    setTimeout(_.bind(@addMap, this), 1)

  addMap: ->
    @markerImage = new google.maps.MarkerImage("images/sheep@2x.png", null, null, null, new google.maps.Size(40, 38))
    @markerImageAttacked = new google.maps.MarkerImage("images/sheep_attacked@2x.png", null, null, null, new google.maps.Size(67, 65))
    @markerImageDead = new google.maps.MarkerImage("images/sheep_dead@2x.png", null, null, null, new google.maps.Size(40, 42))
    @infowindow = new google.maps.InfoWindow({maxWidth: 200})
    
    @map = new google.maps.Map(@el, {
      center: new google.maps.LatLng(63.430112, 10.399804)
      mapTypeId: google.maps.MapTypeId.ROADMAP
      zoom: 14
      scrollwheel: false
    })

    if @model
      @renderModel()

  renderModel: ->
    position = @model.get("position")
    @addMarker(@model)
    @renderRoute()
    @map.setCenter(new google.maps.LatLng(position[0], position[1]))

  addMarker: (model) ->
    position = model.get("position")

    @_markers[model.cid] = marker = new google.maps.Marker({
      position: new google.maps.LatLng(position[0], position[1])
      map: @map,
      icon: @markerImage
    })

    google.maps.event.addListener(marker, 'click', => 
      @openInfoWindow(model)
    )

    @setState(model)

  renderRoute: ->
    positions = @model.get("positions")
    lines = []

    for position, index in positions
      coor = position.position.split(",")
      
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(coor[0], coor[1])
        icon: new google.maps.MarkerImage("images/sheep_position@2x.png", null, null, new google.maps.Point(9, 9), new google.maps.Size(18, 18))
        map: @map
      })

      lines.push(new google.maps.LatLng(coor[0], coor[1]))


    currentPosition = @model.get("position")
    lines.push(new google.maps.LatLng(currentPosition[0], currentPosition[1]))

    line = new google.maps.Polyline({
      path: lines
      strokeColor: "#0090ff"
      strokeOpacity: 1.0
      strokeWeight: 3
    })

    line.setMap(@map)

  openInfoWindow: (model) ->
    content = SheepTracker.templates.mapInfoWindow(model.attributes)
    @infowindow.setContent(content)
    @infowindow.open(@map, @_markers[model.cid])

  setState: (model) ->
    state = model.get("state")

    if state == 1
      @_sounds[model.cid] = sound = @_audioPlayer()
      sound.play()

      if marker = @_markers[model.cid]
        marker.setIcon(@markerImageAttacked)
        marker.setAnimation(google.maps.Animation.BOUNCE)

    else
      if sound = @_sounds[model.cid]
        sound.pause()
        sound.currentTime = 0
        delete @_sounds[model.cid]

      if marker = @_markers[model.cid]
        marker.setIcon(@markerImage)
        marker.setAnimation(null)

    if state == 2
      marker.setIcon(@markerImageDead)

  _audioPlayer: ->
    sound = new Audio("audio/sheep.wav")
    sound.loop = true
    sound

  click: (e) ->
    e.preventDefault()
    id = e.currentTarget.getAttribute("data-model-id")
    window.location.hash = id

  destroy: ->
    for key, sound of @_sounds
      sound.pause()
      sound.currentTime = 0
    super
