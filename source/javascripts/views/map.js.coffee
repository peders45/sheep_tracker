class SheepTracker.Views.Map extends Thorax.View
  
  className: "sheep-map"
  template: SheepTracker.templates.map
  events:
    "click .map-info-button": "click"
    collection:
      add: "addMarker"
      change: "attack"

  initialize: ->
    @_sounds = {}
    @_markers = {}

    # Hack to get around bug in Google Maps 
    # https://code.google.com/p/gmaps-api-issues/issues/detail?id=1448
    setTimeout(_.bind(@addMap, this), 1)

  addMap: ->
    @mapCenter = new google.maps.LatLng(63.430112, 10.399804)
    @infowindow = new google.maps.InfoWindow({maxWidth: 200})
    @images = 
      default:  @markerImage("sheep@2x.png", 40, 38, 20, 20)
      attacked: @markerImage("sheep_attacked@2x.png", 67, 65, 20, 20)
      dead:     @markerImage("sheep_dead@2x.png", 40, 42, 20, 20)

    @map = new google.maps.Map(@el, {
      center: @mapCenter
      mapTypeId: google.maps.MapTypeId.ROADMAP
      zoom: 14
      scrollwheel: false
    })

    if @model
      @renderModel()

  renderModel: ->
    position = @model.get("position")
    @mapCenter = new google.maps.LatLng(position[0], position[1])
    @addMarker(@model)
    @renderRoute()
    @map.setCenter(@mapCenter)

  addMarker: (model) ->
    # Hack to get around bug in Google Maps 
    # https://code.google.com/p/gmaps-api-issues/issues/detail?id=1448
    setTimeout(=>
      position = model.get("position")

      @_markers[model.cid] = marker = new google.maps.Marker({
        position: new google.maps.LatLng(position[0], position[1])
        map: @map,
        icon: @images.default
      })

      google.maps.event.addListener(marker, 'click', => 
        @openInfoWindow(model)
      )

      @setState(model)
    , 1)

  markerImage: (image, width, height, offsetWidth=0, offsetHeight=0) ->
    position = new google.maps.Size(width, height)
    offset = new google.maps.Point(offsetWidth, offsetHeight)
    new google.maps.MarkerImage("images/#{image}", null, null, offset, position)

  renderRoute: ->
    positions = @model.get("positions")
    lines = []

    for position, index in positions
      coor = position.position.split(",")
      
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(coor[0], coor[1])
        icon: @markerImage("sheep_position@2x.png", 18, 18, 9, 9)
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
        marker.setIcon(@images.attacked)
        marker.setAnimation(google.maps.Animation.BOUNCE)

    else
      if sound = @_sounds[model.cid]
        sound.pause()
        sound.currentTime = 0
        delete @_sounds[model.cid]

      if marker = @_markers[model.cid]
        marker.setIcon(@images.default)
        marker.setAnimation(null)

    if state == 2
      marker.setIcon(@images.dead)

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
