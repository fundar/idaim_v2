<!DOCTYPE html>
<?php require('../lib/geo.php'); 
	$geoip = geo();
?>
<html>

<head>
	<title>IDAIM - Índice del Derecho de Acceso a la Información en México</title>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<meta name="generator" content="Geany 0.21" />
	<link rel="stylesheet" href="css/index.css">
</head>

<body>
	<script>
		window._geoip = <?= $geoip ?>;
	</script>
	
	<section id="nacional" class="sec sec-a">
		<div class="container cf">
			<div id="geolocation">
				<h3>Estás visitándonos desde</h3>

				<div id="select-estado">
					<img src="/img/flecha-roja.png" />
					<select id="geo-select-estado">
						<? $edos = json_decode(file_get_contents('data/estados.json'));
							foreach($edos as $id => $info):
								$checked = $geoip == $id;
								$checked = $geoip=='false' && $id==32? true : $checked;
						?>
						<option value="<?= $id ;?>" <?= $checked ? 'selected' : '' ;?> ><?= $info->n ;?>
						</option>
						<? endforeach; ?>
					</select>
				</div>

				<br />
				<ul>
					<li id="breadcrumb-total" class="breadcrumb active-breadcrumb" data-parent="#gn-total-idaim">
						<a href="#">Estado</a>
					</li>
					<li id="breadcrumb-eje" class="breadcrumb">
						<a href="#" >&gt; Calificación del eje</a>
					</li>
					<li id="breadcrumb-indicador" class="breadcrumb">
						<a href="#">&gt; Calificación del indicador</a>
					</li>
					<li id="breadcrumb-criterio" class="breadcrumb">
						<a href="#">&gt; Calificación del criterio</a>
					</li>
				</ul>
			</div>

			<h3 id="nombre-variable">IDAIM</h3>

			<div class="texto-total" id="total-nacional-cont">
				<h2 class="pc" id="total-nacional"></h2>
				<h3 id="total-nombre">Promedio Nacional</h3>
			</div>

			<div id="graph-total"></div>

			<div class="cf">
				<div id="total-ultimo" class="texto-total">
					<div>El Peor</div>
					<h2 class="pc"></h2>
					<h3></h3>
				</div>
				<div id="total-primero" class="texto-total">
					<div>El Mejor</div>
					<h2 class="pc"></h2>
					<h3></h3>
				</div>
			</div>

			<div class="descripcion-variable">
				<p id="descripcion-variable"></p>
			</div>

			<div class="separador cf"></div>

			<div class="escala cf">
				<div class="titulo">Escala</div>
				<div class="escala-barras">
					<div class="escala-barra-cont">
						<div class="barrita rojo"></div>
						<div class="descr rojo">0 - 5.9</div>
					</div>

					<div class="escala-barra-cont">
						<div class="barrita amarillo"></div>
						<div class="descr amarillo">6 - 7.9</div>
					</div>

					<div class="escala-barra-cont">
						<div class="barrita verde"></div>
						<div class="descr verde">8 - 10</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<script src="/js/main.js"></script>
</body>

</html>
