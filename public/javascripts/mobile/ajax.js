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

function postLocation(lat, lng, name, se){
	$.ajax({
        type: "POST",
        url: '/locations',
        data: { _method:'POST', "location[latitude]": lat, "location[longitude]": lng, "location[name]": name},
        dataType: 'json',
        success: function(msg) {
			//alert( "Data Saved: " + msg );
			//window.parent.$routeID = msg.location.id;
			if (se == "s")
			{
				window.frames[0].startid = msg.location.id;
			}
			else
			{
				window.frames[0].endid = msg.location.id;
			}
        },
		error: function(msg) {
			alert( "Error: " + msg );
        }
	});
}



function postRoute(latlng, idstart, idend, time){
	
	var lat;
	var lng;
	
	for(var i = 0; i < latlng.length;i++){
		lat.push(latlng[i].lat);
		lng.push(latlng[i].lng);
	}
	
	$.ajax({
        type: "POST",
        url: '/routes',
        data: { _method:'POST', "route[lat]" : lat, "route[lon]" : lng, "route[start_id]": idstart, "route[ending_id]": idend, "route[time]": time },
        dataType: 'json',
        success: function(msg) {
			alert( "Data Saved: " + msg );
        },
		error: function(msg) {
			alert( "Error: " + msg );
        }
	});
}

function ldfav(id, todo){
	//POST    /routes/3/like
	//POST    /routes/3/dislike
	//POST    /routes/3/favorite
	var $id = id;
	$.post("/routes/" + $id + "/" + todo, function(data) {
	  //alert("Data Loaded: " + JSON.stringify(data));
		if (data.liked == 1)
		{
			//switch like button to checkmark and dislike button to arrow-d
			$("#like").attr('data-icon', 'check'); 
			$("#like .ui-icon").addClass("ui-icon-check").removeClass("ui-icon-arrow-u");
			$("#dislike").attr('data-icon', 'arrow-d'); 
			$("#dislike .ui-icon").addClass("ui-icon-arrow-d").removeClass("ui-icon-check");
		}
		else if (data.liked == 0)
		{
			//set like button to arrow-u and dislike button to arrow-d
			$("#like").attr('data-icon', 'arrow-u'); 
			$("#like .ui-icon").addClass("ui-icon-arrow-u").removeClass("ui-icon-check");
			$("#dislike").attr('data-icon', 'arrow-d'); 
			$("#dislike .ui-icon").addClass("ui-icon-arrow-d").removeClass("ui-icon-check");
		}
		else
		{
			//dislike is currently selected b/c data.liked == -1
			//set dislike button to check and like to arrow-u
			$("#like").attr('data-icon', 'arrow-u'); 
			$("#like .ui-icon").addClass("ui-icon-arrow-u").removeClass("ui-icon-check");
			$("#dislike").attr('data-icon', 'check'); 
			$("#dislike .ui-icon").addClass("ui-icon-check").removeClass("ui-icon-arrow-u");
		}
		if (data.favorite == 1)
		{
			//set favorite icon to check b/c it's currently favorited
			$("#favorite").attr('data-icon', 'check'); 
			$("#favorite .ui-icon").addClass("ui-icon-check").removeClass("ui-icon-star");
		}
		else
		{
			//otherwise it's not favorited, so we need to set the icon to the star
			$("#favorite .ui-icon").addClass("ui-icon-star").removeClass("ui-icon-check");
		}
	});
}

/*
function pullLocation(id){
	
}

*/

function pullRouteData(id){
//http://digitravel.herokuapp.com/routes/3.json
//{"start":"UDCC","ending":"Parks Library","likes":0,"dislikes":0,"favorite":0,"distance":434.3532741670897}
	var $id = id;
	$.get("/routes/" + $id + ".json",
   function(data){
		//setup the like/dislike/favorite buttons on the page accordingly
		if (data.liked == 1)
		{
			//switch like button to checkmark and dislike button to arrow-d
			$("#like").attr('data-icon', 'check'); 
			$("#like .ui-icon").addClass("ui-icon-check").removeClass("ui-icon-arrow-u");
			$("#dislike").attr('data-icon', 'arrow-d'); 
			$("#dislike .ui-icon").addClass("ui-icon-arrow-d").removeClass("ui-icon-check");
		}
		else if (data.liked == 0)
		{
			//set like button to arrow-u and dislike button to arrow-d
			$("#like").attr('data-icon', 'arrow-u'); 
			$("#like .ui-icon").addClass("ui-icon-arrow-u").removeClass("ui-icon-check");
			$("#dislike").attr('data-icon', 'arrow-d'); 
			$("#dislike .ui-icon").addClass("ui-icon-arrow-d").removeClass("ui-icon-check");
		}
		else
		{
			//dislike is currently selected b/c data.liked == -1
			//set dislike button to check and like to arrow-u
			$("#like").attr('data-icon', 'arrow-u'); 
			$("#like .ui-icon").addClass("ui-icon-arrow-u").removeClass("ui-icon-check");
			$("#dislike").attr('data-icon', 'check'); 
			$("#dislike .ui-icon").addClass("ui-icon-check").removeClass("ui-icon-arrow-u");
		}
		if (data.favorite == 1)
		{
			//set favorite icon to check b/c it's currently favorited
			$("#favorite").attr('data-icon', 'check'); 
			$("#favorite .ui-icon").addClass("ui-icon-check").removeClass("ui-icon-star");
		}
		else
		{
			//otherwise it's not favorited, so we need to set the icon to the star
			$("#favorite .ui-icon").addClass("ui-icon-star").removeClass("ui-icon-check");
		}		
		//set the distance portion of the page
		document.getElementById('distance').innerHTML = "Distance: " + data.distance + " meters";
   });
}

function pullRouteCoordinates(id){
	var $id = id;
	$.get("/routes/" + $id + "/coordinates.json",
   function(data){
	 //alert("Data Loaded: " + JSON.stringify(data));
	 grabRouteCall(data);
   });
}

function searchByKeyword(s, e){
	$.get("/routes/search", { start: s, ending: e },
   function(data){
	 //alert("Data Loaded: " + data);//JSON.stringify(data));
	 $("ul").empty();
	 $("#content ul").append(data);
	 $('ul').listview('refresh');
   });
};

function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}
