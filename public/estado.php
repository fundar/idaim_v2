<?
	$edo = trim($_GET['edo']);
	if ($edo === "" || $edo==32) {
		header('Location: /');
		exit;
	}
	$estados = json_decode(file_get_contents('data/estados.json'));

	$estado = $estados->$edo;

	if (!$estado) {
		header('Location: /');
		exit;
	}
	$datos = json_decode(file_get_contents('data/estados/'.$estado->i.'.json'));
?>
<!DOCTYPE html>
<html>
		<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<title>IDAIM <?= $estado->n ;?> - Índice del Derecho de Acceso a la Información en México</title>
				<meta name="description" content="">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="/css/estado.css">
				<style type="text/css">

    </style>
		</head>
		<body>
			<? include('header.php') ;?>
			
			<script>
			window._edo = '<?= $edo->i ?>';
			</script>

			<article class="container estado">				
				<h2 class="posicion">#<?= $datos->pos ;?></h2>
				<h1><?= $estado->n ;?></h1>
				<div id="graficaEstado"></div>
				<div id="calificacion"><?= $datos->t/10 ?></div>
				<div id="nombre">IDAIM</div>
				<div id="descripcion"></div>

				<a href="/data/fichas/<?= $estado->i ;?>.xlsx">Descarga la ficha de Estado</a>
			</article>
			

			<? include('footer.php') ;?>
			<script src="/js/estado.js"></script>
		</body>
</html>
