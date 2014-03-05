<!DOCTYPE html>
<?php require('../lib/geo.php'); ?>
<html>
		<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<title>IDAIM - Índice del Derecho de Acceso a la Información en México</title>
				<meta name="description" content="">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="css/main.css">
		</head>
		<body>
			<!--[if lt IE 8]>
					<p class="browsehappy">Estás usando un navegador <strong>anticuado</strong>. Por favor <a href="http://browsehappy.com/?locale=es">actualiza tu navegador</a> para mejorar tu experiencia.</p>
			<![endif]-->

			<header>
					<div id="logo"></div>
					<nav>
							<ul>
									<li><a href="">Quiénes somos</a></li>
									<li><a href="">Acerca de</a></li>
									<li><a href="">Contacto</a></li>
							</ul>

							<ul>
									<li><a href="">email</a></li>
									<li><a href="">twitter</a></li>
									<li><a href="">facebook</a></li>
							</ul>
					</nav>

					<p class="server"><strong>Server:</strong> <?= $regiones[$region-1] ? : "No tenemos región de servidor"; ?></p>
					<p><strong>Navigator.geolocation:</strong> <span class="location">cargando...</span></p>

			</header>

			<section>
					<div>Estás visitándonos desde</div>
					<h1>Aguascalientes</h1>

			</section>

			<section>

			</section>

			<section>

			</section>

			<footer>
					<div id="copyright">&copy; 2014 Fundar. Todos los derechos reservados</div>
					<nav>
							<ul>
									<li><a href="">Quiénes somos</a></li>
									<li><a href="">Acerca de</a></li>
									<li><a href="">Contacto</a></li>
									<li><a href="">IDAIM 2010</a></li>
							</ul>

							<ul>
									<li><a href="">Aviso de Privacidad</a></li>
									<li><a href="">Ayuda</a></li>
							</ul>
					</nav>
			</footer>
			<script>var regiones = <?=json_encode($regiones);?>;</script>
			<script src="js/test.js"></script>
		</body>
</html>
