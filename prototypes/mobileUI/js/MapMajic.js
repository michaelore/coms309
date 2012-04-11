var map;

function initialize() {
    var myOptions = {
        center: new google.maps.LatLng(-34.397, 150.644),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map_canvas"),
    myOptions);
}
	  
var curLocation = new google.maps.LatLng(34.397, 50.644);
var curLat;
var curLng;
var trackSuccessFlag = false;
var myZoom;	 

//button
function createLocation(){
	track(setLocation);
}
	  
//updates map
function setLocation(){
	var curLocation = new google.maps.LatLng(curLat, curLng);
	var marker;
	myZoom = map.getZoom();
	var mapOptions = {
		zoom: myZoom,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		center: curLocation
	};
	map = new google.maps.Map(document.getElementById('map_canvas'),
	mapOptions);

	marker = new google.maps.Marker({
		map:map,
		draggable:true,
		animation: google.maps.Animation.DROP,
		position: curLocation
	});
	  
}
	  
	  
	 
function success(position) {
	
	 curLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
	  curLat = position.coords.latitude;
	  curLng = position.coords.longitude;
	 trackSuccessFlag = true;
}

function error(msg) {
	var s = document.querySelector('#result');
	var li = document.createElement('li');
	li.innerHTML = msg;
	s.insertBefore(li, s.firstChild);
	alert("error");
}

function track(func) {

	navigator.geolocation.getCurrentPosition(function(position) {success(position); func();}, error, { enableHighAccuracy: true });

}
	  
	  
var locations	  
function createRoute(){
	track(setRoute);
}	  


function setRoute(){	
	var curLocation = new google.maps.LatLng(curLat, curLng);
	var marker;
	var mapOptions = {
		zoom: 13,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		center: curLocation
	};
	map = new google.maps.Map(document.getElementById('map_canvas'),
		mapOptions);

	marker = new google.maps.Marker({
		map:map,
		draggable:true,
		animation: google.maps.Animation.DROP,
		position: curLocation
	});

locations = [    new google.maps.LatLng(curLat, curLng)];
	
	var route = new google.maps.Polyline({
    path: locations,
    strokeColor: "#FF0000",
    strokeOpacity: 1.0,
    strokeWeight: 2
  });
  route.setMap(map);


}

function createPoint(){
	track(setPoint);
}

function setPoint(){

	var curLocation = new google.maps.LatLng(curLat, curLng);
	
	var mapOptions = {
		zoom: 13,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		center: curLocation
	};
	map = new google.maps.Map(document.getElementById('map_canvas'),
		mapOptions);
	
	var marker = new google.maps.Marker({
		map:map,
		draggable:true,
		animation: google.maps.Animation.DROP,
		position: curLocation
	});
	
	locations.push(new google.maps.LatLng(curLat, curLng));
	var route = new google.maps.Polyline({
    path: locations,
    strokeColor: "#FF0000",
    strokeOpacity: 1.0,
    strokeWeight: 2
  });
  route.setMap(map);
}