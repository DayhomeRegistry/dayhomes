
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
    updateMarkers(map,data.markers);
  }).error(function(jqXHR, textStatus, errorThrown) {
    var fail;
    fail = "fail: " + jqXHR.responseText;
  });
};

function updateMarkers(map, markersData) 
{
	// Remove current markers
	for (var i = 0; i < markers.length; i++) {
	  markers[i].setMap(null);
	}

	for (var i=0; i < markersData.length; i++) {
		addMarker(markersData[i]);
	}    
};


// Adds a marker to the map and push to the array.
function addMarker(location) {
    var marker = new google.maps.Marker({
      position: location,
      map: map
    });
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
	google.maps.event.addListener(map, 'idle', function(event){
		if(mapDisplayed){
		  var bounds= {
			     SW: this.getBounds().getSouthWest().toJSON(),
			     NE: this.getBounds().getNorthEast().toJSON()
			};
			_getMarkers(bounds);
		}
	});
	map.addListener('click', function(event) {
      addMarker(event.latLng);
    });

	var geocoder = new google.maps.Geocoder();

    document.getElementById('submit_location').addEventListener('click', function() {
      geocodeAddress(geocoder, map);
    });

	//var infoWindow;

	// Try HTML5 geolocation.
	if (navigator.geolocation) {
	  navigator.geolocation.getCurrentPosition(function(position) {
	    var pos = {
	      lat: position.coords.latitude,
	      lng: position.coords.longitude
	    };

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

	
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow.setContent(browserHasGeolocation ?
	                      'Error: The Geolocation service failed.' :
	                      'Error: Your browser doesn\'t support geolocation.');
}