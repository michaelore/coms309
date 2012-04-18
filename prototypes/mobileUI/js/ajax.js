//look at here for post/put/get/delete magic: http://stackoverflow.com/questions/907910/how-do-i-put-data-to-rails-using-jquery
function fillRecentActivity(){
	$.get(
    	"/ajax/getRecentActivity/",
    	function(data) {
       		$("#recentactivityplace").html(data);
    	}
	);
}

function fillContactQueue(){
	$.get(
    	"/ajax/getContactQueue/",
    	function(data) {
       		$("#callcontactQueue").html(data);
    	}
	);
}

function fillMyContacts(){
	$.get(
    	"/ajax/getMyContacts/",
    	function(data) {
       		$("#mycontactsplace").html(data);
    	}
	);
}

function postLocation(lat, lng, name, acu){
	$.ajax({
        type: "POST",
        url: 'digitravel.heroku.com/locations',
        data: { _method:'POST', page : {Latitude : lat, Longitude: lng, Name: name, Accuracy: acu} },
        dataType: 'json',
        success: function(msg) {
			alert( "Data Saved: " + msg );
        }
		error: function(msg) {
			alert( "Error: " + msg );
        }
	});
}



function postRoute(latlng, idstart, idend, acu, time){
	
	var lat;
	var lng;
	
	for(var i = 0; i < latlng.length();i++){
		lat.push(latlng[i].lat());
		lng.push(latlng[i].lng());
	}
	
	$.ajax({
        type: "POST",
        url: '/admin/pages/1.json',
        data: { _method:'POST', page : {Latitude : lat, Longitude: lng, Start Location: idstart, End Location: idend, Accuracy: acu, Time: time} },
        dataType: 'json',
        success: function(msg) {
			alert( "Data Saved: " + msg );
        }
		error: function(msg) {
			alert( "Error: " + msg );
        }
	});
	
}

function like(){
	
}


function dislike(){
	
}


function favorite(){
	
	
	
}


function pullLocation(id){
	
}


function pullRoute(id){
	
	
	
}

function searchByKeyWord(keyword){



}


function searchByCorrdinates(){



}

