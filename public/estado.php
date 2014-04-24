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
				<h1><?= $estado->n ;?></h1>
				<div class="texto-descriptivo">
					<p>El IDAIM se compone de tres variables que pueden identificarse con cada uno de los tres cuadros que se ven en la figura de abajo. De izquierda a derecha son: Disposiciones normativas, Diseño institucional y Procedimiento de acceso a la información y obligaciones de transparencia. Éstas se encontrarán en el color que represente su calificación general.</p>
					<p>Al darle clic a cada variable aparecerá su estructura interna conformada por siete, cinco y nueve indicadores respectivamente. Éstos se podrán observar en el color que corresponda a su calificación. En la parte inferior de la gráfica se podrá observar el nombre del indicador y la calificación que obtuvo.</p>
					<p>Para conocer el detalle de cada indicador, se puede dar clic en el mismo y aparecerán los criterios los cuales se presentarán en color verde o rojo según esté o no contemplado en la ley.</p>
				</div>
				<div class="posicion">
					<span>Ranking nacional</span>
					<h2 class="no">#<?= $datos->pos ;?></h2>
				</div>
				<div id="graficaEstado"></div>
				<div id="calificacion"><?= $datos->t/10 ?></div>
				<div id="nombre">IDAIM</div>
				<div id="descripcion"></div>
			</article>
			

			<? include('footer.php') ;?>
			<script src="/js/estado.js"></script>
		</body>
</html>
