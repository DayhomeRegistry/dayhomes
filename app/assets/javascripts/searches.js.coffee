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

showOnMap = false

@buildMap = (markers) ->
  Gmaps.store = {}
  Gmaps.store.handler = Gmaps.build 'Google'#, { builders: { Marker: RichMarkerBuilder} } #dependency injection
  Gmaps.store.hash = markers

  #then standard use
  Gmaps.store.handler.buildMap { provider: {}, internal: {id: 'map'} }, ->
    isMapDragging = false;
    idleSkipped = false;


    if(!markers.blank?)
      Gmaps.store.markers = Gmaps.store.handler.addMarkers(markers);
      Gmaps.store.handler.bounds.extendWith(Gmaps.store.markers)
      Gmaps.store.handler.fitMapToBounds()

    Gmaps.store.handler.addMarker({
      "lat": Gmaps.store.search_pin.center_latitude, 
      "lng": Gmaps.store.search_pin.center_longitude,
    });
    #This needs to be the search pin
    Gmaps.store.handler.getMap().setCenter(new google.maps.LatLng(Gmaps.store.search_pin.center_latitude, Gmaps.store.search_pin.center_longitude));
    #There needs to be an if here, to determine if we should zoom
    Gmaps.store.handler.getMap().setZoom(Gmaps.store.search_pin.zoom);
    google.maps.event.addListener Gmaps.store.handler.getMap(), 'idle', ->
      if (isMapDragging)
        idleSkipped=true;
        return;
      idleSkipped = false;
      if(!showOnMap)
        _respondToMapChange();
    google.maps.event.addListener Gmaps.store.handler.getMap(), 'dragstart', ->
      if(infowindow)
          infowindow.close()
      isMapDragging = true;
    google.maps.event.addListener Gmaps.store.handler.getMap(), 'dragend', ->
      isMapDragging = false;
      if (idleSkipped==true || showOnMap==true)
        showOnMap=false 
        _respondToMapChange();
        idleSkipped = false;
    google.maps.event.addListener Gmaps.store.handler.getMap(), 'bounds_changed', ->
      idleSkipped = false;

    i=0
    infowindow = new google.maps.InfoWindow();
    while i < Gmaps.store.markers.length
      #google.maps.event.addListener Gmaps.store.markers[i].serviceObject, 'click', ->
      Gmaps.store.markers[i].serviceObject.addListener 'click', ->
        clicked = this;
        index = -1
        i = 0
        len = Gmaps.store.markers.length
        while i < len
          if Gmaps.store.markers[i].serviceObject == clicked
            index = i
            break
          i++
        marker = Gmaps.store.hash[index]
        if(infowindow != null)
          infowindow.close()
        $.ajax 
          url: 'searches/infowindow/'+marker.id
          # data: 
          #   'day_home_id':1
          dataType: 'html'
          async: true
        .done (data, textStatus, jqXHR) ->
          infowindow.setContent(data);
          infowindow.open(Gmaps.store.handler.getMap(), clicked);
        .fail (jqXHR, textStatus, errorThrown) ->
          fail = "fail: "+textStatus;
          #alert(fail);
          return
        return
      ++i
  

isMapDragging = false
idleSkipped = false
currentIndex = 0
pageSize=-1

_getMarkers = (bounds,index) ->
  $.ajax 
      url: 'searches/markers'
      data: 
        'bounds':bounds
        'skip':currentIndex
        'take':pageSize
        'search':$('#advanced-search').serializeJSON()
      dataType: 'json'
      async: true
    .done (data, textStatus, jqXHR) ->
      Gmaps.store.markers = Gmaps.store.handler.addMarkers(data.markers);
      if(index>0 && index<=currentIndex && index<=data.total)
        currentIndex = currentIndex+pageSize;
        _getMarkers(bounds,currentIndex)
      return
    .fail (jqXHR, textStatus, errorThrown) ->
      fail = "fail: "+textStatus;
      #alert(fail);
      return
time = Date.now()
_respondToMapChange = ->
  $('#markers_list').children().remove()
  # Gmaps.store.handler.removeMarkers(Gmaps.store.markers);
  # currentIndex=0
  # bounds=
  #   SW: [Gmaps.store.handler.getMap().getBounds().Ea.k,Gmaps.store.handler.getMap().getBounds().va.j]
  #   NE: [Gmaps.store.handler.getMap().getBounds().Ea.j,Gmaps.store.handler.getMap().getBounds().va.k]
  # _getMarkers(bounds, currentIndex)
  map = Gmaps.store.handler.getMap()
  time = Date.now()
  i=-1
  next = (start_time) ->
    i++
    if(start_time==time && i < Gmaps.store.markers.length)
      if(map.getBounds().contains(Gmaps.store.markers[i].getServiceObject().position))
        #get the tile
        id = Gmaps.store.hash[i].id
        $.ajax 
          url: 'searches/build_dayhome_tile/'+id
          # data: 
          #   'day_home_id':1
          dataType: 'html'
          async: true
        .done (data, textStatus, jqXHR) ->
          $('#markers_list').append(data);
          next(start_time)
        .fail (jqXHR, textStatus, errorThrown) ->
          fail = "fail: "+textStatus;
          #alert(fail);
      else
        next(start_time)
  next(time)
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
    while i < Gmaps.store.markers.length
      railsmarker = Gmaps.store.markers[i]
      if railsmarker.getServiceObject().title and railsmarker.getServiceObject().title.toString().indexOf(slug) >= 0
        showOnMap=true
        google.maps.event.trigger(railsmarker.getServiceObject(), 'click');
        break;
      i++
    $.scrollTo $('#map').position().top - $(window).height() / 2, speed: 'slow'
    false
  

  return

