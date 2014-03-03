<!DOCTYPE html>
<?php require('./lib/geo.php'); ?>
<html>
<head>
	<meta charset="utf-8" />
	<title>IDAIM</title>
</head>
<body>
		<p class="rerver"><strong>Server:</strong> <?= $regiones[$region-1] ? : "No tenemos región de servidor"; ?></p>
		<p><strong>Navigator.geolocation:</strong> <span class="location">cargando...</span></p>
	</body>
	<script>
	var regiones = <?=json_encode($regiones);?>;
	var clase = 'location';
	var loc = document.querySelector && document.querySelector('.'+clase) || document.getElementsByClassName(clase);
	var el = loc[0];
	var rgeo = 'http://api.geonames.org/countrySubdivisionJSON';
	
	var yay = function(pos){
		var req = new XMLHttpRequest();
		loc.innerText = "Geocoding...";
		var addr = rgeo+"?username=unrob&lat="+pos.coords.latitude+"&lng="+pos.coords.longitude;
		console.log("geocoding "+ addr);
		req.open('GET', addr);
		req.send();
		req.onload = function() {
			res = JSON.parse(this.response);
			var id = parseInt(res.adminCode1, 10);
			loc.innerText = regiones[id-1];
		};
	};
	
	/*
	Opciones: 
	http://nominatim.openstreetmap.org/reverse?format=json&lat=19.50575303048478&lng=-99.16582604514967
	http://ws.geonames.org/countrySubdivision?lat=19.50575303048478&lng=-99.16582604514967&username=unrob
	http://maps.googleapis.com/maps/api/geocode/json?languate=es_mx&sensor=true&latlng=19.50575303048478,-99.16582604514967
	*/
	
	var nay = function(msg){
		console.log(arguments);
		msg = msg.message || "No tenemos geolocation";
		loc.innerText = msg;
	};
	
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(yay, nay);
	} else {
		nay();
	}
	</script>
</body>
</html>