<?
	$edo = trim($_GET['edo']);
	if (!$edo || $edo=='nal') {
		header('Location: /');
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
		header('Location: /');
		exit;
	}
	$datos = json_decode(file_get_contents('data/estados/'.$edo.'.json'));
?>
<!DOCTYPE html>
<html>
		<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<title>IDAIM <?= $nombreEstado ;?> - Índice del Derecho de Acceso a la Información en México</title>
				<meta name="description" content="">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="/css/estado.css">
				<style type="text/css">

    </style>
		</head>
		<body>
			<? include('header.php') ;?>
			
			<script>
			window._edo = '<?= $edo ?>';
			</script>

			<article class="container estado">				
				<h2 class="posicion">#<?= $datos->pos ;?></h2>
				<h1><?= $nombreEstado ;?></h1>
				<div id="graficaEstado"></div>
				<div id="calificacion"><?= $datos->t ?>%</div>
				<div id="nombre">IDAIM</div>
				<div id="descripcion"></div>
			</article>
			

			<? include('footer.php') ;?>
			<script src="/js/estado.js"></script>
		</body>
</html>
