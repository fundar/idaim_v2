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
				</div>
			</section>

			<section id="nacional" class="sec sec-a">
				<div class="container">
					<h2 class="pc" id="total-nacional"></h2>
					<div id="graph-total">
					</div>
					<div id="total-ultimo">
						<h2 class="pc"></h2>
						<h3></h3>
					</div>
					<div id="total-primero">
						<h2 class="pc"></h2>
						<h3></h3>
					</div>
				
					<div id="textos-ejes">
						<div id="texto-eje-1" class="eje-text">
							<h3>Disposiciones Normativas</h3>
							<p>Es en los objetivos y la conceptualización del DAI donde se establecen las bases y principios que determinaran la interpretación de la ley y guiarán su aplicación. La delimitación de los sujetos obligados y sus obligaciones de transparencia, las disposiciones para el régimen de excepción de la información y el establecimiento de sanciones ante violaciones al derecho e incumplimiento de la ley constituyen los elementos que determinan su alcance.</p>
						</div>

						<div id="texto-eje-2" class="eje-text">
							<h3>Diseño Institucional</h3>
							<p>Esta variable mide las disposiciones en ley que fundamentan la construcción del engranaje institucional que deberá proteger, respetar, promover y garantizar el ejercicio del derecho de acceso a la información. Son tres figuras las que se contemplan como básicas: el órgano garante, su autonomía y alcance de funciones;  las oficinas de información y los órganos internos de revisión.</p>
						</div>

						<div id="texto-eje-3" class="eje-text">
							<h3>Procedimiento de Acceso a la Información y Obligaciones de Transparencia</h3>
							<p>Los principios y bases del DAI deben verse reflejados en las garantías que la ley establezca para el cumplimiento de este derecho. Es en el procedimiento de acceso a la información así como en la difusión de las obligaciones de transparencia donde se materializa la satisfacción del DAI. En esta variable se mide la universalidad,  facilidad, expeditez y gratuidad de este derecho, así como las medidas proactivas que se tomen para dar a conocer información relevante.</p>
						</div>
					</div>
				</div>
			</section>

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
