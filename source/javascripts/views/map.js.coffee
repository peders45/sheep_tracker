class SheepTracker.Views.Map extends Thorax.View
  
  className: "sheep-map"
  template: SheepTracker.templates.map
  events:
    collection:
      add: "addMarker"
      "change:attack": "attack"

  initialize: ->
    @addMap()
    @_sounds = {}
    @_markers = {}

  addMap: ->
    @markerImage = new google.maps.MarkerImage("/images/sheep@2x.png", null, null, null, new google.maps.Size(40, 38))
    @markerImageAttacked = new google.maps.MarkerImage("/images/sheep_attacked@2x.png", null, null, null, new google.maps.Size(67, 65))
    @infowindow = new google.maps.InfoWindow({maxWidth: 200})
    
    @map = new google.maps.Map(@el, {
      center: new google.maps.LatLng(63.430112, 10.399804)
      mapTypeId: google.maps.MapTypeId.ROADMAP
      zoom: 14
      scrollwheel: false
    })

  addMarker: (model) =>
    @_markers[model.cid] = marker = new google.maps.Marker({
      position: new google.maps.LatLng(model.attributes.coordinates.x, model.attributes.coordinates.y)
      map: @map,
      icon: @markerImage,
      draggable: true
    })

    google.maps.event.addListener(marker, 'click', => 
      @openInfoWindow(model)
    )

  openInfoWindow: (model) ->
    content = SheepTracker.templates.mapInfoWindow(model.attributes)
    @infowindow.setContent(content)
    @infowindow.open(@map, @_markers[model.cid])

  attack: (model, attack, options) ->
    if attack
      @_sounds[model.cid] = sound = @_audioPlayer()
      sound.play()

      if marker = @_markers[model.cid]
        marker.setIcon(@markerImageAttacked)
        marker.setAnimation(google.maps.Animation.BOUNCE)

    else
      if sound = @_sounds[model.cid]
        sound.stop()
        delete @_sounds[model.cid]

      if marker = @_markers[model.cid]
        marker.setIcon(@markerImage)
        marker.setAnimation(null)

  _audioPlayer: ->
    sound = new Audio("/audio/sheep.wav")
    sound.loop = true
    sound

