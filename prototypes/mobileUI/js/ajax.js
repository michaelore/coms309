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