class SheepTracker.Views.Map extends Thorax.View
  
  className: "sheep-map"
  template: SheepTracker.templates.map

  initialize: ->
    @markers = []
    @markerImage = new google.maps.MarkerImage("/images/sheep@2x.png", null, null, null, new google.maps.Size(40, 38))
    @markerImageAttacked = new google.maps.MarkerImage("/images/sheep_attacked@2x.png", null, null, null, new google.maps.Size(67, 65))
    
    @infowindow = new google.maps.InfoWindow({
      content: SheepTracker.templates.mapInfoWindow()
      maxWidth: 200
    })

    @mapOptions =
      center: new google.maps.LatLng(63.430112, 10.399804)
      mapTypeId: google.maps.MapTypeId.ROADMAP
      zoom: 14
      scrollwheel: false
    
    @map = new google.maps.Map(@el, @mapOptions)
    @addMarkers()
  
  addMarkers: ->
    while @markers.length < 10
      @addMarker()

    @attack(0)
    setTimeout(=>
      @attack(5)
    , 3000)

  addMarker: ->
    lat = 63.434444 - (Math.random() * 0.01)
    lng = 10.36666 + (Math.random() * 0.06)

    marker = new google.maps.Marker({
      position: new google.maps.LatLng(lat, lng)
      map: @map,
      icon: @markerImage,
      draggable: true,
    })

    google.maps.event.addListener(marker, 'click', =>
      @infowindow.open(@map, marker)
    )

    @markers.push(marker)

  attack: (index) ->
    sound = new Audio("/audio/sheep.wav")
    sound.loop = true
    sound.play()
    @$el.addClass "attack"
    @markers[index].setIcon(@markerImageAttacked)
    @markers[index].setAnimation(google.maps.Animation.BOUNCE);