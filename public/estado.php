<?
	$edo = trim($_GET['edo']);
	if (!$edo || $edo=='nal') {
		header('Location: /estado/dif');
		exit;
	}
	$estados = json_decode(file_get_contents('data/estados.json'));
	$nombreEstado = '';

	foreach($estados as $estado){
		if ($estado->i == $edo) {
			$nombreEstado = $estado->n;
			break;
		}
	}
	if (!$nombreEstado) {
		header('Location: /estado/dif');
		exit;
	}
	$datos = json_decode(file_get_contents('data/estados/'.$edo.'.json'));
?>
<!DOCTYPE html>
<html>
		<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<title>IDAIM - Índice del Derecho de Acceso a la Información en México</title>
				<meta name="description" content="">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="/css/estado.css">
				<style type="text/css">

    </style>
		</head>
		<body>
			<!--[if lt IE 8]>
					<p class="browsehappy">Estás usando un navegador <strong>anticuado</strong>. Por favor <a href="http://browsehappy.com/?locale=es">actualiza tu navegador</a> para mejorar tu experiencia.</p>
			<![endif]-->
			<script>
			window._edo = '<?= $edo ?>';
			</script>

			<header>
				<div class="container">
					<a href="/" id="logo">IDAIM</a>
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


			<article class="container estado">				
				<h1><?= $nombreEstado ;?></h1>
				<div id="graficaEstado"></div>
				<div id="calificacion"><?= $datos->t ?>%</div>
				<div id="nombre">IDAIM</div>
				<div id="descripcion"></div>
			</article>
			

			<footer>
				<div class="container">
					<a href="http://fundar.org.mx" id="logo-fundar"></a>

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
			<script src="/js/estado.js"></script>
		</body>
</html>
