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
			<div class="container">
				<div id="geolocated">

				</div>

				<header>
						<a href="#" id="logo">IDAIM</a>
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
				</header>
			</div>

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
				</div>
			</section>

			<section class="sec-a">
				<div class="container">
					<div>Estás visitándonos desde</div>
					<h1>Aguascalientes</h1>
				</div>
			</section>



			<section id="nacional" class="sec-b">
				<div class="container">
					<h2 class="pc" id="total-nacional"></h2>
					<div class="graph-total">

					</div>
					<div id="total-ultimo">
						<h2 class="pc"></h2>
						<h3></h3>
					</div>
					<div id="total-primero">
						<h2 class="pc"></h2>
						<h3></h3>
					</div>
				</div>
			</section>

			<section id="indice-nacional">
				<div class="container">
					<div id="graph-indices-nacional">
						
					</div>
				</div>
			</section>

			<section id="mapa">
				<div class="container">
					<?= file_get_contents('./img/mapa.svg') ;?>
				</div>
			</section>

			<section class="sec-a">
				<div class="container">
					Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
				</div>
			</section>
			<footer>
				<div class="container">
					<div id="logo-fundar"></div>
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
				</div>
			</footer>
			<script src="/js/main.js"></script>
		</body>
</html>
