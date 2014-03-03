<!DOCTYPE html>
<?php require('../lib/geo.php'); ?>
<html>
<head>
	<meta charset="utf-8" />
	<title>IDAIM</title>
</head>
<body>
		<p class="rerver"><strong>Server:</strong> <?= $regiones[$region-1] ? : "No tenemos región de servidor"; ?></p>
		<p><strong>Navigator.geolocation:</strong> <span class="location">cargando...</span></p>
	</body>
	<script>var regiones = <?=json_encode($regiones);?>;</script>
	<script src="js/test.js"></script>
</body>
</html>