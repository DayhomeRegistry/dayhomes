class RichMarkerBuilder extends Gmaps.Google.Builders.Marker #inherit from builtin builder
  # #override create_marker method
  # create_marker: ->
  #   options = _.extend @marker_options(), @rich_marker_options()
  #   @serviceObject = new RichMarker options #assign marker to @serviceObject

  # rich_marker_options: ->
  #   marker = document.createElement("div")
  #   marker.setAttribute 'class', 'marker_container'
  #   marker.innerHTML = @args.picture
  #   { content: marker }

  # override method
  # create_infowindow: ->
  #   return null unless _.isString @args.infowindow

  #   boxText = document.createElement("div")
  #   boxText.setAttribute("class", 'dayhome_bubble') #to customize
  #   boxText.
  #   boxText.innerHTML = @args.infowindow
  #   @infowindow = new InfoBox(@infobox(boxText))

  #   # add @bind_infowindow() for < 2.1

  # infobox: (boxText)->
  #   content: boxText
  #   pixelOffset: new google.maps.Size(-140, 0)
  #   boxStyle:
  #     width: "280px"

@buildMap = (markers) ->
  window.handler = Gmaps.build 'Google'#, { builders: { Marker: RichMarkerBuilder} } #dependency injection

  #then standard use
  window.handler.buildMap { provider: {}, internal: {id: 'map'} }, ->
    isMapDragging = false;
    idleSkipped = false;
    currentInfo = null;

    window.markers = window.handler.addMarkers(markers)
    window.handler.bounds.extendWith(window.markers)
    window.handler.fitMapToBounds()
    google.maps.event.addListener window.handler.getMap(), 'idle', ->
      if (isMapDragging)
        idleSkipped=true;
        return;
      idleSkipped = false;
      _respondToMapChange();
    google.maps.event.addListener window.handler.getMap(), 'dragstart', ->
      isMapDragging = true;
    google.maps.event.addListener window.handler.getMap(), 'dragend', ->
      isMapDragging = false;
      if (idleSkipped==true) 
        _respondToMapChange();
        idleSkipped = false;
    google.maps.event.addListener window.handler.getMap(), 'bounds_changed', ->
      idleSkipped = false;
