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
    #This needs to be the search pin
    window.handler.getMap().setCenter(new google.maps.LatLng(window.search_pin.center_latitude, window.search_pin.center_longitude));
    #There needs to be an if here, to determine if we should zoom
    window.handler.getMap().setZoom(window.search_pin.zoom);
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

isMapDragging = false
idleSkipped = false
currentInfo = null

_respondToMapChange = ->
  $('#markers_list').children().remove()
  j = 0
  lasti = -1
  lastj = -1
  i = 0
  setTimeout (->
    while i < window.markers.length
      if window.handler.getMap().getBounds().contains(new (google.maps.LatLng)(window.markers[i].serviceObject.position.lat(), window.markers[i].serviceObject.position.lng()))
        $.ajax 
          url: 'searches/build_dayhome_tile'
          data: 'id': window.markers[i].serviceObject.title
          dataType: 'html'
          async: true
        .done (data, textStatus, jqXHR) ->
          $('#markers_list').append(data);
          return
        .fail (jqXHR, textStatus, errorThrown) ->
          #alert("fail: "+textStatus);
          return
      #   m = $(window.markers[i].serviceObject.title)
      #   m.click ->
      #     window.handler.getMap().setZoom 4
      #     window.handler.getMap().setCenter window.markers[i].getPosition()
      #     return
      #   $('#markers_list').append m
      #   j++
      # if lasti != i and lastj != j and j > 0 and j % 5 == 0
      #   $('#markers_list').append '<div class=\'dayhome_listing\'><ins class=\'adsbygoogle\' style=\'display:inline-block;width:234px;height:60px\' data-ad-client=\'ca-pub-6835867491393885\' data-ad-slot=\'3925033656\'></ins></div'
      #   lasti = i
      #   lastj = j
      i++
  ),0
  return

$(document).ready ->
  $(document).on 'click', '#showSearchLink', ->
    $('#showSearch').toggle()
    $('#hideSearch').toggle()
    return
  $(document).on 'click', '#hideSearchLink', ->
    $('#showSearch').toggle()
    $('#hideSearch').toggle()
    return
  #Add the center of the search?
  $(document).on 'click', '.markerCallout', ->
    slug = $(this).attr('id')
    i = 0
    while i < markers.length
      railsmarker = markers[i]
      #var marker = new google.maps.Marker({
      #  position: new google.maps.LatLng(railsmarker.lat,railsmarker.lng),
      # map: Gmaps.map.map              
      #});
      if railsmarker.getServiceObject().title and railsmarker.getServiceObject().title.toString().indexOf(slug) > 0
        if currentInfo != null
          currentInfo.serviceObject.setIcon '/assets/dayhome.png'
          currentInfo['infowindow'].close()
        currentInfo = railsmarker
        try
          railsmarker['infowindow'].open handler.map, railsmarker.serviceObject
          if railsmarker.picture.indexOf('-featured') > 0
            railsmarker.serviceObject.setIcon '/assets/dayhome-red-featured.png'
          else
            railsmarker.serviceObject.setIcon '/assets/dayhome-red.png'
        catch err
          #wish I knew how to tell someone
        window.handler.getMap().setZoom 7
        window.handler.getMap().setCenter railsmarker.serviceObject.position
      i++
    $.scrollTo $('#map').position().top - $(window).height() / 2, speed: 'slow'
    false
  return

