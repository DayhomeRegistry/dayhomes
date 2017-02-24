
var markers = [];
var map;
var _getMarkers = function(bounds) {
  return $.ajax({
    url: '/find/markers',
    data: {
      'bounds': bounds,
      'search': $('#advanced-search').serializeJSON()
    },
    dataType: 'json',
    async: true
  }).success(function(data, textStatus, jqXHR) {
    _getFeatured(bounds);
    if(data.markers.length==0){
    	$('#details').empty();
  		$('#details').append('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> Loading...');
    	map.setZoom(map.getZoom()-4);
    }
    else
    	updateMarkers(map,data.markers);

  }).error(function(jqXHR, textStatus, errorThrown) {
    var fail;
    fail = "fail: " + jqXHR.responseText;
  });
};
var _getFeatured = function(bounds) {
  return $.ajax({
    url: '/find/featured',
    data: {
      'bounds': bounds,
      'search': $('#advanced-search').serializeJSON()
    },
    dataType: 'json',
    async: true
  }).success(function(data, textStatus, jqXHR) {
  	_getDetails(bounds);
  	$('#featured').empty();
    $('#featured').append(data.data);
  }).error(function(jqXHR, textStatus, errorThrown) {
    var fail;
    fail = "fail: " + jqXHR.responseText;
  });
}
var _getDetails = function(bounds) {
  $('#details').empty();
  $('#details').append('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> Loading...');
  return $.ajax({
    url: '/find/details',
    data: {
      'bounds': bounds,
      'search': $('#advanced-search').serializeJSON()
    },
    dataType: 'json',
    async: true
  }).success(function(data, textStatus, jqXHR) {
  	$('#details').empty();
    $('#details').append(data.data);
  }).error(function(jqXHR, textStatus, errorThrown) {
    var fail;
    fail = "fail: " + jqXHR.responseText;
  });
}

function updateMarkers(map, markersData) 
{
	// Remove current markers
	for (var i = 0; i < markers.length; i++) {
	  markers[i].setMap(null);
	}
	$('#markers_list').empty();
	$('#featured').empty();

	for (var i=0; i < markersData.length; i++) {
		addMarker(markersData[i]);
		//updateTile(markersData[i]);
	}    
};

function updateTile(marker){
	$.ajax({
	  url: 'searches/build_dayhome_tile/' + marker.id,
	  dataType: 'html',
	  async: true
	}).done(function(data, textStatus, jqXHR) {
		if(marker.featured){
	  		$('#featured').append(data);
	  	} else {
	  		$('#markers_list').append(data);
	  	}
	  
	}).fail(function(jqXHR, textStatus, errorThrown) {
	  var fail;
	  return fail = "fail: " + textStatus;
	});
}

var infowindow;
function openInfoWindow(){
	var marker = this;
	
	if(infowindow != null){
    	infowindow.close()
	} else {
		infowindow = new google.maps.InfoWindow();
	}
	$.ajax({
	  url: 'find/infowindow/' + marker.id,
	  dataType: 'html',
	  async: true
	}).done(function(data, textStatus, jqXHR) {
	  adjusting = true;
	  infowindow.setContent(data);
	  infowindow.open(map,marker);
	  //return infowindow.open(Gmaps.store.handler.getMap(), clicked);
	}).fail(function(jqXHR, textStatus, errorThrown) {
	  var fail;
	  fail = "fail: " + textStatus;
	});
}

// Adds a marker to the map and push to the array.
function addMarker(location) {
    var marker = new google.maps.Marker({
      title: location.slug,
      id: location.id,
      position: location,
      map: map,
      icon: location.featured?(location.accredited?dayhomeFeaturedMarker:privateDayhomeFeaturedMarker):(location.licensed?dayhomeMarker:privateDayhomeMarker)
    });
    marker.addListener('click', openInfoWindow);	
    markers.push(marker);
}
function geocodeAddress(geocoder, resultsMap) {
	var address = document.getElementById('searchQuery').value;
	geocoder.geocode({'address': address}, function(results, status) {
	  if (status === 'OK') {
	    resultsMap.setCenter(results[0].geometry.location);
	    var bounds= {
		     SW: resultsMap.getBounds().getSouthWest().toJSON(),
		     NE: resultsMap.getBounds().getNorthEast().toJSON()
		};
		_getMarkers(bounds);
	  } else {
	    alert('Geocode was not successful for the following reason: ' + status);
	  }
	});
}
var adjusting = false;
var mapDisplayed = false;
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
	  center: {lat: 53.565339, lng: -113.492602},
	  zoom: 6
	});
	google.maps.event.addListenerOnce(map, 'center_changed', function(event) {
	  if (this.getZoom() < 12) {
	    this.setZoom(12);
	  }
	 //  if(typeof loadMarkers != 'undefined')
		// loadMarkers();
		mapDisplayed = true;
	});



	// Try HTML5 geolocation.
	if (navigator.geolocation) {
	  navigator.geolocation.getCurrentPosition(function(position) {
	    var pos = {
	      lat: position.coords.latitude,
	      lng: position.coords.longitude
	    };
	    if(loc != null){
	    	pos = loc;
	    }

	    // infoWindow = new google.maps.InfoWindow({map: map});
	    // infoWindow.setPosition(pos);
	    // infoWindow.setContent('<h1>Location found.</h1><div>You are home.</div>');
	    map.setCenter(pos);

	  }, function() {
	  	var infoWindow = new google.maps.InfoWindow({map: map});
	    handleLocationError(true, infoWindow, map.getCenter());
	  });
	} else {
	  var infoWindow = new google.maps.InfoWindow({map: map});
	  // Browser doesn't support Geolocation
	  handleLocationError(false, infoWindow, map.getCenter());
	}

	
	//Listeners
	google.maps.event.addListener(map, 'idle', function(event){
		if(!adjusting && mapDisplayed){
		  var bounds= {
			     SW: this.getBounds().getSouthWest().toJSON(),
			     NE: this.getBounds().getNorthEast().toJSON()
			};
			_getMarkers(bounds);
		}
		if(adjusting)
			adjusting = false;
	});
	var geocoder = new google.maps.Geocoder();
    // document.getElementById('submit_location').addEventListener('click', function() {
    //   geocodeAddress(geocoder, map);
    // });
    $("input:checkbox.filter").on('click', function() {
		var bounds= {
		     SW: map.getBounds().getSouthWest().toJSON(),
		     NE: map.getBounds().getNorthEast().toJSON()
		};
		_getMarkers(bounds);
    });

}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow.setContent(browserHasGeolocation ?
	                      'Error: The Geolocation service failed.' :
	                      'Error: Your browser doesn\'t support geolocation.');
}

$(document).ready(function() {

  $(document).on('click', '#showSearchLink', function() {
    $('#showSearch').toggle();
    $('#hideSearch').toggle();
  });
  $(document).on('click', '#hideSearchLink', function() {
    $('#showSearch').toggle();
    $('#hideSearch').toggle();
  });
  
  $(document).on('click', '.markerCallout', function() {
	var i, railsmarker, slug;
	slug = $(this).attr('id');
	i = 0;
	while (i < markers.length) {
		railsmarker = markers[i];
		if (railsmarker.getTitle() && railsmarker.getTitle().indexOf(slug) >= 0) {
		  adjusting = true;
		  google.maps.event.trigger(railsmarker, 'click');
		  break;
		}
		i++;
	}
	$.scrollTo($('#map').position().top - $(window).height() / 2, {
		speed: 'slow'
	});
	return false;
  });

});