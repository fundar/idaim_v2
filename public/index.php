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
				<style type="text/css">

    </style>
		</head>
		<body>
			<!--[if lt IE 8]>
					<p class="browsehappy">Estás usando un navegador <strong>anticuado</strong>. Por favor <a href="http://browsehappy.com/?locale=es">actualiza tu navegador</a> para mejorar tu experiencia.</p>
			<![endif]-->
				<div id="geolocated">

				</div>

			<header>
				<div class="container">
					<a href="#" id="logo">IDAIM</a>
					<nav id="nav-principal">
							<ul class="nav-paginas">
									<li><a href="">Quiénes somos</a></li>
									<li><a href="">Acerca de</a></li>
									<li><a href="">Contacto</a></li>
							</ul>

							<ul class="nav-social">
									<li><a class="ss-icon ss-social-regular" href="">email</a></li>
									<li><a class="ss-icon ss-social-regular" href="">tumblr</a></li>
									<li><a class="ss-icon ss-social-regular" href="">facebook</a></li>
							</ul>
					</nav>
				</div>
			</header>

			<section id="hero">
				<div class="container">
					<div id="hero-text">
						<span class="hero-text l1">El IDAIM</span>
						<span class="hero-text l2">mide las</span>
						<span class="hero-text l3">Leyes de Transparencia</span>
						<span class="hero-text l4">y acceso a la</span>
						<span class="hero-text l5">Información en México</span>
						<span class="hero-text l6">con relación a las</span>
						<span class="hero-text l7">mejores prácticas</span>
						<span class="hero-text l8">Nacionales e Internacionales</span>
					</div>
					<div id="mapita"></div>
				</div>
			</section>

			<section id="nacional" class="sec sec-a">
				<div class="container cf">
					<div id="texto-variable">
						<h3 id="nombre-variable">IDAIM</h3>
						<p id="descripcion-variable" style="display:none;"></p>
					</div>

					<div class="texto-total" id="total-nacional-cont">
						<h2 class="pc" id="total-nacional"></h2>
						<h3 id="total-nombre">Promedio Nacional</h3>
					</div>

					<div id="graph-total">
					</div>
					<div id="total-ultimo" class="texto-total">
						<h2 class="pc"></h2>
						<h3></h3>
					</div>
					<div id="total-primero" class="texto-total">
						<h2 class="pc"></h2>
						<h3></h3>
					</div>
				</div>

			<section id="indice-nacional" class="sec sec-b">
				<div class="container">
					<div id="graph-indices-nacional"></div>
				</div>
			</section>

			<section id="mapa" class="sec sec-a">
				<div class="container">
					<?= file_get_contents('./img/mapa.svg') ;?>
				</div>
			</section>

			<footer>
				<div class="container">
					<a href="#" id="logo-fundar"></a>

					<nav id="nav-footer">
							<ul class="footer-paginas">
									<li><a href="">Quiénes somos</a></li>
									<li><a href="">Acerca de</a></li>
									<li><a href="">Contacto</a></li>
									<li><a href="">IDAIM 2010</a></li>
							</ul>

							<ul class="footer-otros">
									<li><a href="">Aviso de Privacidad</a></li>
									<li><a href="">Ayuda</a></li>
							</ul>
					</nav>

					<div id="copyright">&copy; 2014 Fundar. Todos los derechos reservados</div>
				</div>
			</footer>
			<script src="/js/main.js"></script>
		</body>
</html>
